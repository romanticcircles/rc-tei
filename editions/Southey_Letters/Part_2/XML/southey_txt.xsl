<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
	xmlns:tei="http://www.tei-c.org/ns/1.0" extension-element-prefixes="redirect" exclude-result-prefixes="redirect tei">
	<xsl:output omit-xml-declaration="yes" method="text" encoding="utf-8" indent="no"/>
	<xsl:strip-space elements="*"/>

	<!-- global variables -->
	<xsl:variable name="newline">
		<xsl:text>&#10;</xsl:text>
	</xsl:variable>

	<xsl:template match="/">
		<xsl:for-each select="Southey/letter">
			<xsl:apply-templates select="document(@code)/tei:TEI"/>
		</xsl:for-each>
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
			<xsl:text>&#x09;&#x09;&#x09;</xsl:text>
			<xsl:text> is connected to</xsl:text>
		</xsl:variable>
		<xsl:for-each select="tei:p//tei:ref">
			<xsl:choose>
				<xsl:when test="matches(., $self)"/>
				<xsl:when test="contains(@target, 'places.html')"/>
				<xsl:when test="contains(@target, 'people.html')">
					<xsl:value-of select="$newline"/>
					<xsl:value-of select="$addressee"/>
					<xsl:text>&#x09;&#x09;&#x09;</xsl:text>
					<xsl:call-template name="lookUpName">
						<xsl:with-param name="nameCode" select="substring-after(@target, 'people.html#')"/>
					</xsl:call-template>
					<xsl:value-of select="$newline"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="lookUpName">
		<xsl:param name="nameCode"/>
		<xsl:for-each
			select="substring-before(document('peoplePartII.xml')//*/tei:term[@xml:id=$nameCode], ':')">
<!--			<xsl:if test="tei:persName/tei:roleName/@type='prefix'">
				<xsl:value-of select="tei:persName/tei:roleName[@type='prefix']"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="tei:persName/tei:roleName/@type='honorific'">
				<xsl:value-of select="tei:persName/tei:roleName[@type='honorific']"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="tei:persName/tei:forename">
				<xsl:value-of select="tei:persName/tei:forename"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="tei:persName/tei:addName/@type='nickname'">
				<xsl:text>'</xsl:text>
				<xsl:value-of select="tei:persName/tei:addName[@type='nickname']"/>
				<xsl:text>' </xsl:text>
			</xsl:if>
			<xsl:value-of select="tei:persName/tei:surname"/>
			<xsl:choose>
				<xsl:when test="tei:persName/tei:date">
					<xsl:text> </xsl:text>
					<xsl:choose>
						<xsl:when test="tei:persName/tei:date/@to != ''">
							<xsl:text>d. </xsl:text>
							<xsl:value-of select="tei:persName/tei:date/@to"/>
						</xsl:when>
						<xsl:when test="tei:persName/tei:date/@from != ''">
							<xsl:text>b. </xsl:text>
							<xsl:value-of select="tei:persName/tei:date/@from"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>d. </xsl:text>
							<xsl:value-of select="substring-after(tei:persName/tei:date, '–')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="tei:persName/tei:roleName/@type='family'">
					<xsl:text> (</xsl:text>
					<xsl:value-of select="tei:persName/tei:roleName[@type='family']"/>
					<xsl:text>)</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="tei:persName/tei:roleName/@type='suffix'">
				<xsl:text> </xsl:text>
				<xsl:value-of select="tei:persName/tei:roleName[@type='suffix']"/>
				</xsl:if> -->
			<xsl:value-of select="."/>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
