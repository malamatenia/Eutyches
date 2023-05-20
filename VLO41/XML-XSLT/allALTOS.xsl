<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:alto="http://www.loc.gov/standards/alto/ns-v4#">
    
    
    <xsl:output method="xml"/>
 
    <xsl:template match="/">
        
        <xsl:copy>
            
            <xsl:apply-templates mode="rootcopy"/>
            
        </xsl:copy>
        
    </xsl:template>
    
    
    
    <xsl:template match="node()" mode="rootcopy">
        
        <xsl:copy>
            
            <xsl:variable name="folderURI" select="resolve-uri('.',base-uri())"/>
            
            <!--Sort xml files by name-->
            
            
            <xsl:for-each select="collection(concat($folderURI, '?select=*.xml'))/*/node()">
                <xsl:sort
                    select="substring-before(substring-after(base-uri(), 'f'), '.xml')"/>
            
            <!--Je veux créer une variable folio qui prendra le numéro de mes folios p.ex.'02r' = tout ce qui est après "f" et 
                créer un element <pb n="nom-du-fichier-de-chaque-folio"> comme l'exemple que je vous ai montré ,
                mais j'arrive pas a le faire trouver le numero+r/v-->
            
         <!-- <xsl:variable name="folio">
                    <xsl:value-of
                        select="substring-before(substring-after(base-uri(), 'f'), '.xml')"/>
                </xsl:variable>
                <xsl:element name="pb" namespace="http://www.tei-c.org/ns/1.0"></xsl:element>
                    <xsl:attribute name="n">
                        <xsl:value-of select="$folio"/>
                    </xsl:attribute>-->
                
 
                
                <xsl:apply-templates mode="copy" select="."/>
                
            </xsl:for-each>
         
            
        </xsl:copy>
        
    </xsl:template>
    
        
    <!-- Deep copy template -->
    
    <xsl:template match="node()|@*" mode="copy">
        
        <xsl:copy>
            
            <xsl:apply-templates mode="copy" select="@*"/>
            
            <xsl:apply-templates mode="copy"/>
            
        </xsl:copy>
        
    </xsl:template>
    
    
    
    <!-- Handle default matching -->
    
    <xsl:template match="*"/>
    
    
</xsl:stylesheet>


