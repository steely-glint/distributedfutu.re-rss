#!/bin/sh 
echo "<episode>"
echo "<mp3>distributedFuture-"$1".mp3</mp3>"
echo "<number>"$1"</number>"
ls  -lu  docs/episodes/$1/*.mp3 \
 | awk  '   {print "<size>" $5 "</size>" }'
echo "<date>" `date -R -j -r docs/episodes/$1/*.mp3 `"</date>"
echo "<description>Text here please</description>"
echo "<tags>tags,here,please</tags>"
# estimated duration: 1560.408000 sec
afinfo docs/episodes/$1/*.mp3 | awk '/^estimated duration:/ { print "<duration>" int($3) "</duration>"}'
echo "<title>Title here</title>"
echo "<guest>Text here please</guest>"
echo "<transcription>DistributedFuture$1.rtf</transcription>"
echo "<links><link></link></links>"
echo "</episode>"
