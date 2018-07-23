<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : mkrss.xsl
    Created on : 11 March 2018, 10:10
    Author     : tim
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:media="http://search.yahoo.com/mrss/" xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:creativeCommons="http://backend.userland.com/creativeCommonsRssModule"
                xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">
    <xsl:output method="xml" indent="yes" version="1.0" encoding="UTF-8" 
                standalone="yes" />
    <xsl:variable name="secureUrl">https://<xsl:value-of select="/cast/site"/>/</xsl:variable>
    <xsl:variable name="insecureUrl">http://<xsl:value-of select="/cast/site"/>/</xsl:variable>
    <xsl:variable name="epDir"><xsl:value-of select="/cast/epDir"/>/</xsl:variable>

    <xsl:variable name="rssUrl">
        <xsl:value-of select="$secureUrl"/>
        <xsl:value-of select="/cast/rssDir"/>
        <xsl:value-of select="/cast/name"/>.rss</xsl:variable>
    <xsl:variable name="email">
        <xsl:value-of select="/cast/email"/>
        <xsl:value-of select="/cast/site"/>(<xsl:value-of select="owner"/>)</xsl:variable>
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
    
    <xsl:template match="episode">
        <xsl:variable name="epUrl">
            <xsl:value-of select="$secureUrl"/>
            <xsl:value-of select="$epDir"/>
            <xsl:value-of select="number"/>/</xsl:variable>
        <xsl:variable name="mp3Url">
            <xsl:value-of select="$insecureUrl"/>
            <xsl:value-of select="$epDir"/>
            <xsl:value-of select="number"/>/<xsl:value-of select="mp3"/>
        </xsl:variable>
        <xsl:variable name="thumbUrl">
            <xsl:value-of select="$insecureUrl"/>
            <xsl:value-of select="$epDir"/>
            <xsl:value-of select="number"/>/thumb.jpg</xsl:variable>
        <xsl:variable name="hh" select="floor(duration div 3600)"/>
        <xsl:variable name="mm" select="floor(duration div 60) mod 3600"/>
        <xsl:variable name="ss" select="duration mod 60"/>
        <xsl:variable name="hmsDur">
            <xsl:value-of select='format-number( $hh ,"00")'/>:<xsl:value-of select='format-number( $mm ,"00")'/>:<xsl:value-of select='format-number( $ss ,"00")'/>
        </xsl:variable>
        <item>
            <title>
                <xsl:value-of select="title"/>
            </title>
            <link>
                <xsl:value-of select="$epUrl"/>
            </link>
            <description>
                <xsl:value-of select="description"/>
            </description>
            <guid isPermaLink="true">
                <xsl:value-of select="$epUrl"/>
            </guid>
            <pubDate>
                <xsl:value-of select="date"/>
            </pubDate>
            <media:content
                medium="audio"
                url="{$mp3Url}"
                type="audio/mpeg"
                isDefault="true"
                expression="full"
                duration="{duration}">
                <media:title type="plain">
                    <xsl:value-of select="title"/>
                </media:title>
                <media:description>
                    <xsl:value-of select="description"/>                        
                </media:description>
                <media:rating scheme="urn:simple">nonadult</media:rating>
                <media:thumbnail url="{$thumbUrl}"/>
                <media:keywords>
                    <xsl:value-of select="tags"/>
                </media:keywords>
            </media:content>
            <enclosure url="{$mp3Url}" length="{size}" type="audio/mpeg"/>
            <itunes:image href="{$thumbUrl}"/>
            <itunes:explicit>clean</itunes:explicit>
            <itunes:duration>
                <xsl:value-of select="$hmsDur"/>
            </itunes:duration>
        </item>
    </xsl:template>
    <xsl:template match="/cast">
        <rss version="2.0" xmlns:media="http://search.yahoo.com/mrss/" xmlns:atom="http://www.w3.org/2005/Atom"
             xmlns:creativeCommons="http://backend.userland.com/creativeCommonsRssModule"
             xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">
            <channel>
                <atom:link href="{$rssUrl}" rel="self" type="application/rss+xml" />
                <title>
                    <xsl:value-of select="/cast/title"/>
                </title>
                <link>
                    <xsl:value-of select="$secureUrl"/>
                </link>
                <description>
                    <xsl:value-of select="/cast/description"/>
                </description>
                <managingEditor>
                    <xsl:value-of select="$email"/>
                </managingEditor>
                <webMaster>
                    <xsl:value-of select="$email"/>
                </webMaster>
                <language>en-gb</language>
                <copyright>Copyright (C) 2018 The contributors, all rights reserved</copyright>
                <creativeCommons:license>
                    https://creativecommons.org/licenses/by-nc-nd/4.0/
                </creativeCommons:license>
                <pubDate>Sun, 11 Mar 2018 12:00:00 GMT</pubDate>
                <lastBuildDate>
                    <xsl:value-of select="$current-date"/>
                </lastBuildDate>
                <image>
                    <url>
                        <xsl:value-of select="$insecureUrl"/>cover.jpg</url>
                    <title>
                        <xsl:value-of select="/cast/title"/>
                    </title>
                    <link>
                        <xsl:value-of select="$secureUrl"/>
                    </link>
                </image>
                <docs>http://www.rssboard.org/rss-specification</docs>
                <itunes:author>
                    <xsl:value-of select="/cast/title"/>
                </itunes:author>
                <itunes:keywords>future,technology,society</itunes:keywords>

                <itunes:category text="Technology"/>

                <itunes:explicit>clean</itunes:explicit>
                <itunes:image >
                    <xsl:attribute name="href">
                        <xsl:value-of select="$insecureUrl"/>cover.jpg</xsl:attribute>
                </itunes:image>
                <itunes:owner>
                    <itunes:name>
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                        <xsl:value-of select="/cast/title"/>
                        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                    </itunes:name>
                    <itunes:email>
                        <xsl:value-of select="$email"/>
                    </itunes:email>
                </itunes:owner>
                <xsl:call-template name="makeEpisodes">
                    <xsl:with-param name="eNum" select="$maxEpisode"/>
                </xsl:call-template>

            </channel>
        </rss>
    </xsl:template>

</xsl:stylesheet>
