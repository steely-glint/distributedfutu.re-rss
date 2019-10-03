<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : mkrss.xsl
    Created on : 11 March 2018, 10:10
    Author     : tim
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes" version="4.0" encoding="UTF-8"/>

    <xsl:variable name="secureUrl">https://<xsl:value-of select="/cast/site"/>/
    </xsl:variable>
    <xsl:variable name="insecureUrl">http://<xsl:value-of select="/cast/site"/>/
    </xsl:variable>
    <xsl:variable name="epDir">
        <xsl:value-of select="/cast/epDir"/>/
    </xsl:variable>

    <xsl:variable name="rssUrl">
        <xsl:value-of select="$secureUrl"/>
        <xsl:value-of select="/cast/rssDir"/>
        <xsl:value-of select="/cast/name"/>.rss
    </xsl:variable>
    <xsl:variable name="email">
        <xsl:value-of select="/cast/email"/>
        <xsl:value-of select="/cast/site"/>(<xsl:value-of select="owner"/>)
    </xsl:variable>
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
    <xsl:template name="makeButtons">

        <xsl:apply-templates select="document('buttons.xml')">
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="episode">
        <xsl:variable name="mp3Url">
            <xsl:value-of select="$epDir"/>
            <xsl:value-of select="number"/>/
            <xsl:value-of select="mp3"/>
        </xsl:variable>
        <xsl:variable name="transUrl">
            <xsl:value-of select="$epDir"/>
            <xsl:value-of select="number"/>/
            <xsl:value-of select="transcription"/>
        </xsl:variable>
        <xsl:variable name="thumbUrl">
            <xsl:value-of select="$epDir"/>
            <xsl:value-of select="number"/>
            <xsl:text>/thumb.jpg</xsl:text>
        </xsl:variable>
        <xsl:variable name="hh" select="floor(duration div 3600)"/>
        <xsl:variable name="mm" select="floor(duration div 60) mod 3600"/>
        <xsl:variable name="ss" select="duration mod 60"/>
        <xsl:variable name="hmsDur">
            <xsl:value-of select='format-number( $hh ,"00")'/>:<xsl:value-of select='format-number( $mm ,"00")'/>:
            <xsl:value-of
                    select='format-number( $ss ,"00")'/>
        </xsl:variable>
        <div class="card podcast-element">
            <xsl:attribute name="id">episode
                <xsl:value-of select="number"/>
            </xsl:attribute>
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
                <div class="row">
                    <div class="col">
                        <audio controls="controls" preload="none">
                            <xsl:attribute name="src">
                                <xsl:value-of select="$mp3Url"/>
                            </xsl:attribute>
                        </audio>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-auto">
                        <a class="btn btn-primary">
                            <xsl:attribute name="href">
                                <xsl:value-of select="$mp3Url"/>
                            </xsl:attribute>
                            <span>
                                <i class="fa fa-headphones-alt fa-lg"></i>
                            </span>
                            Download mp3
                        </a>
                    </div>
                    <div class="col-md-auto">
                        <a target="_blank" class="btn btn-primary">
                            <xsl:attribute name="href">
                                <xsl:value-of select="substring-before($transUrl,'.')"/>
                                <xsl:text>.html</xsl:text>
                            </xsl:attribute>
                            Transcript
                        </a>
                    </div>
                </div>
                <div class="podcast-details row">
                    <!-- Postcast Guests-->
                    <div class="col text-left">Guest:
                        <xsl:value-of select="guest"/>
                        <br/>
                        <img height="60" width="60">
                            <xsl:attribute name="src">
                                <xsl:value-of select="$thumbUrl"/>
                            </xsl:attribute>
                        </img>
                    </div>
                    <!-- Postcast Date-->
                    <div class="col text-right">
                        <xsl:value-of select="$hmsDur"/>
                    </div>
                </div>
                <div class="podcast-links row well ">
                    Links:
                    <div>
                        <xsl:for-each select="links/link">
                            <xsl:variable name="href" select="."/>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="$href"/>
                                </xsl:attribute>
                                <xsl:value-of select="$href"/>
                            </a>
                            <br/>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="/buttons">
        <xsl:for-each select="button">
            <div class="col">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="link"/>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:value-of select="image"/>
                        </xsl:attribute>
                        <xsl:attribute name="alt">
                            <xsl:value-of select="name"/>
                        </xsl:attribute>
                        <xsl:if test="@size">
                            <xsl:attribute name="width">
                                <xsl:value-of select="@size"/>
                            </xsl:attribute>
                            <xsl:attribute name="width">
                                <xsl:value-of select="@size"/>
                            </xsl:attribute>
                        </xsl:if>
                    </img>
                    <xsl:if test="@dotext">
                        <xsl:value-of select="name"/>
                    </xsl:if>
                </a>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="/cast">
        <html lang="en">
            <head>
                <!-- Required meta tags -->
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

                <!-- Bootstrap CSS -->
                <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous"> -->
                <link rel="stylesheet" type="text/css"
                      href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"/>
                <!-- Custom CSS -->
                <link rel="stylesheet"
                      href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
                <link rel="stylesheet" type="text/css" href="./css/style.css"/>

                <title>Distributed Future - a podcast</title>
            </head>
            <body>
                <header class="home-header">
                    <img class="card-img-top" src="./img/dist.jpg" alt="Distributed Future"/>
                    <h2 class="card-title">"The future is out there, it just isn't evenly distributed
                        - yet" :- William Gibson
                    </h2>
                    <h4 class="card-text">
                        In this podcast we interview interesting people who are doing new things that may give us
                        some insight into the future.
                    </h4>
                    <br/>
                    <div class="col">
                        <div class="row justify-content-start">
                            <div class="col-auto">Hosts:</div>
                            <div class="col-auto">
                                <a href="https://twitter.com/thatgirlvim">
                                    <img height="60" width="60" src="./img/vim.jpg">
                                    </img>
                                    <br/>Vim
                                </a>
                            </div>
                            <div class="col-auto">and</div>
                            <div class="col-auto">
                                <a href="https://twitter.com/steely_glint">
                                    <img height="60" width="60" src="./img/tim.jpg">
                                    </img>
                                    <br/>Tim
                                </a>
                            </div>
                        </div>
                    </div>
                    <br/>

                    <div class="col">
                        <div class="row">Listen using one of these great apps:</div>
                        <div class="row justify-content-start">
                            <xsl:call-template name="makeButtons">
                            </xsl:call-template>
                            <div class="col">
                                <a class="btn btn-success" href="rss/DistributedFuture.rss">
                                    <span>
                                        <i class="fa fa-rss"></i>
                                    </span>
                                    RSS
                                </a>
                            </div>
                        </div>
                    </div>
                <br/>
                </header>
                <div class="container">
                    <div class="podcasts">
                        <xsl:call-template name="makeEpisodes">
                            <xsl:with-param name="eNum" select="$maxEpisode"/>
                        </xsl:call-template>
                    </div>
                </div>
                <footer>
                    <p>Recorded using <a href="https://github.com/pipe/podcall">Podcall</a>, transcribed with the help
                        of <a href="https://descript.com/r/BJ-AHGvDM">Descript</a>, chime by <a
                                href="https://www.instagram.com/allegro_alchemist/">Ellie</a>, website help from <a
                                href="http://www.birgitpohl.com/">Birgit Pohl
                        </a> and graphic by Chris Panton
                    </p>
                </footer>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
