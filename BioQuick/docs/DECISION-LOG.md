# Decision log

This file contains the decision log made by the team.
DATE DESCENDING.

## SPI CRC on each 16-bit block

**DATE**: 12/06/2025

**DECISION**: The SPI CRC shall be present after each 16-bit block.

**REASON**: Placing a CRC block after every 16-bit block makes easier the logic to validate all CRC information, since the both receive and send data is 16-bit wide, threating only the first block as 32-bit would increase logic complexity, making additional logic or states in FSM.

## APB data width

**DATE**: 11/06/2025

**DECISION**: The data width used in the APB bus shall be 32 bits.

**REASON**: Although the APB specification allows for different data sizes, most implementations use 32 bits, which will be used for compatibility.

## Interface width between low and high frequency 

**DATE**: 11/06/2025

**DECISION**: The data width between low and high frequency shall be 16 bits.

**REASON**: Although the operation code is 1 bit and the address size is 12 bits wide, the SPI input data width is 16 bits. The operation can be increased to fit in 4 bits, so the first block is 16 bits wide, making it easyer to transfer data from the two clock domains and simplifying the state machine logic afterwards.

## CRC posision in the circuit

**DATE**: 11/06/2025

**DECISION**: There shall be only ONE CRC block in the circuit, located at the SPI side, which means lower frequency.

**REASON**: CRC calculantion can be made "on the fly", which does not add much latency (1 clock cycle), since there will be enouth time for the high frequency core to process the command and data.