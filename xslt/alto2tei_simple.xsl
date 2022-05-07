<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:alto="http://www.loc.gov/standards/alto/ns-v4#">
    
    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no" indent="yes"/>
   
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="sigle"/>
    <xsl:param name="input_files"/>
    <xsl:param name="output_file"/>
    
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml"/>
    
    <xsl:template match="/">
        <xsl:result-document href="{$output_file}">
            <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="xml:id">VL41</xsl:attribute>
                <xsl:element name="teiHeader" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fileDesc" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="titleStmt" namespace="http://www.tei-c.org/ns/1.0">
                        </xsl:element>
                        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$sigle"/>
                        </xsl:element>
                        <xsl:element name="publicationStmt" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">Publication
                                information</xsl:element>
                        </xsl:element>
                        <xsl:element name="sourceDesc" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">Information
                                about the source</xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="facsimile" namespace="http://www.tei-c.org/ns/1.0"/>
                <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:for-each select="collection(concat($input_files,'?select=*.xml'))/*/node()">
                                    <!--Change expression here to adapt to filenames-->
                                <!--<xsl:for-each select="collection(concat($input_files,'?select=*.xml;recurse=yes'))/*/node()">-->
                                    <xsl:sort
                                        select="substring-before(substring-after(base-uri(),'f'), '.xml')"/>
                                    <xsl:variable name="folio">
                                        <xsl:value-of
                                            select="substring-before(substring-after(substring-after(base-uri(), '/'), '-'), '.xml')"
                                        />
                                    </xsl:variable>
                                    <xsl:element name="pb" namespace="http://www.tei-c.org/ns/1.0">
                                        <xsl:attribute name="n">
                                            <xsl:value-of select="$folio"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="facs">
                                            <xsl:value-of
                                                select="concat($input_files, '/', descendant::alto:Description/alto:sourceImageInformation/alto:fileName)"
                                            />
                                        </xsl:attribute>
                                    </xsl:element>
                                    <xsl:apply-templates select="descendant::alto:alto"/>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>
    
    
    
    <xsl:template match="alto:tags">
        <!--Ici on peut se servir de la typologie pour créer une typologie dans le tei:teiHeader-->
    </xsl:template>

    <xsl:template match="/">
        <xsl:element name="TEI">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
   
    

    <xsl:template match="alto:TextLine">
        <xsl:element name="lb">
            <xsl:attribute name="break">?</xsl:attribute>
            <xsl:attribute name="facs">
                <xsl:value-of select="descendant::alto:Polygon/@POINTS"/>
            </xsl:attribute>
            
            <xsl:attribute name="type">
            <!--Attribute lb pour Les Lignes Principales(SegmOnto=DefaultLine)et gloss pour les InterlinearLine(SegmOnto=InterlinearLine)-->
            <xsl:choose>
                <xsl:when test="@TAGREFS='LT1094'">
                    <xsl:value-of select="'lb'"/>          
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'gloss'"/>
                </xsl:otherwise>
            </xsl:choose>
            </xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>       
       <!-- <xsl:value-of select="alto:String/@CONTENT"/>-->
    </xsl:template>
    
    
    
    <xsl:template match="alto:String">
        
        <xsl:apply-templates select="@CONTENT"/>
    </xsl:template>
    
    
    
    <!--<xsl:template match="tei:lb">
        <xsl:if test="@break='no'">
            <xsl:text>-</xsl:text>
        </xsl:if>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
    -->
    
   
      
</xsl:stylesheet>