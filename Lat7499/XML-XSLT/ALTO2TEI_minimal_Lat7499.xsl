<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:alto="http://www.loc.gov/standards/alto/ns-v4#" exclude-result-prefixes="#all"
    version="2.0">
    <!-- on déclare le namespace TEI dans élément stylesheet pour ne pas avoir à le répéter sur chacun des éléments -->


    <xsl:output encoding="UTF-8" method="xml" omit-xml-declaration="no" indent="yes"/>

    <!-- exemple avec un result document qui produit un document "sortie" dans un dossier "sortie" -->
    <xsl:template match="/" name="main">
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
                                <xsl:text/>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="sourceDesc">
                            <xsl:element name="ab">
                                <xsl:text>Fichier créé par transformation à partir de l'export réalisé dans escriptorium</xsl:text>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>

                <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>
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
                <xsl:value-of
                    select="substring-after(substring-before(alto:Description/alto:sourceImageInformation/alto:fileName/node(), '.JPEG'), 'f')"
                />
            </xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- règle vide ici pour ne pas faire apparaître de texte -->
    <xsl:template match="alto:Description"/>

    <!-- ensuite, on peut mettre les règles qu'on veut -->
    <xsl:template match="alto:TextLine">
        <xsl:choose>
            <xsl:when test="@TAGREFS='LT1523'">
                <lb facs="{descendant::alto:Polygon/@POINTS}" type="principal"/>
                <xsl:value-of select="alto:String/@CONTENT"/>
                
            </xsl:when>
            <xsl:when test="@TAGREFS='LT1524'">
                <lb facs="{descendant::alto:Polygon/@POINTS}" type="interlinear"/>
                <gloss>
                    <xsl:value-of select="alto:String/@CONTENT"/>
                </gloss>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    
    <xsl:template match="alto:TextBlock[@TAGREFS = 'BT6272']">
        <fw xmlns="http://www.tei-c.org/ns/1.0" type="marginal_note" facs="{descendant::alto:Polygon/@POINTS}">
            <xsl:apply-templates/>
        </fw>
    </xsl:template>
    
    <xsl:template match="alto:TextBlock[@TAGREFS = 'BT4666']">
        <fw xmlns="http://www.tei-c.org/ns/1.0" type="foliotation">
            <xsl:apply-templates/>
        </fw>
    </xsl:template>


    <xsl:template match="alto:String">

        <xsl:apply-templates select="@CONTENT"/>
    </xsl:template>


</xsl:stylesheet>
