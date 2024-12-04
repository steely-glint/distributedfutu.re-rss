#!/bin/sh -v
echo file \'jingle.wav\' > all.list
echo file \'body.wav\' >> all.list
ffmpeg -f concat -safe 0 -i all.list df85.wav
