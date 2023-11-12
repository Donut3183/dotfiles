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
	application/vnd.oasis.opendocument.text | application/vnd.oasis.opendocument.spreadsheet | application/vnd.oasis.opendocument.presentation)
		TMP_DIR=$(mktemp -d -t lf-libreoffice-XXXXXX)
		libreoffice --headless --convert-to pdf --outdir "$TMP_DIR" "$1" >/dev/null 2>&1

		OUT_PDF="$TMP_DIR/$(basename "$1" ".$FILE_EXT").pdf"
		OUT_PNG="$TMP_DIR/out.png"

		pdftoppm -f 1 -l 1 -png -rx 150 -ry 150 "$OUT_PDF" >"$OUT_PNG"
		chafa -f sixel -s "$2x$3" --animate false "$OUT_PNG"

		rm -rf "$TMP_DIR"
		;;
	text/*)
		bat --color=always --style=plain "$1"
		;;
	*)
		echo "No preview available"
		;;
	esac
fi
