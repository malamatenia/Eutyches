<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:alto="http://www.loc.gov/standards/alto/ns-v4#"
    exclude-result-prefixes="#all" version="2.0">
    <!-- on déclare le namespace TEI dans élément stylesheet pour ne pas avoir à le répéter sur chacun des éléments -->
    
    
    <xsl:output encoding="UTF-8" method="xml" omit-xml-declaration="no" indent="yes"/>
    
    <!-- exemple avec un result document qui produit un document "sortie" dans un dossier "sortie" -->
    <xsl:template match='/' name="main">
        <xsl:result-document href="../sortie/VLO41_ALTO2TEI_minimal.xml" method="xml">
            
            <!-- structuration d'un TEI valide -->
            <xsl:element name="TEI">                  
                <xsl:element name="teiHeader">
                    <xsl:element name="fileDesc">
                        <xsl:element name="titleStmt">
                            <xsl:element name="title">
                                <xsl:text>Titre</xsl:text>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="publicationStmt">
                            <xsl:element name="p">
                                <xsl:text></xsl:text>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="sourceDesc">
                            <xsl:element name="p">
                                <xsl:text>Fichier créé par transformation à partir de l'export réalisé dans escriptorium</xsl:text>
                            </xsl:element>
                        </xsl:element> 
                    </xsl:element>
                </xsl:element>
                
                <xsl:variable name="folderURI" select="resolve-uri('.',base-uri())"/>
                <xsl:variable name="facsi">
                    <xsl:perform-sort select="collection(concat($folderURI, '?select=*.xml'))/*">
                        <xsl:sort select="."/>  
                    </xsl:perform-sort>
                </xsl:variable>

                <xsl:element name="text">
                    <xsl:element name="body">
                        <xsl:element name="p">
                            <!-- à l'intérieur du p de body, pour chaque document, on apllique les règles -->
                            <xsl:for-each select="$facsi">
                            
                                <xsl:apply-templates select="alto:alto"/>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:result-document>
        
    </xsl:template>
    
    <!-- règle sur alto -->
    <xsl:template match="alto:alto">
        <!-- pour chaque élément alto, on crée un pb qui reprend la valeur qu'il y a dans fileName -->
        <xsl:element name="pb">
            <xsl:attribute name="n">
                <xsl:value-of select="substring-after(substring-before(alto:Description/alto:sourceImageInformation/alto:fileName/node(), '.jpg'), 'f')"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- règle vide ici pour ne pas faire apparaître de texte -->
    <xsl:template match="alto:Description"/>
    
    <!-- ensuite, on peut mettre les règles qu'on veut -->
 
    <xsl:template match="alto:TextLine">
        <xsl:element name="lb">
            <xsl:attribute name="facs">
                <xsl:value-of select="descendant::alto:Polygon/@POINTS"/>
            </xsl:attribute>
            
            <xsl:attribute name="type">
                <!--Attribute lb pour Les Lignes Principales(SegmOnto=DefaultLine)et gloss pour les InterlinearLine(SegmOnto=InterlinearLine)-->
                <xsl:choose>
                    <xsl:when test="@TAGREFS='LT1094'">
                        <xsl:value-of select="'principal'"/>          
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'interlinear'"/>
                    </xsl:otherwise>
                </xsl:choose>             
            </xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>       
        <!-- <xsl:value-of select="alto:String/@CONTENT"/>-->
    </xsl:template>
    
    <xsl:template match="alto:TextBlock[@TAGREFS = 'BT3137']">
        <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">marginal_note</xsl:attribute>
            <xsl:attribute name="facs">                
                <xsl:value-of select="descendant::alto:Polygon/@POINTS"/>
            </xsl:attribute>          
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="alto:TextBlock[@TAGREFS = 'BT3138']">
        <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">foliotation</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="alto:String">
        
        <xsl:apply-templates select="@CONTENT"/>
    </xsl:template>
    
   
</xsl:stylesheet>