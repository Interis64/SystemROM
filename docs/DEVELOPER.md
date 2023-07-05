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

| Call Number | Function |
| ----------- | ----------- |
|         $00 | Title |
|         $02 | Text |