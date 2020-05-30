#!/bin/sh
MAXEP=50
xsltproc --nonet --stringparam maxEpisode ${MAXEP} --stringparam current-date "`date -R`" -o docs/rss/DistributedFuture.rss  src/mkrss.xsl src/headpart-rss.xml 
xsltproc --stringparam maxEpisode ${MAXEP} --stringparam current-date "`date -R`" -o docs/index.html  src/mkindex.xsl src/headpart-rss.xml 
xsltproc --stringparam maxEpisode ${MAXEP} --stringparam current-date "`date +%Y-%m-%d`" -o docs/sitemap.xml src/mksitemap.xsl src/headpart-rss.xml 





