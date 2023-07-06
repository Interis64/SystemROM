# Interis 64 Developer Notes

The information in this document will be invaluable to developers writing software for Interis 64.

## Memory Map

| Address      | Function                          |
| ------------ | --------------------------------- |
| \$FFF0-$FFFF | Interrupt Mode 2 Vector Table     |
|        $FFEF | SLOT 7 Hardware ID                |
|        $FFEE | SLOT 6 Hardware ID                |
|        $FFED | SLOT 5 Hardware ID                |
|        $FFEC | SLOT 4 Hardware ID                |
|        $FF80 | System call number                |
| \$FF00-$FF7F | System call vector table          |
| \$F800-$FEFF | Code for system calls             |
| \$F400-$F799 | Video Driver: 1KB                 |
| \$F000-$F399 | Sound Driver: 1KB                 |
| \$EC00-$E999 | Storage Driver: 1KB               |
|        $EC00 | Starting address of stack pointer |


## System Calls

To make a system call, load the system call number into memory at $FF80 and issue a `RST $10` instruction. See the documentation for each call for information on passing parameters and results.

| Call Number | Function                                                |
| ----------- | ------------------------------------------------------- |
|         $00 | Cold Boot                                               |
|         $02 | Warm Boot                                               |
|         $04 | Start Debug Monitor                                     |
|         $06 | Print character to output device                        |
|         $08 | Print null-terminated string to output device           |
|         $0A | Read a character from BufferedInput                     |
|         $0C | Check if there's a character available in BufferedInput |
|         $0E | Write a character into the input buffer                 |
|         $10 | System Bell                                             |
|         $12 | NVRAM Read Byte                                         |
|         $14 | NVRAM Write Byte                                        |
|         $16 | Serial Send Byte                                        |