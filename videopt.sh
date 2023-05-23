#!/bin/bash

INPUT=$1
IN_PLACE=$2

if [[ "$IN_PLACE" == "in-place" ]]; then
  INPUT=$1
  mv $INPUT.mp4 $INPUT-orig.mp4
  ffmpeg -i $INPUT-orig.mp4 -c:v libx264 -crf 28 -preset slow -c:a copy $INPUT.mp4
  rm $INPUT-orig.mp4
elif [[ "$INPUT" != "" ]]; then
  ffmpeg -i $INPUT.mp4 -c:v libx264 -crf 28 -preset slow -c:a copy $INPUT-optimized.mp4
else
	echo "
Example:

  videopt.sh videoNameWithoutMp4Extension [in-place]
"
fi

