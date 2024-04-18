#!/bin/sh
# ref: missfont.log file on errors from pdflatex command

BDPI=600
make_tex_pk_font() {
  local FONT="$1"
  local DPI=$2
  local OFFSET=$(printf %+d $(($DPI - $BDPI)))
  mktexpk --mfmode / --bdpi $BDPI --mag 1${OFFSET}/$BDPI --dpi "$DPI" "$FONT" 2>/dev/null
}

# DPI FONT
FONT_LIST="
600 matha6
600 matha8
600 matha12
657 matha10
720 mathb12
720 mathx10
"

# ref for each line: https://stackoverflow.com/a/1521470
echo "$FONT_LIST" | while read f; do
  if [ -z "$f" ]; then continue; fi
  DPI=$(echo $f | cut -d' ' -f1)
  FONT=$(echo $f | cut -d' ' -f2)
  make_tex_pk_font "$FONT" "$DPI"
done
