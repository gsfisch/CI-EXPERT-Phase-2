
module Addresser #(
    parameter ADDR_WIDTH = 12,    // Largura do endereço
    parameter DATA_WIDTH = 16     // Largura dos dados
)(
    input  logic                  clk,          // 100 MHz clock
    input  logic                  reset,        // Active-low reset
    input  logic                  i_ss,         // Slave select (high for active/incremental operation)
    input  logic                  i_ready,      // Valid data indicator
    input  logic [DATA_WIDTH-1:0] i_data,       // 16-bit input data
    input  logic                  i_PREADY,     // APB ready signal
    input  logic                  i_hds_ready,
    output logic                  o_ack,
    output logic                  o_rw,         // Read/write control (1 = read, 0 = write)
    output logic [ADDR_WIDTH-1:0] o_addr,       // 12-bit address to APB
    output logic [DATA_WIDTH-1:0] o_data,       // 16-bit data to APB (for writes)
    output logic                  o_Transfer    // Transfer initiation signal
);

    // State machine states
    typedef enum logic [2:0] {
        IDLE,              // Waiting for operation start
        WAITING_OP_PACKET,    // Waiting for operation + address packet
        ACK,
        READ_SETUP,        // Setup read operation
        WRITE_WAITING_DATA,   // Wait for data packet for write
        WRITE_SETUP,       // Setup write operation
        WAITING_PREADY  // Wait for APB ready for write
    } state_t;

    state_t state, next_state;         // Current state
    logic [11:0] addr_reg; // Register to hold current address
    logic [15:0] data_reg; // Register to hold write data
    logic [3:0]  op_type;  // Operation type (0 = read, 1 = write)
    logic ready_threshold;
    logic pready_flag = 0;

    always_ff @(posedge clk or negedge reset) begin
        if(!reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        if(!reset) begin
            o_ack = 0;
            o_Transfer = 0;
        end else begin

            case(state)
                IDLE: begin
                    o_Transfer = 0;    // Start transfer
                    o_ack = 0;
                end

                WAITING_OP_PACKET: begin
                    o_Transfer = 0;
                    o_ack = 0;
                end

                ACK: begin
                    o_Transfer = 0;
                    o_ack = 1;
                end

                READ_SETUP: begin
                    o_Transfer = 1;    // Start transfer
                    o_ack = 0;
                end

                WRITE_WAITING_DATA: begin
                    o_Transfer = 0;
                    o_ack = 0;
                end

                WRITE_SETUP: begin
                    o_Transfer = 1;    // Start transfer
                    o_ack = 1;
                end

                WAITING_PREADY: begin
                    o_Transfer = 0;
                    o_ack = 0;
                end

                default begin
                    o_Transfer = 0;
                    o_ack = 0;
                end
            endcase
        end
    end

    always_comb begin
        if(!reset)begin
            op_type = 0;
            addr_reg = 0;
            data_reg = 0;
        end else begin
            case (state)
                WAITING_OP_PACKET: begin
                    if(i_ready)begin
                        op_type = i_data[15:12];      // Operation type from bit 15
                        addr_reg = 12'b111111111110 & i_data[11:0];      // Address from bits 11:0
                    end else begin
                        op_type = op_type;
                        addr_reg = addr_reg;
                    end
                end
                WRITE_WAITING_DATA: begin
                    if(i_ready) begin
                        data_reg = i_data; // Capture data packet
                    end else begin
                        data_reg = data_reg;
                    end
                end
            endcase
        end
    end

    always_comb begin
        if (!reset) begin
            next_state <= IDLE;
            o_rw <= 0;
            o_addr <= 0;
            o_data <= 0;
        end else begin
            case (state)
                IDLE: begin
                    pready_flag <= 0;
                    if (i_ss) begin // Start when i_ss is high (active)
                        next_state <= WAITING_OP_PACKET;
                    end
                end

                WAITING_OP_PACKET: begin
                    pready_flag <= 0;
                    if (i_ready) begin
                        next_state <= ACK;
                    end
                end

                ACK: begin
                    pready_flag <= 0;
                    next_state <= (op_type)? WRITE_WAITING_DATA : READ_SETUP;
                end

                READ_SETUP: begin
                    pready_flag <= 0;
                    o_addr <= addr_reg;
                    o_rw <= 0;          // Indicate read
                    next_state <= WAITING_PREADY;
                end

                WRITE_WAITING_DATA: begin
                    pready_flag <= 0;
                    if (i_ready) begin
                        next_state <= WRITE_SETUP;
                    end else begin
                        ready_threshold <= 0;
                        next_state <= WRITE_WAITING_DATA;
                    end
                end

                WRITE_SETUP: begin
                    pready_flag <= 0;
                    o_addr <= addr_reg;
                    o_data <= data_reg;
                    o_rw <= 1;          // Indicate write
                    next_state <= WAITING_PREADY;
                 end

                WAITING_PREADY: begin
                    if (i_PREADY) begin
                        pready_flag <= 1;
                        if(!i_ss) begin
                            next_state <= IDLE;
                        end else begin
                            if(op_type)begin
                               addr_reg <= addr_reg + 2;
                               next_state <= WRITE_WAITING_DATA;
                            end else begin
                               if(!i_hds_ready) begin
                                next_state <= READ_SETUP;
                                addr_reg <= addr_reg +2;
                            end else begin
                                next_state <= WAITING_PREADY;
                            end
                            end
                        end
                    end else begin
                        if(i_ss && !op_type && pready_flag) begin
                            if(!i_hds_ready) begin
                                pready_flag <= 0;
                                next_state <= READ_SETUP;
                                addr_reg <= addr_reg +2;
                            end else begin
                                pready_flag <= 1;
                                next_state <= WAITING_PREADY;
                            end
                        end else begin
                            next_state <= WAITING_PREADY;
                        end
                    end
                end

                default: next_state <= IDLE;
            endcase
        end
    end


endmodule
