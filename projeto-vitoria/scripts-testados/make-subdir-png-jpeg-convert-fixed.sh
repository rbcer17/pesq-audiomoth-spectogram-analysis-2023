#!/bin/bash

# Copyright (c) 2020, lowkey digital studio
# Author: Nathan Wolek
# Usage of this file and its contents is governed by the MIT License
# Modified by Roberto Cavalcanti to convert pngs to jpgs
#
# to run use syntax:  ./make-subdir-png-jpeg-convert-fixed.sh *.AVI
#
# BEGUN - 16 April 2020
# GOAL - generate jpg spectrogram image of entire .WAV file
# 
# original input .png files visualizing spectrogram entire .WAV file
# new output .jpg files visualizing spectrogram entire .WAV file
#make new directory for jpgs
mkdir jpgs
# iterate through all arguments
for file in $@
do

	# strip out the filename without path
	without_path="${file##*/}"
	
	# use conditionals to make wav extension case insensitive
	if [[ $without_path == *.png ]]; then
	
		# strip the extension
		without_extension="./jpgs/${without_path%.*}"
	

		# convert the initial .png spectrogram output to jpg using ffmpeg
		# dimension here are for spectrogram only, extra padding will result in 1280 x 720 image
		echo "making png to jpg conversion for $without_path..."

                ffmpeg -i "$file" -preset ultrafast "$without_extension".jpg

	
	else
		echo "skipped $without_path - not a png file!"
	fi
	
done