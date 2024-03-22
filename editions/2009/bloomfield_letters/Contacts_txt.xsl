<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
	xmlns:tei="http://www.tei-c.org/ns/1.0" extension-element-prefixes="redirect" exclude-result-prefixes="redirect tei">
	<xsl:output omit-xml-declaration="yes" method="text" encoding="utf-8" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<!-- variables -->
	<xsl:variable name="newline">
		<xsl:text>
			
		</xsl:text>
	</xsl:variable>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:teiHeader"/>

	<xsl:template match="tei:div[@type='paratext']"/>

	<xsl:template match="tei:div">
		<xsl:for-each select="tei:list[@type='toc']/tei:item/tei:ref">
			<xsl:value-of select="substring-after(@target, '#')"/>
			<xsl:text>     </xsl:text>
			<xsl:value-of select="."/>
			<xsl:value-of select="$newline"/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
