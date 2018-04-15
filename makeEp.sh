#!/bin/sh 
echo "<episode>"
echo "<mp3>distributedFuture-"$1".mp3</mp3>"
echo "<number>"$1"</number>"
ls -g --time-style=+'%a, %d %b %Y %T %z' episodes/$1/*.mp3 \
 | awk  '   {print "<size>" $4 "</size>" 
             print "<date>" $5 " " $6 " " $7 " " $8 " " $9 " " $10 "</date>"}'
echo "<description>Text here please</description>"
echo "<tags>tags,here,please</tags>"
eyeD3 --jep-118 episodes/$1/*.mp3 | awk '/\<length/ { gsub(/length/,"duration"); print $0}
/\<title/ {print $0}'
echo "<guest>Text here please</guest>"
echo "<transcription></transcription>"
echo "<links><link></link></links>"
echo "</episode>"
