#!/bin/sh
xsltproc --stringparam current-date `date +%Y-%m-%d` -o src/base-rss_output.xml  src/mkrss.xsl src/base-rss.xml


