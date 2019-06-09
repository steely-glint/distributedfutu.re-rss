<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : mksitemap.xsl
    Created on : 09 June 2019, 15:11
    Author     : tim
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <xsl:output method="xml" indent="yes" version="1.0" encoding="UTF-8" 
                standalone="yes" />
    <xsl:variable name="secureUrl">https://<xsl:value-of select="/cast/site"/>/</xsl:variable>
    <xsl:variable name="epDir">
        <xsl:value-of select="/cast/epDir"/>/</xsl:variable>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template name="makeEpisodes">
        <xsl:param name="eNum" select="0"/>
        <xsl:if test="$eNum > 0">
            <xsl:variable name="filename">
                <xsl:value-of select="concat('episode',$eNum,'.xml')"/>
            </xsl:variable>
            <xsl:apply-templates select="document($filename)">
                    
            </xsl:apply-templates>
            <xsl:call-template name="makeEpisodes">
                <xsl:with-param name="eNum" select="$eNum -1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template match="/cast">
        <urlset>
            <url>
                <loc>https://distributedfutu.re/index.html</loc>
                <lastmod><xsl:value-of select="$current-date"/></lastmod>
                <changefreq>weekly</changefreq>
                <priority>0.8</priority>
            </url>
            <xsl:call-template name="makeEpisodes">
                <xsl:with-param name="eNum" select="$maxEpisode"/>
            </xsl:call-template>
        </urlset>
    </xsl:template>
    <xsl:template match="episode">
        <xsl:variable name="transUrl">
            <xsl:value-of select="$secureUrl"/>
            <xsl:value-of select="$epDir"/>
            <xsl:value-of select="number"/>/<xsl:value-of select="substring-before(transcription,'.')"/>
            <xsl:text>.html</xsl:text>
        </xsl:variable>
        <url>
            <loc><xsl:value-of select="$transUrl"/></loc>
        </url>
    </xsl:template>

</xsl:stylesheet>
