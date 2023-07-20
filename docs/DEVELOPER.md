# Interis 64 Developer Notes

The information in this document will be invaluable to developers writing software for Interis 64.

## Memory Map

| Address      | Function                          |
| ------------ | --------------------------------- |
|        $FFFF | System call number                |
|        $FFFE | SLOT 7 Hardware ID                |
|        $FFFD | SLOT 6 Hardware ID                |
|        $FFFC | SLOT 5 Hardware ID                |
|        $FFFB | SLOT 4 Hardware ID                |
| \$FF80-$FFEF | System call vector table          |
|        $FF0E | Interrupt 7 Vector                |
|        $FF0C | Interrupt 6 Vector                |
|        $FF0A | Interrupt 5 Vector                |
|        $FF08 | Interrupt 4 Vector                |
|        $FF06 | Interrupt 3 Vector (RTC/NVRAM)    |
|        $FF04 | Interrupt 2 Vector (Serial Port)  |
|        $FF02 | Interrupt 1 Vector (Keyboard)     |
|        $FF00 | Interrupt 0 Vector (Unused)       |
| \$F400-$FEFF | Code for system calls             |
| \$F000-$F399 | Video Driver: 1KB                 |
| \$EC00-$E999 | Sound Driver: 1KB                 |
| \$E800-$EB99 | Storage Driver: 1KB               |
|        $E800 | Starting address of stack pointer |


## System Calls

To make a system call, load the system call number into memory at $FF80 and issue a `RST $10` instruction. See the documentation for each call for information on passing parameters and results.

| Call Number | Function                                                |
| ----------- | ------------------------------------------------------- |
|         $00 | Reserved                                                |
|         $00 | Reset                                                   |
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

### $00 Reboot
Clears the input buffer, clears the screen, displays the ROM header message, attempts to boot from a storage device, falls back to the system monitor if that fails.

### $04 Start Debug
Breaks out of the current program to the system monitor for debugging.

### $06 Print character to output device
TODO: Document system call

### $08 Print null-terminated string to output device
TODO: Document system call

### $0A Read a character from BufferedInput
TODO: Document system call

### $0C Check if there's a character available in BufferedInput
TODO: Document system call

### $0E Write a character into the input buffer
TODO: Document system call

### $10 System Bell
TODO: Document system call

### $12 NVRAM Read Byte
TODO: Document system call

### $14 NVRAM Write Byte
TODO: Document system call

### $16 Serial Send Byte
TODO: Document system call
