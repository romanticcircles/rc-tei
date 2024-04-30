<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
	exclude-result-prefixes="xs" version="2.0" extension-element-prefixes="redirect" xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect">
	<xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Aug 24, 2010</xd:p>
			<xd:p><xd:b>Author:</xd:b> mandellc</xd:p>
			<xd:p>This chops an edition up into parts -- TEI-encoded files of each part of an edition -- if it comes in as one long file, and
				simultaneously creates a) the list you need to process all the parts, and b) the xml for a table of contents as part of the files to
				be processed.</xd:p>
		</xd:desc>
	</xd:doc>

	<xsl:output encoding="UTF-8" method="xml" indent="yes"/>

	<xsl:variable name="idNumber">
		<xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno"/>
	</xsl:variable>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="tei:TEI">
		<xsl:choose>
			<xsl:when test="element-available('redirect:write')">
				<redirect:write select="concat($idNumber, 'Contents.xml')">
					<TEI xmlns="http://www.tei-c.org/ns/1.0">
						<xsl:call-template name="insertHeader">
							<xsl:with-param name="newIdno">
								<xsl:value-of select="concat($idNumber, 'Contents')"/>
							</xsl:with-param>
							<xsl:with-param name="analytic">Contents</xsl:with-param>
							<xsl:with-param name="genre">Paratext</xsl:with-param>
						</xsl:call-template>
						<text>
							<body>
								<div type="paratext">
									<head>Contents</head>
									<list>
										<xsl:if test="tei:text/tei:front/tei:titlePage">
											<item>
												<ref>
													<xsl:attribute name="target">
														<xsl:value-of select="concat($idNumber, 'titlePage.html')"/>
													</xsl:attribute>
													<xsl:text>Title Page</xsl:text>
												</ref>
											</item>
										</xsl:if>
										<!-- these items will change for each edition; they are text files separate from the main file -->
										<item>
											<ref>
												<xsl:attribute name="target">
													<xsl:value-of select="concat($idNumber, 'Intro.html')"/>
												</xsl:attribute>Editor's Introduction: &quot;<title>Thoughts in Prison</title> / Imprisoned Thoughts&quot;</ref>
										</item>
										<item>
											<ref><xsl:attribute name="target">
													<xsl:value-of select="concat($idNumber, 'worksCited.html')"/>
												</xsl:attribute>Editor's Bibliography</ref>
										</item>
										<xsl:for-each select="tei:text//tei:div">
											<item>
												<ref>
													<xsl:attribute name="target">
														<xsl:value-of select="concat($idNumber, @type, @n, '.html')"/>
													</xsl:attribute>
													<xsl:choose>
														<xsl:when test="tei:head">
															<xsl:value-of select="tei:head"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of
																select="translate(substring(@type, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
															<xsl:value-of select="substring(@type, 2)"/>
														</xsl:otherwise>
													</xsl:choose>
												</ref>
											</item>
										</xsl:for-each>
									</list>
								</div>
							</body>
						</text>
					</TEI>
				</redirect:write>
			</xsl:when>
		</xsl:choose>
		<Edition xmlns:tei="http://www.tei-c.org/ns/1.0">
			<xsl:if test="tei:text/tei:front/tei:titlePage">
				<part code="{$idNumber}titlePage.xml"/>
			</xsl:if>
			<part code="{$idNumber}Contents.xml"/>
			<xsl:if test="tei:text/tei:front/tei:titlePage">
				<xsl:apply-templates select="tei:text/tei:front/tei:titlePage"/>
			</xsl:if>
			<xsl:apply-templates select="tei:text//tei:div"/>
			<!-- these items will change for each edition; they are text files separate from the main file -->
			<part code="{$idNumber}Intro.xml"/>
			<part code="{$idNumber}worksCited.xml"/>
			<part code="{$idNumber}about.xml"/>
			<part code="{$idNumber}appendix.xml"/>
		</Edition>
	</xsl:template>

	<xsl:template match="tei:text/tei:front/tei:titlePage">
		<xsl:variable name="tpIDNumber">
			<xsl:value-of select="concat($idNumber, 'titlePage')"/>
		</xsl:variable>
		<xsl:variable name="tpName">Title Page</xsl:variable>
		<xsl:variable name="tpGenre">Paratext</xsl:variable>
		<xsl:choose>
			<xsl:when test="element-available('redirect:write')">
				<xsl:for-each select=".">
					<redirect:write select="concat($tpIDNumber, '.xml')">
						<TEI xmlns="http://www.tei-c.org/ns/1.0">
							<xsl:call-template name="insertHeader">
								<xsl:with-param name="newIdno" select="$tpIDNumber"/>
								<xsl:with-param name="analytic" select="$tpName"/>
								<xsl:with-param name="genre" select="$tpGenre"/>
							</xsl:call-template>
							<text>
								<front>
									<xsl:copy>
										<xsl:apply-templates select="@* | node()"/>
									</xsl:copy>
								</front>
								<body>
									<div>
										<p>
											<xsl:text>  </xsl:text>
										</p>
									</div>
								</body>
							</text>
						</TEI>
					</redirect:write>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:text//tei:div">
		<xsl:variable name="divIDNumber">
			<xsl:value-of select="concat($idNumber, @type, @n)"/>
		</xsl:variable>

		<xsl:variable name="divName">
			<xsl:choose>
				<xsl:when test="tei:head/tei:title">
					<xsl:value-of select="tei:head/tei:title[@type='main']"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="tei:head"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="divAuthor">
			<xsl:choose>
				<xsl:when test="tei:byline">
					<xsl:value-of select="tei:byline"/>
				</xsl:when>
				<xsl:when test="@type='paratext'">
					<xsl:value-of
						select="ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:publisher/node()/@*"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of
						select="ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:author/node()/@*"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="divGenre">
			<xsl:choose>
				<xsl:when test="@bibliography">
					<xsl:text>Bibliography</xsl:text>
				</xsl:when>
				<xsl:when test="@type='essay'">
					<xsl:text>Criticism</xsl:text>
				</xsl:when>
				<xsl:when test="@type='paratext'">
					<xsl:text>Paratext</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!-- PUT IN THE GENRE HERE -->
					<xsl:text>Poetry</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="element-available('redirect:write')">
				<xsl:for-each select=".">
					<redirect:write select="concat($divIDNumber, '.xml')">
						<TEI xmlns="http://www.tei-c.org/ns/1.0">
							<xsl:call-template name="insertHeader">
								<xsl:with-param name="newIdno" select="$divIDNumber"/>
								<xsl:with-param name="analytic" select="$divName"/>
								<xsl:with-param name="author" select="$divAuthor"/>
								<xsl:with-param name="genre" select="$divGenre"/>
							</xsl:call-template>
							<text>
								<body>
									<xsl:copy>
										<xsl:apply-templates select="@* | node()"/>
									</xsl:copy>
								</body>
							</text>
						</TEI>
					</redirect:write>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
		<part>
			<xsl:attribute name="code">
				<xsl:for-each select=".">
					<xsl:value-of select="concat($divIDNumber, '.xml')"/>
				</xsl:for-each>
			</xsl:attribute>
		</part>
	</xsl:template>

	<xsl:template name="insertHeader">
		<xsl:param name="newIdno"/>
		<xsl:param name="analytic"/>
		<xsl:param name="author"/>
		<xsl:param name="genre"/>
		<teiHeader xmlns="http://www.tei-c.org/ns/1.0">
			<fileDesc xmlns="http://www.tei-c.org/ns/1.0">
				<xsl:copy-of select="document('header.xml')//*/tei:fileDesc/tei:titleStmt"/>
				<publicationStmt xmlns="http://www.tei-c.org/ns/1.0">
					<idno>
						<xsl:value-of select="$newIdno"/>
					</idno>
					<xsl:copy-of select="document('header.xml')//*/tei:publicationStmt/tei:publisher"/>
					<xsl:copy-of select="document('header.xml')//*/tei:publicationStmt/tei:pubPlace"/>
					<xsl:copy-of select="document('header.xml')//*/tei:publicationStmt/tei:date"/>
					<xsl:copy-of select="document('header.xml')//*/tei:publicationStmt/tei:availability"/>
				</publicationStmt>
				<sourceDesc>
					<biblStruct>
						<analytic>
							<title level="a">
								<xsl:value-of select="$analytic"/>
							</title>
							<xsl:if test="not($author = '')">
								<author>
									<xsl:value-of select="$author"/>
								</author>
							</xsl:if>
						</analytic>
						<xsl:copy-of select="document('header.xml')//*/tei:sourceDesc/tei:biblStruct/tei:monogr"/>
					</biblStruct>
				</sourceDesc>
			</fileDesc>
			<xsl:copy-of select="document('header.xml')//*/tei:encodingDesc"/>
			<profileDesc>
				<textClass>
					<catRef>
						<xsl:attribute name="scheme">
							<xsl:value-of select="concat('#', document('header.xml')//*/tei:encodingDesc/tei:classDecl/tei:taxonomy/@xml:id)"/>
						</xsl:attribute>
						<xsl:attribute name="target">
							<xsl:for-each select="document('header.xml')//*/tei:encodingDesc/tei:classDecl/tei:taxonomy/tei:category">
								<xsl:variable name="catID">
									<xsl:value-of select="./@xml:id"/>
								</xsl:variable>
								<xsl:if test="tei:catDesc = $genre">
									<xsl:value-of select="$catID"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</catRef>
				</textClass>
			</profileDesc>
			<xsl:copy-of select="document('header.xml')//*/tei:revisionDesc"/>
		</teiHeader>
	</xsl:template>


</xsl:stylesheet>
