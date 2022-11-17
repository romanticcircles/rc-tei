<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
	xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0" extension-element-prefixes="redirect"
	exclude-result-prefixes="redirect tei xhtml">
	<xsl:output omit-xml-declaration="yes" method="xml" encoding="utf-8" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<!-- variables -->
	<xsl:variable name="newline">
		<xsl:text>
			
		</xsl:text>
	</xsl:variable>

	<xsl:template match="/">
		<Frankenstein xmlns:xhtml="http://www.w3.org/1999/xhtml">
			<xsl:apply-templates/>
		</Frankenstein>
	</xsl:template>

	<xsl:template match="Franenstein" mode="if">
		<xsl:for-each select="part">
			<if>
				<xsl:value-of select="@n"/>
				<xsl:value-of select="@code"/>
			</if>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>
