#!/bin/sh
# parameters: input, output

# make a 256-colors palette first
palettefull=$( mktemp --suffix=.png )
ffmpeg -i "$1" -vf 'palettegen' -y "$palettefull"

# quantize the palette (palettegen's builting limiter
# tries to preserve too much similar shades)
palettequant=$( mktemp --suffix=.png )
convert "$palettefull" -posterize 16 "$palettequant"

# initial compression
rawgif=$( mktemp --suffix=.gif )
ffmpeg -i "$1" -i "$palettequant" -lavfi "paletteuse=dither=0" -y "$rawgif"

# gifsicle optimization (the slowest stage)
gifsicle -O3 --lossy=80 "$rawgif" -o "$2"
gifsicle --scale 0.5 -i "$2" -o "$2"

# cleanup
rm "$palettefull" "$palettequant" "$rawgif"

