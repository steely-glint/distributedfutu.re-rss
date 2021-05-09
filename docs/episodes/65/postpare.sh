#!/bin/sh -v
echo file \'jingle.wav\' > all.list
echo file \'df65.wav\' >> all.list
ffmpeg -f concat -safe 0 -i all.list dfall65.wav
