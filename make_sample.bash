#!/bin/bash

if [ -d sample1 ]
then
	cd sample1
	"echo Sample is already"
	exit 0
fi

mkdir sample1 ; cd sample1
cp $HAKONIWA_HOME/athrill-target-rh850f1x/params/rh850f1k/atk2-sc1/*.txt .
../toppers-atk2-sc1/configure -T hsbrh850f1k_gcc -g ${HAKONIWA_HOME}/cfg
make
