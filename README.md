# Interis 64 System ROM

Interis 64 Z80 Computer
https://github.com/Interis64

Copyright 2023 Matthew Martin

Licensed under the GNU GPL 3.0. See the LICENSE file for details.

## Development Notes

### Building
Building the ROM requires z80asm and GNU Make.
Simply execute `make` and the ROM image will be assembled to `dist/InterisROM.bin`.
Execute `make clean` to remove any build output and start from scratch.
If you have a TL866 programmer and `minipro` installed, you can execute `make burn` to write a 28C256 EEPROM.

### Code Organization
The `main.z80` file contains the basic layout of the ROM image, initial startup code, and reset vectors.

The `System` directory contains the bulk of the Interis 64 System code, including the system monitor and drivers for on-board hardware. `System.z80` is framework, `BaseSystem.z80` is code.

There are also directories for the various supported expansion cards:
- `VDP` for the TMS9918A Video Card
- `OPL` for the Yamaha OPL2 Sound Card
- `FDC` for the Floppy Disk Controller Card

## Thanks and Acknowledgments
*Grant Searle,* whose impressive work inspired and helped kick-start this project:
http://searle.wales/
