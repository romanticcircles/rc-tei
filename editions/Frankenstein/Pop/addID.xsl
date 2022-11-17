<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
	<xsl:output method="xml" encoding="utf-8" indent="no"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="tei:div[@type='appPopB']/tei:list/tei:item">
		<xsl:for-each select=".">
			<item xmlns="http://www.tei-c.org/ns/1.0">
				<xsl:attribute name="n">
					<xsl:call-template name="number"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</item>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="number">
		<xsl:number count="tei:TEI/tei:text/tei:body/tei:div[@type='appPopB']/tei:list/tei:item"/>
	</xsl:template>

</xsl:stylesheet>
