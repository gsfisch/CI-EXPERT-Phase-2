<<<<<<< HEAD
# BioQuick

## Overview
BioQuick is a project developed as part of the CI-INOVADOR specialization course program. The primary focus is on designing a device that facilitates memory read and write operations through SPI (Serial Peripheral Interface) commands, interacting with an APB (Advanced Peripheral Bus) bus to access external memory. The system also includes placeholders for integration with an ADC (Analog-to-Digital Converter) SAR to capture and store conversion values in memory.

## Proposal
The core objective of BioQuick is to implement a robust interface for handling READ and WRITE commands via SPI, enabling seamless communication with external memory through an APB bus. This design supports efficient data transfer and memory management, crucial for embedded system applications. Additionally, the project incorporates provisions for ADC integration, allowing analog-to-digital conversion data to be written to memory, aligning with broader system requirements.

## Discoveries
*(Placeholder for key findings or innovations related to SPI-APB interactions and ADC integration. This section will be updated as the project progresses.)*

## Current Status
*(Placeholder for the current development status of the project. Updates on the implementation of SPI communication, APB bus interfacing, and ADC integration will be provided here as milestones are achieved.)*

## Implementation Details
The BioQuick system architecture is composed of several key components that work together to achieve the desired functionality:
- **SPI Slave Interface**: Manages communication with an external SPI Master, receiving READ and WRITE commands and facilitating data transfer to and from internal blocks.
- **APB Master and Slave**: Coordinate memory access operations, with the APB Master commanding the Slave to read from or write to specific memory addresses, ensuring proper transaction timing and data integrity.
- **Addresser**: Reorganizes data packets and implements address auto-increment for sequential memory operations, bridging the SPI data to the APB bus.
- **ADC Integration Placeholders**: Provisions are included to interface with an ADC SAR, enabling the capture of analog-to-digital conversion values and writing them to memory for further processing.

For a comprehensive understanding of the microarchitecture, data flow, and control logic, refer to the detailed Preliminary Design Report (PDR) and associated documentation in the [docs](docs/README.md) directory. This includes diagrams and detailed descriptions of the SPI-to-APB data flow and system integration.
=======
teste
>>>>>>> 57143ee104802218b7b9d0241556682f58b4bbd5
