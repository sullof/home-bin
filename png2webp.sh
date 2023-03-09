#!/usr/bin/env bash

# for this you need to install rename and cwebp using
# brew install webp
# brew install rename

rename 's/\.PNG$/.png/' *
for file in *.png; do cwebp -progress "$file" -o "$(basename "$file" .png).webp"; done

if [[ "$1" == "-d" ]]; then
	rm *.png
fi
