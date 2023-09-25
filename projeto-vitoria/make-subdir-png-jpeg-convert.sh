#!/bin/bash

# Copyright (c) 2020, lowkey digital studio
# Author: Nathan Wolek
# Usage of this file and its contents is governed by the MIT License
# Modified by Roberto Cavalcanti to extract frames from video
#
# to run use syntax:  ./make-subdir-video-extractor.sh *.AVI
#
# BEGUN - 16 April 2020
# GOAL - generate jpg spectrogram image of entire .WAV file
# original input .wav files (upper or lower case extension) produced by the AudioMoth
# original output .png files visualizing entire .WAV file
# new output .jpg files visualizing entire .WAV file
#make new directory for jpgs
mkdir jpgs
# iterate through all arguments
for file in $@
do

	# strip out the filename without path
	without_path="${file##*/}"
	
	# use conditionals to make wav extension case insensitive
	if [[ $without_path == *.avi ]] || [[ $without_path == *.png ]]; then
	
		# strip the extension
		without_extension="./jpgs/${without_path%.*}"
	

		# generate the initial .png spectrogram output from sox
		# dimension here are for spectrogram only, extra padding will result in 1280 x 720 image
		echo "making frame extraction for $without_path..."

                ffmpeg -i "$file" -preset ultrafast "$without_extension"%01d.jpg

	
	else
		echo "skipped $without_path - not an avi file!"
	fi
	
done