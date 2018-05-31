#!/bin/sh
MAXEP=2
xsltproc --stringparam maxEpisode ${MAXEP} --stringparam current-date "`date -R`" -o docs/rss/DistributedFuture.rss  src/mkrss.xsl src/headpart-rss.xml 
xsltproc --stringparam maxEpisode ${MAXEP} --stringparam current-date "`date -R`" -o docs/index.html  src/mkindex.xsl src/headpart-rss.xml 

echo now 
echo scp docs/rss/DistributedFuture.rss pi@distributedfutu.re:/usr/share/nginx/html/rss
echo scp docs/index.html pi@distributedfutu.re:/usr/share/nginx/html




