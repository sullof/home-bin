#!/usr/bin/env bash

help () {
  echo "
ERROR: Invalid option.

Accepted options:

    -j [image]
    -w [wav file]
    -o [output - only name]

Example:

    mp3ToVideo.sh -j image -w audio -o somevideo

where the files are image.jpg, audio.wav and somevideo.mp4
"
}


while getopts "j:w:o:" opt; do
  case $opt in
	j)
	  JPG=$OPTARG
	  ;;
    w)
	  WAV=$OPTARG
	  ;;
	o)
	  MP4=$OPTARG
	  ;;
	\?)
	  help
	  exit 1
	  ;;
  esac
done

if [[ "$JPG" == "" || "$WAV" == "" || "$MP4" == "" ]]; then
  help
  exit 1
fi

ffmpeg -loop 1 -i $JPG.jpg -i $WAV.wav -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest -s 720x100 $MP4.mp4
