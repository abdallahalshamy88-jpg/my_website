#!/bin/zsh
cd "$(dirname "$0")" || exit 1

manifest="videos/videos-manifest.js"
mkdir -p videos

{
  printf "window.portfolioVideos = [\n"
  first=1
  find videos -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mov" -o -iname "*.webm" -o -iname "*.m4v" \) -print | sort | while IFS= read -r file; do
    name="${file#videos/}"
    escaped="${name//\\/\\\\}"
    escaped="${escaped//\'/\\\'}"
    if [ "$first" -eq 0 ]; then
      printf ",\n"
    fi
    first=0
    printf "  { type: 'file', src: 'videos/%s' }" "$escaped"
  done
  printf "\n];\n"
} > "$manifest"

echo "Videos updated. Refresh the portfolio page."
