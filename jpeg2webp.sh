#!/usr/bin/env bash

# for this you need to install rename and cwebp using
# brew install webp
# brew install rename

rename 's/\.(JPG|jpeg|JPEG)$/.jpg/' *
for file in *.jpg; do cwebp -progress "$file" -o "$(basename "$file" .jpg).webp"; done

if [[ "$1" == "-d" ]]; then
	rm *.jpg
fi
