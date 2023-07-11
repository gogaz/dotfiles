#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/dot/file"
    exit 1
fi

src="$1"

if [ ! -e "$src" ]; then
    echo "File not found"
    exit 1
fi

set -eux

dst_dir="$(dirname "$(readlink -f "$0")")"
relative_path="${src/$HOME/}"
file_name="$(basename "$src")"
dst_dir="${dst_dir}${relative_path%$file_name}"
dst="${dst_dir}${file_name}"

mkdir -p "$dst_dir"

mv -v "$src" "$dst"

ln -s "$dst" "$src"

