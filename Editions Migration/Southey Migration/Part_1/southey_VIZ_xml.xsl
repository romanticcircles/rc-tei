<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
	xmlns:tei="http://www.tei-c.org/ns/1.0" extension-element-prefixes="redirect" exclude-result-prefixes="redirect tei">
	<xsl:output omit-xml-declaration="no" method="xml" encoding="ISO-8859-1" indent="no"/>
	<xsl:strip-space elements="*"/>

	<!-- global variables -->
	<xsl:variable name="newline">
		<xsl:text>&#10;</xsl:text>
	</xsl:variable>

	<xsl:template match="/">
		<viz>
		<xsl:for-each select="Southey/letter">
			<xsl:apply-templates select="document(@code)/tei:TEI"/>
		</xsl:for-each>
			</viz>
	</xsl:template>

	<xsl:template match="tei:TEI">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:teiHeader"/>

	<xsl:template match="tei:text">
		<xsl:apply-templates select="tei:body/tei:div[@type='letter']"/>
	</xsl:template>

	<xsl:template match="tei:div[@type='letter']">
		<xsl:variable name="self">
			<xsl:value-of select="tei:head/tei:ref[1]"/>
		</xsl:variable>
		<xsl:variable name="addressee">
			<xsl:call-template name="lookUpName">
				<xsl:with-param name="nameCode" select="substring-after(tei:head/tei:ref[1]/@target, 'people.html#')"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:for-each select="tei:p//tei:ref">
			<xsl:choose>
				<xsl:when test="matches(., $self)"/>
				<xsl:when test="contains(@target, 'places.html')"/>
				<xsl:when test="contains(@target, 'people.html')">
					<xsl:value-of select="$newline"/>
					<addressee><xsl:value-of select="$addressee"/></addressee>
					<edge>
						<xsl:attribute name="letter">
							<xsl:value-of select="substring-after(ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno, 'letterEEd.26.')"/>
						</xsl:attribute>
					</edge>
					<ref><xsl:call-template name="lookUpName">
						<xsl:with-param name="nameCode" select="substring-after(@target, 'people.html#')"/>
					</xsl:call-template>
						</ref>
					<xsl:value-of select="$newline"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="lookUpName">
		<xsl:param name="nameCode"/>
		<xsl:for-each select="substring-before(document('peoplePartI.xml')//*/tei:term[@xml:id=$nameCode], ':')">
			<xsl:value-of select="translate(translate(., '&#8211;', '&#45;'), '&#8216;&#8217;', '')"/>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
