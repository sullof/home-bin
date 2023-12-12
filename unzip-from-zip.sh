#!/bin/bash

# Directory containing the .tar.gz files
SOURCE_DIR="$1"

# Optional: Destination directory to unzip the files
# If not provided, files will be unzipped in the current directory
DESTINATION_DIR="$2"

START_FROM="$3"

# Check if the source directory is specified
if [ "$SOURCE_DIR" == "" ]; then
    echo "Source directory not specified. Exiting..."
    exit 1
fi

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist. Exiting..."
    exit 1
fi

STARTED=
if [ "$START_FROM" == "" ]; then
	STARTED=1
fi

# Check if the destination directory is specified, if not, use the current directory
if [ "$DESTINATION_DIR" == "" ]; then
    DESTINATION_DIR="."
fi

# Check if the destination directory exists, if not, create it
if [ ! -d "$DESTINATION_DIR" ]; then
    mkdir -p "$DESTINATION_DIR"
fi

# Loop through each .tar.gz file in the source directory and unzip it
for FILE in "$SOURCE_DIR"/*.tar.gz; do
    if [ -f "$FILE" ]; then
    	BASE_FILE=$(basename "$FILE")
		if [ "$STARTED" == "" ]; then
			if [ "$BASE_FILE" == "$START_FROM" ]; then
				STARTED=1
			else
				continue
			fi
		fi

        echo "Unzipping $(basename "$FILE") to $DESTINATION_DIR..."
        tar -xzf "$FILE" -C "$DESTINATION_DIR"
    fi
done

echo "Unzipping completed."
