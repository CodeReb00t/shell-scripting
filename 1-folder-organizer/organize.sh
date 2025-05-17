#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 ./1-folder-organizer"
    exit 1
fi

TARGET_DIR="$1"
LOG_FILE="organize.log"

declare -A types
types=(
    ["Images"]="jpg jpeg png gif svg"
    ["Documents"]="pdf doc docx txt md"
    ["Videos"]="mp4 mkv avi mov"
    ["Music"]="mp3 wav flac"
    ["Archives"]="zip tar gz rar"
    ["Scripts"]="sh py js rb"
)

echo "Organizing files in $TARGET_DIR..."

for category in "${!types[@]}"; do
    mkdir -p "$TARGET_DIR/$category"
    for ext in ${types[$category]}; do
        shopt -s nullglob
        for file in "$TARGET_DIR"/*."$ext"; do
            mv "$file" "$TARGET_DIR/$category/"
            echo "Moved $(basename "$file") to $category/" >> "$LOG_FILE"
        done
    done
done

echo "Organization complete. Log saved to $LOG_FILE"
