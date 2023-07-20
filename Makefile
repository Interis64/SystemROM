all: main.z80 build/System.bin build/VDPDriver.bin build/OPLDriver.bin build/FDCDriver.bin dist
	z80asm -o dist/InterisROM.bin main.z80

build/System.bin: System/*.z80 build
	z80asm -ISystem -Lbuild/System.lbl -o $@ System/System.z80

build/VDPDriver.bin: VDP/Driver.z80 build
	z80asm -IVDP -Lbuild/VDPDriver.lbl -pVDPDriver. -o $@ VDP/Driver.z80

build/OPLDriver.bin: OPL/Driver.z80 build/System.bin build
	z80asm -IOPL -Lbuild/OPLDriver.lbl -pOPLDriver. -o $@ OPL/Driver.z80

build/FDCDriver.bin: FDC/Driver.z80 build
	z80asm -IFDC -Lbuild/FDCDriver.lbl -pFDCDriver. -o $@ FDC/Driver.z80

dist:
	mkdir dist
build:
	mkdir build

.PHONY : clean
clean:
	rm -fR build
	rm -fR dist
	rm -f *.bin
	rm -f *.lbl