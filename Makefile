all: dxf2svg/dxf2svg

dxf2svg/dxf2svg:
	(cd dxf2svg; make)



clean:
	(cd dxf2svg; make clean)

.PHONY: all clean
