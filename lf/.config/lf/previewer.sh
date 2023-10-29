#!/bin/sh
MIME_TYPE=$(file -Lb --mime-type -- "$1")
FILE_EXT=${1##*.}

if [ "$FILE_EXT" = "stl" ] || [ "$FILE_EXT" = "STL" ]; then
	TEMP=$(mktemp -d -t lf-stl-XXXXXX)
	cp "$1" "$TEMP/source.stl"
	echo "import(\"source.stl\", convexity=10);" >"$TEMP/thumbnail.scad"
	openscad --imgsize "1000,1000" -o "$TEMP/thumbnail.png" "$TEMP/thumbnail.scad" 2>/dev/null
	chafa -f sixel -s "$2x$3" --animate false "$TEMP/thumbnail.png"
	rm -rf "$TEMP"
else
	case "$MIME_TYPE" in
	image/*)
		chafa -f sixel -s "$2x$3" --animate false "$1"
		;;
	application/pdf)
		tmpfile=$(mktemp)
		pdftoppm -f 1 -l 1 "$1" -png -rx 150 -ry 150 >"$tmpfile"
		chafa -f sixel -s "$2x$3" --animate false "$tmpfile"
		rm "$tmpfile"
		;;
	video/*)
		tmpfile=$(mktemp)
		ffmpegthumbnailer -i "$1" -o "$tmpfile" -s 0
		chafa -f sixel -s "$2x$3" --animate false "$tmpfile"
		rm "$tmpfile"
		;;
	application/zip | application/bzip2 | application/lzma | application/xz | application/zstd)
		unzip -l "$1"
		;;
	application/tar | application/gzip)
		tar -tvf "$1"
		;;
	text/*)
		bat --color=always --style=plain "$1"
		;;
	*)
		echo "No preview available"
		;;
	esac
fi
