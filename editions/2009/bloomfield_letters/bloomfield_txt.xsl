<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
	xmlns:tei="http://www.tei-c.org/ns/1.0" extension-element-prefixes="redirect" exclude-result-prefixes="redirect tei">
	<xsl:output omit-xml-declaration="yes" method="text" encoding="utf-8" indent="no"/>
	<xsl:strip-space elements="*"/>

	<!-- variables -->
	<xsl:variable name="newline">
		<xsl:text>
				
			</xsl:text>
	</xsl:variable>

	<xsl:template match="/">
		<xsl:for-each select="Bloomfield/letter">
			<xsl:apply-templates select="document(@code)/tei:TEI"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="tei:TEI">
		<xsl:for-each select="tei:text/tei:body/tei:div//*/tei:ref">
			<xsl:variable name="refTGT">
				<xsl:value-of select="substring-after(@target, 'people.html#')"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="contains(@target, 'places.html')"/>
				<xsl:when test="contains(@target, 'people.html')">
					<xsl:value-of
						select="substring-after(ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno, 'letterEEd.25.')"/>
					<xsl:text>     </xsl:text>
					<xsl:value-of select="$refTGT"/>
					<xsl:value-of select="$newline"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
