<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
     <!--<xsl:strip-space elements="*"/> --> 
    
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
   <!-- Je choisis d'afficher que les lignes principales du texte-->
   
    <xsl:template match="tei:lb[@type=principal]">
        <xsl:choose>
            <xsl:when test="@break='no'">
                <xsl:text>-&#x0a;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   
    
    <xsl:template match="tei:teiHeader"/>
    <xsl:template match="tei:gloss"/>    
    <xsl:template match="tei:fw[@type=marginal_note]"/>
    <xsl:template match="tei:quote"/>
   
 
    
    
</xsl:stylesheet>