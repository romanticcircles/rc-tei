<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect" xmlns:tei="http://www.tei-c.org/ns/1.0" extension-element-prefixes="redirect"
	exclude-result-prefixes="redirect tei">
	<xsl:output omit-xml-declaration="yes" method="text" encoding="utf-8" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<!-- variables -->
	<xsl:param name="id">
		<xsl:value-of select="document(/Frankenstein/part/@code)"/>
	</xsl:param>


	<xsl:variable name="newline">
		<xsl:text>
			
		</xsl:text>
	</xsl:variable>



	<xsl:template match="/">
		<xsl:for-each select="Frankenstein/part">
			<xsl:apply-templates select="document(@code)/xhtml:html"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="xhtml:html">
		<xsl:choose>
			<xsl:when test="element-available('redirect:write')">
				<xsl:for-each select=".">
					<redirect:write select="concat('BOO', $id)">
						<xsl:choose>
							<xsl:when test="element-available('redirect:write')">
								<xsl:apply-templates/>
							</xsl:when>
						</xsl:choose>
					</redirect:write>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="xhtml:html">
		<xsl:copy-of select="."/>
	</xsl:template>
</xsl:stylesheet>
