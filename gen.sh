#!/bin/sh
#cat src/headpart-rss.xml src/episode1.xml src/tailpart-rss.xml | \
xsltproc --stringparam maxEpisode 2 --stringparam current-date "`date -R`" -o src/base-rss_output.xml  src/mkrss.xsl src/headpart-rss.xml 


