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
| \$FF10-$FF7F | System scratchpad memory          |
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
| \$0100-$E800 | Application memory                |
| \$0000-$00FF | Reserved for Z80 reset vectors    |


## Hardware IDs

Each of the expansion slots can accept any sort of expansion card.
The four Hardware ID memory slots (\$FFFB-$FFFE) are populated by the card initialization routines to identify which
optional hardware is in which slot.

By convention, Hardware IDs are assigned by device category, as follows:

| Hardware ID  | Device Type                       |
| ------------ | --------------------------------- |
| $00 - $0F    | Reserved for built-in devices     |
| $10 - $1F    | Video and display devices         |
| $20 - $2F    | Sound and music devices           |
| $30 - $3F    | Data storage devices              |
| $40 - $4F    | Human interface devices           |
| $50 - $5F    | Communication devices             |
| $60 - $6F    | Data Processing devices           |
| $70 - $FF    | Other devices                     |

### Currently Assigned Hardware IDs

*Note:* Some of the devices listed here are in-development and are unsupported.
#### Video and Display Devices
- $10 - TMS9918A Video Card
- $11 - Graphic LCD Driver Card
- $11 - Character LCD Driver Card

#### Sound and Music Devices
- $20 - Yamaha OPL2 Sound Card
- $21 - SN76489 Sound Card

#### Data Storage Devices
- $30 - WD37C65C Floppy Disk Controller Card
- $31 - Secure Digital Adapter Card
- $32 - CompactFlash Adapter Card

#### Human Interface Devices
- $40 - Game Controller Card
- $41 - PC Joystick Card

#### Communication Devices
- $50 - Parallel Port Card

#### Data Processing Devices
- $60 - AM9511A Math Coprocessor Card

## System Calls

To make a system call (syscall), load the system call number into memory at `$FFFF` and issue a `RST $10` instruction.
See the documentation for each syscall below for information on passing parameters and results.

| Call Number | Function                                                |
| ----------- | ------------------------------------------------------- |
|         $00 | Warm Reset                                              |
|         $02 | Disk Boot                                               |
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

### $02 – Reset
Clears the input buffer, clears the screen, displays the ROM header message, attempts to boot from a storage device, falls back to the system monitor if that fails.

### $04 – Start Debug
Breaks out of the current program to the system monitor for debugging.

### $06 – Print character to output device
Writes the byte of data in the `A` register to the primary output device.
By default, this is the serial port, but hardware drivers may override this call to become the default device.

### $08 – Print null-terminated string to output device
Writes a string of characters starting at `(HL)` to the primary output device via repeated calls to syscall $06.
Execution continues until a null byte is encountered, which is not sent.
See the documentation for syscall $06 for information on output devices.

### $0A – Read a character from BufferedInput
Removes the first character from the input buffer and stores it in the `A` register.
If no character is available in the buffer, this call will block until one becomes available.

### $0C – Check if there's a character available in BufferedInput
Checks to see if there are characters in the input buffer.
If there are characters in the buffer, the `Z` flag will be cleared, otherwise `Z` will be set.
Additionally, `A` will contain the number of characters in the buffer.

### $0E – Write a character into the input buffer
Inserts the character in the `A` register into the input buffer.
If the input buffer is full, this call is silently ignored.

### $10 – System Bell
Sounds the system bell.
By default this is a simple beep from the on-board speaker generated by the NVRAM chip.
Audio device drivers can override this call to provide their own system bell.

### $12 – NVRAM Read Byte
TODO: Document system call

### $14 – NVRAM Write Byte
TODO: Document system call

### $16 – Serial Send Byte
Writes the byte of data in the `A` register to the serial port.
By default, this is the same as syscall $06, but this is made available separately for cases where the default output has been redirected by a device driver.

### $18 – Serial Receive Byte
Receives a byte of data from the serial port in the `A` register.
By default, this points to BufferedInput.Accept, so serial data is passed through the input buffer.
Applications can overwrite this to handle serial data on their own.