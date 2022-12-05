<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
	<xsl:output method="xml" encoding="utf-8" indent="no"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="fileName">
		<xsl:param name="number"/>
		<xsl:value-of select="concat('#', preceding::tei:div[@type='appCharsA']/tei:list/tei:item/tei:ref[@target=$number])"/>
	</xsl:template>

	<xsl:template match="tei:div[@type='appCharsA']"/>

	<xsl:template match="tei:div[@type='appCharsB']/tei:list/tei:item/tei:term">
		<xsl:for-each select=".">
			<term xmlns="http://www.tei-c.org/ns/1.0">
				<xsl:attribute name="target">
					<xsl:call-template name="fileName">
						<xsl:with-param name="number">
							<xsl:value-of select="parent::tei:item/@n"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:apply-templates/>
			</term>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
