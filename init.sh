#!/bin/bash

# 1k file per dir

if (( $# != 1 )); then
	echo "Usage: $0 dircnt " 1>&2
	exit 1
fi

dircnt=$1

for (( i=1; i<=dircnt; ++i )); do
	dir=$(printf %03d $i)
	echo dir: $dir
	mkdir -p $dir
	cd $dir
	for (( j=1; j<=1024; ++j )); do
		file=$(printf "%s_%04d" $dir $j).bin
		echo file: $file
		if [[ ! -e $file ]]; then
			dd if=/dev/urandom of=$file bs=1k count=1
		fi
	done
	cd ..
done
