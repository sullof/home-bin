#!/bin/bash

# Define the destination path on the removable drive
DESTINATION=$1

# Check if the destination exists
if [ ! -d "$DESTINATION" ]; then
  mkdir -p "$DESTINATION"
fi

# Loop through each folder in the current directory
for dir in */; do
  # Remove trailing slash from directory name
  dir=${dir%/}

  # Create a gzip archive of the folder
  echo "tar -czf ${dir}.tar.gz$dir"
  tar -czf "${dir}.tar.gz" "$dir"

  # Transfer the archive to the destination
  mv "${dir}.tar.gz" "$DESTINATION"

  # Verify if the transfer was successful
  if [ $? -eq 0 ]; then
    echo "Successfully transferred ${dir}.tar.gz to $DESTINATION"
  else
    echo "Failed to transfer ${dir}.tar.gz"
  fi
done
