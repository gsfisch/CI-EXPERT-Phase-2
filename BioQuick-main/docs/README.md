# Documentation

## Requirements

In order to build, simulate, lint, the following tools must be installed and configured in the environment.

- [Verilator](https://verilator.org/guide/latest/install.html)
- [GTKWave](https://github.com/gtkwave/gtkwave)

### LaTeX Document Compilation
To compile LaTeX PDF documents for project documentation, the LaTeX Workshop extension in VSCode is used with a Docker-based setup. This approach avoids the need for a local TeX Live installation, speeds up environment setup, and ensures consistency across different systems.

- **Docker Requirement**: Docker must be installed and running on your system to use the configured LaTeX compilation tools. Docker containers with the TeX Live image (`texlive/texlive:latest-full`) are used to compile LaTeX documents. Note that the first compilation might take a few minutes due to the image size, as it requires downloading.
- **Setup and Configuration**: Detailed instructions for setting up the LaTeX Workshop extension with Docker, including configuration in `.vscode/settings.json` and testing steps, are available in `docs/LaTeX/TASK.md`.

## Repository structure

```bash
.
├── docs
├── scripts
├── src
│    ├── rtl
│    └── tb
└── Makefile

```

### `docs` directiory

The `docs` directory contains all documentation regardin the project, including an index on all the other files sorted by subject.

### `src` directory

The `src` directory contains the verilog rtl files under the `rtl` directory and testbench files under the `tb` directory.
The rtl files are the hardware description of the devices built, while the testbenches consist in small test cases to validate the development.

## Makefile

The makefile implements a easy to use script in order to lint, build, run and visualize waveforms in gtkwave. It has the options:

Variables:

- `TARGET`: when used before the `make`, it might change the default target in order to change the target to lint, build or run. Example of usage: `TARGET=fft make`

Tasks:

- `make lint`: performs a lint only operation.
- `make compile`: performs the lint, generate all the c++ files and compiles them into executable.
- `make run`: performs the lint, generate the c++ files, compiles and run the executable.
- `make clean`: cleans all generated files, including waveform located at the root of the repository.
- `make waveform`: open the gtkwave with the loaded generated waveform.

## Implemented modules

### `spi_frontend`

The `spi_frontend` module serves as the frontend for SPI communication, handling clock polarity (CPOL), clock phase (CPHA), bit order, slave select, and data synchronization.

#### Inputs:
- `clk`: System clock for synchronization.
- `i_sck`: SPI clock input from the master.
- `i_cpol`: Clock polarity (0: clock idle low, 1: clock idle high).
- `i_cpha`: Clock phase (0: data sampled on leading edge, 1: on trailing edge).
- `i_order`: Bit order (0: MSB first, 1: LSB first).
- `i_ss`: Slave select input (active low).
- `i_mosi`: Master Out Slave In data line.

#### Outputs:
- `o_miso`: Master In Slave Out data line.
- `spi_busy`: Indicates if the SPI interface is currently busy.

#### Internal Interface:
- `o_ss`: Output slave select to internal logic (active high).
- `o_data`: Sampled data from MOSI to internal logic.
- `o_order`: Buffered bit order to internal logic.
- `i_busy`: Busy signal from internal logic.
- `i_data`: Data from internal logic to drive MISO.

#### Logic Description:
- **Synchronization**: Asynchronous inputs (i_ss, i_sck, i_mosi) are synchronized to the system clock to prevent metastability.
- **Edge Detection**: Detects rising and falling edges of the synchronized SCK.
- **Strobe Generation**:
  - Leading edge: SCK rise if CPOL=0, fall if CPOL=1.
  - Trailing edge: Opposite of leading.
  - Sample strobe: Leading if CPHA=0, trailing if CPHA=1 (for sampling MOSI to o_data).
  - Change strobe: Trailing if CPHA=0, leading if CPHA=1 (for updating MISO from i_data).
- **Data Handling**:
  - Samples i_mosi to o_data on sample strobe.
  - Updates internal MISO register from i_data on change strobe when busy and SS active.
  - Drives o_miso with the register value when active.
- **Control Signals**:
  - o_ss is the inverted i_ss (assuming active high internally).
  - spi_busy is set when o_ss is active.

This module ensures proper timing and data transfer for all four SPI modes defined by CPOL and CPHA combinations.
