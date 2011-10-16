#!/bin/bash

if [ "$1" == "help" ] || [ "$1" == "--help" ]; then
	echo "Usage: $0 [clean|help]"
	echo
	echo "clean    remove output files"
	echo "help     this"
	exit
fi

DIR=$(dirname $(readlink -f $0)) # Directory script is in
cd $DIR # cd /path/to/dxf2ponoko/test

rm -rf out
mkdir out

if [ "$1" == "clean" ]; then
	exit
fi

for x in {7x7,12x12}; do
	echo "=> $x"
	
	rm -rf out/$x
	mkdir out/$x
	
	echo "=>  p1"
	../dxf2ponoko -d "./test-$x.dxf" -o "./out/$x/test-p1.svg" -t laser -p 1
	echo "=>  p2"
	../dxf2ponoko -d "./test-$x.dxf" -o "./out/$x/test-p2.svg" -t laser -p 2
	echo "=>  p3"
	../dxf2ponoko -d "./test-$x.dxf" -o "./out/$x/test-p3.svg" -t laser -p 3
done

echo "Diff:"
diff expected out
echo "Done!"
