<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="tei:ref">
		<xsl:variable name="letNumber">
			<xsl:value-of select="substring-before(substring-after(., ' '), '.')"/>
		</xsl:variable>
		<xsl:variable name="url">
			<xsl:value-of select="concat('letterEEd.26.', $letNumber, '.html')"/>
		</xsl:variable>
		<ref xmlns="http://www.tei-c.org/ns/1.0">
			<xsl:attribute name="target" select="$url"/>
				<xsl:value-of select="."/>
		</ref>
	</xsl:template>
	
</xsl:stylesheet>