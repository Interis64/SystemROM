all: main.z80 build/System.bin build/VDPDriver.bin build/OPLDriver.bin build/FDCDriver.bin dist
	z80asm -Ibuild -o dist/InterisROM.bin main.z80

build/System.bin: System/*.z80 build
	z80asm -ISystem -Lbuild/System.lbl -o $@ System/System.z80

build/VDPDriver.bin: VDP/Driver.z80 build
	z80asm -IVDP -Ibuild -Lbuild/VDPDriver.lbl -pVDPDriver. -o $@ VDP/Driver.z80
	$(call ENFORCESIZE,$@,1024)

build/OPLDriver.bin: OPL/Driver.z80 build/System.bin build
	z80asm -IOPL -Ibuild -Lbuild/OPLDriver.lbl -pOPLDriver. -o $@ OPL/Driver.z80
	$(call ENFORCESIZE,$@,1024)

build/FDCDriver.bin: FDC/Driver.z80 build
	z80asm -IFDC -Ibuild -Lbuild/FDCDriver.lbl -pFDCDriver. -o $@ FDC/Driver.z80
	$(call ENFORCESIZE,$@,1024)

dist:
	mkdir dist
build:
	mkdir build

.PHONY: clean
clean:
	rm -fR build
	rm -fR dist
	rm -f *.bin
	rm -f *.lbl

# This function is used to check that a file fits within the allocated size
# Inputs:
#    $1: binary
#    $2: size limit
#  If max size is non-zero, use the specified size as a limit
# Source: https://embeddedartistry.com/blog/2018/07/26/enforcing-binary-size-limits-using-make/
ENFORCESIZE = @(FILESIZE=`stat -f '%z' $1` ; \
	if [ $2 -gt 0 ]; then \
		if [ $$FILESIZE -gt $2 ] ; then \
			>&2 echo "*** ERROR: File $1 exceeds size limit ($$FILESIZE > $2)" ; \
			rm $1 ; \
			exit 1 ; \
		fi ; \
	fi )
