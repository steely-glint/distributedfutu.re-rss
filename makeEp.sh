#!/bin/sh 
EP=src/episode$1.xml
echo making $EP
echo "<episode>" > $EP
echo "<mp3>distributedFuture-"$1".mp3</mp3>" >> $EP
echo "<number>"$1"</number>" >> $EP
ls  -lu  docs/episodes/$1/*.mp3 \
 | awk  '   {print "<size>" $5 "</size>" }' >> $EP
echo "<date>" `date -R -j -r docs/episodes/$1/*.mp3 `"</date>" >> $EP
echo "<description>Text here please</description>" >> $EP
echo "<tags>tags,here,please</tags>" >> $EP
# estimated duration: 1560.408000 sec
afinfo docs/episodes/$1/*.mp3 | awk '/^estimated duration:/ { print "<duration>" int($3) "</duration>"}' >> $EP
echo "<title>Title here</title>" >> $EP
echo "<guest>Text here please</guest>" >> $EP
echo "<transcription>DistributedFuture$1.rtf</transcription>" >> $EP
echo "<links><link></link></links>" >> $EP
echo "</episode>" >> $EP
echo now please edit $EP
