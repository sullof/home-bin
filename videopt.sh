#!/bin/bash

INPUT=$1
ffmpeg -i $INPUT.mp4 -c:v libx264 -crf 28 -preset slow -c:a copy $INPUT-optimized.mp4
