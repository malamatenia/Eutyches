<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Match pb elements -->
    <xsl:template match="tei:pb">
        <!-- Copy the pb element as it is -->
        <xsl:copy-of select="."/>
        <!-- Retrieve the value of the "n" attribute -->
        <xsl:variable name="folio" select="@n"/>
        <!-- Output the value of "n" attribute -->
        <xsl:text>folio=</xsl:text>
        <xsl:value-of select="$folio"/>
        <xsl:text>&#x0A;</xsl:text>
    </xsl:template>
    
    <!-- Match lb elements with @type='principal' -->
    <xsl:template match="tei:lb[@type='principal']">
        <xsl:choose>
            <!-- Check if the parent is fw with @type='marginal_note' -->
            <xsl:when test="parent::tei:fw[@type='marginal_note']">
                <!-- Ignore lb elements inside fw -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@break='no'">
                        <xsl:text>-&#x0a;</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>&#x0a;</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader"/>
    <xsl:template match="tei:gloss"/>    
    <xsl:template match="tei:fw[@type='marginal_note']"/>
    <xsl:template match="tei:quote"/>
    
</xsl:stylesheet>