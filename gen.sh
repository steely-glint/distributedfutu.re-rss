#!/bin/sh
cat src/headpart-rss.xml src/episode1.xml src/tailpart-rss.xml | \
xsltproc --stringparam current-date "`date -R`" -o src/base-rss_output.xml  src/mkrss.xsl -


