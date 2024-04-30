<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei"
	extension-element-prefixes="redirect" xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect">
	<xsl:output method="xml" encoding="utf-8" indent="no"/>
	<xsl:strip-space elements="*"/>

	<!-- for inserting header information -->
	<xsl:template match="/">
		<xsl:for-each select="Bloomfield/letter">
			<xsl:apply-templates select="document(@code)/tei:TEI"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="tei:TEI">
		<xsl:choose>
			<xsl:when test="element-available('redirect:write')">
				<xsl:for-each select=".">
					<xsl:variable name="id">
						<xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno"/>
					</xsl:variable>
					<redirect:write select="concat($id, '.xml')">
						<TEI xmlns="http://www.tei-c.org/ns/1.0">
							<xsl:apply-templates/>
						</TEI>
					</redirect:write>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy inherit-namespaces="no">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="tei:quotation">
		<quotation xmlns="http://www.tei-c.org/ns/1.0">
			<p>All quotation marks and apostrophes have been changed: " for “," for ”, ' for ‘, and ' for ’.</p>
		</quotation>
	</xsl:template>


	<xsl:template match="text()">
		<xsl:variable name="quotation">
			<xsl:text disable-output-escaping="yes">""</xsl:text>
		</xsl:variable>
		<xsl:variable name="apostrophe">
			<xsl:text disable-output-escaping="yes">''</xsl:text>
		</xsl:variable>
		<xsl:value-of select="translate(., '‘’', $apostrophe)"/>
	</xsl:template>


</xsl:stylesheet>
