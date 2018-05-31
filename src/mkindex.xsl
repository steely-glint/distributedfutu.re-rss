<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : mkrss.xsl
    Created on : 11 March 2018, 10:10
    Author     : tim
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >
    <xsl:output method="html" indent="yes" version="4.0" encoding="UTF-8" /> 

    <xsl:variable name="secureUrl">https://<xsl:value-of select="/cast/site"/>/</xsl:variable>
    <xsl:variable name="insecureUrl">http://<xsl:value-of select="/cast/site"/>/</xsl:variable>
    <xsl:variable name="epDir">
        <xsl:value-of select="/cast/epDir"/>/</xsl:variable>

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
            <xsl:value-of select="$secureUrl"/>
            <xsl:value-of select="$epDir"/>
            <xsl:value-of select="number"/>/<xsl:value-of select="mp3"/>
        </xsl:variable>
        <xsl:variable name="transUrl">
            <xsl:value-of select="$secureUrl"/>
            <xsl:value-of select="$epDir"/>
            <xsl:value-of select="number"/>/<xsl:value-of select="transcription"/>
        </xsl:variable>
        <xsl:variable name="hh" select="round(duration div 3600)"/>
        <xsl:variable name="mm" select="round(duration div 60) mod 3600"/>
        <xsl:variable name="ss" select="duration mod 60"/>
        <xsl:variable name="hmsDur">
            <xsl:value-of select='format-number( $hh ,"00")'/>:<xsl:value-of select='format-number( $mm ,"00")'/>:<xsl:value-of select='format-number( $ss ,"00")'/>
        </xsl:variable>
        <div class="card podcast-element" id="podcastElement">
            <!-- Postcast Image-->
            <div class="card-body">
                <!-- Postcast Title-->
                <h5 class="card-title podcast-title">
                    <xsl:value-of select="title"/>
                </h5>
                <p class="card-text podcast-description">
                    <xsl:value-of select="description"/>
                </p>
                <!-- Postcast Podcast Link ID -->
                <a class="btn btn-primary">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$mp3Url"/>
                    </xsl:attribute>MP3</a>
                <a href="episodes/1/DistributedFuture1.rtf" class="btn btn-primary">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$transUrl"/>
                    </xsl:attribute>Transcript rtf</a>

                <div class="podcast-details row">
                    <!-- Postcast Guests-->
                    <div class="col text-left">Guest:<xsl:value-of select="guest"/>
                    </div>
                    <!-- Postcast Date-->
                    <div class="col text-right">
                        <xsl:value-of select="hmsDur"/>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="/cast">
        <html lang="en">
            <head>
                <!-- Required meta tags -->
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

                <!-- Bootstrap CSS -->
                <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous"> -->
                <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"/>
                <!-- Custom CSS -->
                <link rel="stylesheet" type="text/css" href="./css/style.css"/>

                <title>Distributed Future - a podcast</title>
            </head>
            <body>
                <header class="home-header">
                    <div class="container">
                        <img class="card-img-top" src="./img/dist.jpg" alt="Distributed Future"/>
                        <blockquote>"The future is out there, it just isn't evenly distributed - yet"</blockquote>
                        <p class="text-right">:William Gibson</p>
                        <p>
                            In this podcast we interview interesting people who are doing new things that may give us some insight into the future.
                        </p>
                        <p class="text-primary">Vim and Tim</p>
                        <p>
                            <a href="rss/DistributedFuture.rss">subscribe</a>
                        </p>
                    </div>
                </header>
                <div class="container">
                    <div class="podcasts">
                        <xsl:call-template name="makeEpisodes">
                            <xsl:with-param name="eNum" select="$maxEpisode"/>
                        </xsl:call-template>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
