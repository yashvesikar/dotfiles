#!/bin/bash

# Collect any additional ffmpeg flags passed to the script
EXTRA_FLAGS="$@"

# Find all MKV files in current directory
shopt -s nullglob
mkv_files=(*.mkv)
shopt -u nullglob

# Check if any MKV files exist
if [[ ${#mkv_files[@]} -eq 0 ]]; then
  echo "No MKV files found in the current directory."
  exit 1
fi

# Show count and prompt user
echo "Found ${#mkv_files[@]} MKV file(s):"
printf '  %s\n' "${mkv_files[@]}"
echo ""

if [[ -n "$EXTRA_FLAGS" ]]; then
  echo "Additional ffmpeg flags: $EXTRA_FLAGS"
  echo ""
fi

read -p "Proceed with conversion? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi

echo ""

# Process each file
success=0
failed=0

for f in "${mkv_files[@]}"; do
  output="${f%.mkv}.mp4"
  echo "Converting: $f -> $output"
  
  if ffmpeg -i "$f" \
    -c:v h264_videotoolbox -q:v 70 -profile:v high -pix_fmt yuv420p \
    -c:a aac -b:a 192k \
    -movflags +faststart \
    $EXTRA_FLAGS \
    "$output"; then
    echo "✓ Completed: $output"
    ((success++))
  else
    echo "✗ Failed: $f"
    ((failed++))
  fi
  echo ""
done

# Summary
echo "Done. $success succeeded, $failed failed."
