#!/bin/bash

#export LD_PRELOAD=libtcmalloc_minimal.so

# Find newest Greenlandic generation FST
FST=`ls -1t ~/langtech/kal/src/generator-gt-norm.hfstol /usr/share/giella/kal/generator-gt-norm.hfstol 2>/dev/null | head -n1`

for I in {10..1}
do
	echo "Chunks: $I"
	rm -rf split*
	split -a1 -d -nl/$I input.txt split.in.
	ls -1 split.in.* | sort | /usr/bin/time -f '%e %U' xargs -P0 '-IX' bash -c "cat X | /usr/bin/time -f '%e %U' hfst-optimized-lookup -u -p $FST >split.out-X"
	echo ""
done
