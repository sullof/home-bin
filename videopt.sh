#!/bin/bash

INPUT=$1
mv $INPUT.mp4 $INPUT.bak.mp4
ffmpeg -i $INPUT.bak.mp4 -c:v libx264 -crf 28 -preset slow -c:a copy $INPUT.mp4
