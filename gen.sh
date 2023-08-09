#!/bin/sh -v
MAXEP=84
xsltproc --nonet --stringparam maxEpisode ${MAXEP} --stringparam minEpisode 0  --stringparam current-date "`date -R`" -o docs/rss/DistributedFuture.rss  src/mkrss.xsl src/headpart-rss.xml 
xsltproc --stringparam maxEpisode ${MAXEP} --stringparam minEpisode 0 --stringparam current-date "`date -R`" -o docs/index.html  src/mkindex.xsl src/headpart-rss.xml 
xsltproc --stringparam maxEpisode ${MAXEP} --stringparam minEpisode 0 --stringparam current-date "`date +%Y-%m-%d`" -o docs/sitemap.xml src/mksitemap.xsl src/headpart-rss.xml 
PREV=$((MAXEP-1))
echo ${PREV}
xsltproc --stringparam maxEpisode ${MAXEP} --stringparam minEpisode ${PREV} --stringparam current-date "`date -R`" -o docs/episode${MAXEP}.html  src/mkindex.xsl src/headpart-rss.xml






