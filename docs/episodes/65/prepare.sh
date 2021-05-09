#!/bin/sh -v
ffmpeg -i body.webm -ar 48000  body.wav
echo file \'jingle.wav\' > all.list
echo file \'body.wav\' >> all.list
ffmpeg -f concat -safe 0 -i all.list all.wav
