<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect" xmlns:tei="http://www.tei-c.org/ns/1.0" extension-element-prefixes="redirect"
	exclude-result-prefixes="xhtml redirect tei">
	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<TEI xmlns="http://www.tei-c.org/ns/1.0">
			<teiHeader>
				<fileDesc>
					<titleStmt>
						<title type="main">Frankenstein</title>
						<title type="subordinate">A Romantic Circles Electronic Edition</title>
						<author>
							<name>Mary Shelley (1797-1851)</name>
						</author>
						<editor>Stuart Curran</editor>
						<sponsor>Romantic Circles</sponsor>
						<respStmt>
							<resp>General Editor, </resp>
							<name>Neil Fraistat</name>
						</respStmt>
						<respStmt>
							<resp>General Editor, </resp>
							<name>Steven E. Jones</name>
						</respStmt>
						<respStmt>
							<resp>General Editor, </resp>
							<name>Carl Stahmer</name>
						</respStmt>
						<respStmt>
							<resp>Technical Editor</resp>
							<name>Laura Mandell</name>
						</respStmt>
					</titleStmt>
					<publicationStmt>
						<idno type="edition">frank27.v3.notes</idno>
						<publisher>Romantic Circles, http://www.rc.umd.edu, University of Maryland</publisher>
						<pubPlace>College Park, MD</pubPlace>
						<date when="2009-04-01">April 1, 2009</date>
						<availability status="restricted">
							<p>Material from the Romantic Circles Website may not be downloaded, reproduced or disseminated in any manner without
								authorization unless it is for purposes of criticism, comment, news reporting, teaching, and/or classroom use as
								provided by the Copyright Act of 1976, as amended.</p>
							<p>Unless otherwise noted, all Pages and Resources mounted on Romantic Circles are copyrighted by the author/editor and
								may be shared only in accordance with the Fair Use provisions of U.S. copyright law. Except as expressly permitted by
								this statement, redistribution or republication in any medium requires express prior written consent from the
								author/editors and advance notification of Romantic Circles. Any requests for authorization should be forwarded to
								Romantic Circles:>
								<address><addrLine>Romantic Circles</addrLine>
								<addrLine>c/o Professor Neil Fraistat</addrLine>
								<addrLine>Department of English</addrLine>
								<addrLine>University of Maryland</addrLine>
								<addrLine>College Park, MD 20742</addrLine>
								<addrLine>fraistat@umd.edu</addrLine>
							</address>
							</p>
							<p>By their use of these texts and images, users agree to the following conditions: <list>
									<item>These texts and images may not be used for any commercial purpose without prior written permission from
										Romantic Circles.</item>
									<item>These texts and images may not be re-distributed in any forms other than their current ones.</item>
								</list></p>
							<p>Users are not permitted to download these texts and images in order to mount them on their own servers. It is not in
								our interest or that of our users to have uncontrolled subsets of our holdings available elsewhere on the Internet. We
								make corrections and additions to our edited resources on a continual basis, and we want the most current text to be
								the only one generally available to all Internet users. Institutions can, of course, make a link to the copies at
								Romantic Circles, subject to our conditions of use.</p>
						</availability>
					</publicationStmt>
					<sourceDesc>
						<biblStruct>
							<analytic>
								<title level="a">
									<xsl:text>NOTES to Volume III</xsl:text>
								</title>
								<author>
									<persName>Curran, Stuart</persName>
								</author>
							</analytic>
							<monogr>
								<title type="main">Frankenstein</title>
								<title type="subordinate">A Romantic Circles Electronic Edition</title>
								<editor>Curran, Stuart</editor>
								<imprint>
									<publisher>Romantic Circles</publisher>
									<pubPlace>College Park, MD</pubPlace>
									<date>2009-05-01</date>
								</imprint>
							</monogr>
						</biblStruct>
					</sourceDesc>
				</fileDesc>
				<encodingDesc>
					<editorialDecl>
						<quotation>
							<p>All quotation marks and apostrophes have been changed: " for “," for ”, ' for ‘, and ' for ’.</p>
						</quotation>
						<hyphenation eol="none">
							<p>Any dashes occurring in line breaks have been removed.</p>
							<p>Because of web browser variability, all hyphens have been typed on the U.S. keyboard</p>
							<p>Dashes have been rendered as &#8212;</p>
						</hyphenation>
						<normalization method="markup">
							<p>Spelling has not been regularized.</p>
						</normalization>
						<normalization>
							<p>&amp; has been used for the ampersand sign.</p>
							<p>&#163; has been used for £, the pound sign</p>
							<p>All other characters, those with accents, non-breaking spaces, etc., have been encoded in HTML entity decimals.</p>
						</normalization>
					</editorialDecl>
					<classDecl>
						<taxonomy xml:id="g" corresp="http://www.performantsoftware.com/nines_wiki/index.php/Submitting_RDF#.3Cnines:genre.3E">
							<bibl>NINES categories for Genre and Material Form at
								http://www.performantsoftware.com/nines_wiki/index.php/Submitting_RDF#.3Cnines:genre.3E on 2009-02-26</bibl>
							<category xml:id="g1">
								<catDesc>Architecture</catDesc>
							</category>
							<category xml:id="g2">
								<catDesc>Artifacts</catDesc>
							</category>
							<category xml:id="g3">
								<catDesc>Bibliography</catDesc>
							</category>
							<category xml:id="g4">
								<catDesc>Collection</catDesc>
							</category>
							<category xml:id="g5">
								<catDesc>Criticism</catDesc>
							</category>
							<category xml:id="g7">
								<catDesc>Letters</catDesc>
							</category>
							<category xml:id="g6">
								<catDesc>Drama</catDesc>
							</category>
							<category xml:id="g8">
								<catDesc>Life Writing</catDesc>
							</category>
							<category xml:id="g9">
								<catDesc>Politics</catDesc>
							</category>
							<category xml:id="g10">
								<catDesc>Folklore</catDesc>
							</category>
							<category xml:id="g11">
								<catDesc>Ephemera</catDesc>
							</category>
							<category xml:id="g12">
								<catDesc>Fiction</catDesc>
							</category>
							<category xml:id="g13">
								<catDesc>History</catDesc>
							</category>
							<category xml:id="g14">
								<catDesc>Leisure</catDesc>
							</category>
							<category xml:id="g15">
								<catDesc>Manuscript</catDesc>
							</category>
							<category xml:id="g16">
								<catDesc>Reference Works</catDesc>
							</category>
							<category xml:id="g17">
								<catDesc>Humor</catDesc>
							</category>
							<category xml:id="g18">
								<catDesc>Education</catDesc>
							</category>
							<category xml:id="g19">
								<catDesc>Music</catDesc>
							</category>
							<category xml:id="g20">
								<catDesc>nonfiction</catDesc>
							</category>
							<category xml:id="g21">
								<catDesc>Paratext</catDesc>
							</category>
							<category xml:id="g22">
								<catDesc>Perodical</catDesc>
							</category>
							<category xml:id="g23">
								<catDesc>Philosphy</catDesc>
							</category>
							<category xml:id="g24">
								<catDesc>Photograph</catDesc>
							</category>
							<category xml:id="g25">
								<catDesc>Citation</catDesc>
							</category>
							<category xml:id="g26">
								<catDesc>Family Life</catDesc>
							</category>
							<category xml:id="g27">
								<catDesc>Poetry</catDesc>
							</category>
							<category xml:id="g28">
								<catDesc>Religion</catDesc>
							</category>
							<category xml:id="g29">
								<catDesc>Review</catDesc>
							</category>
							<category xml:id="g30">
								<catDesc>Visual Art</catDesc>
							</category>
							<category xml:id="g31">
								<catDesc>Translation</catDesc>
							</category>
							<category xml:id="g32">
								<catDesc>Travel</catDesc>
							</category>
							<category xml:id="g33">
								<catDesc>Book History</catDesc>
							</category>
							<category xml:id="g34">
								<catDesc>Law</catDesc>
							</category>
						</taxonomy>
					</classDecl>
				</encodingDesc>
				<profileDesc>
					<textClass>
						<catRef target="#g12" scheme="#genre"/>
					</textClass>
				</profileDesc>
				<revisionDesc>
					<change n="3" when="2009-05-01" who="#LM">
						<label>Changed by</label>
						<name xml:id="LM">Laura Mandell</name>
						<list>
							<item>XSLT Transforming into TEI, RDF</item>
						</list>
					</change>
					<change n="2" when="2009-05-01" who="#DR">
						<label>Changed by</label>
						<name xml:id="DR">David Rettenmaier</name>
						<list>
							<item>XHTML Encoding</item>
						</list>
					</change>
					<change n="1" when="2009-05-01" who="#MQ">
						<label>Changed by</label>
						<name xml:id="MQ">Mike Quilligan</name>
						<list>
							<item>XHTML Encoding</item>
						</list>
					</change>
				</revisionDesc>
			</teiHeader>
			<text>
				<body>
					<head>NOTES TO VOLUME III</head>
					<div xmlns="http://www.tei-c.org/ns/1.0" type="appCharsA">
						<list xmlns="http://www.tei-c.org/ns/1.0" type="simple">
							<xsl:call-template name="tocCharacs"/>
						</list>
					</div>
					<div xmlns="http://www.tei-c.org/ns/1.0" type="appCharsB">
						<list xmlns="http://www.tei-c.org/ns/1.0" type="simple">
							<xsl:for-each select="Frankenstein/part">
								<xsl:apply-templates select="document(@code)/xhtml:html"/>
							</xsl:for-each>
						</list>
					</div>
				</body>
			</text>
		</TEI>
	</xsl:template>

	<xsl:template match="xhtml:html">
		<xsl:apply-templates select="xhtml:head"/>
		<xsl:apply-templates select="xhtml:body"/>
	</xsl:template>

	<xsl:template match="xhtml:head"/>

	<xsl:template match="xhtml:body">
		<xsl:for-each select="xhtml:div[@class='note']">
			<item xmlns="http://www.tei-c.org/ns/1.0">
				<xsl:apply-templates/>
			</item>
		</xsl:for-each>
	</xsl:template>

	<!-- to ignore line that says "Study Aid" -->
	<xsl:template match="xhtml:body/xhtml:div/xhtml:h5"/>

	<xsl:template match="xhtml:body/xhtml:div/xhtml:h3">
		<term xmlns="http://www.tei-c.org/ns/1.0">
			<xsl:apply-templates/>
		</term>
	</xsl:template>


	<xsl:template match="xhtml:body//*/xhtml:p">
		<xsl:for-each select=".">
			<p xmlns="http://www.tei-c.org/ns/1.0">
				<xsl:apply-templates/>
			</p>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="xhtml:body//*/xhtml:img">
		<figure xmlns="http://www.tei-c.org/ns/1.0">
			<graphic xmlns="http://www.tei-c.org/ns/1.0" url="{@src}"/>
		</figure>
	</xsl:template>

	<xsl:template match="xhtml:body//*/xhtml:a">
		<xsl:choose>
			<xsl:when test="contains(., 'CLOSE')"/>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="xhtml:body//*/xhtml:br">
		<xsl:for-each select=".">
			<lb xmlns="http://www.tei-c.org/ns/1.0"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="xhtml:body//*/xhtml:ol | xhtml:body//*/xhtml:ul">
		<xsl:for-each select=".">
			<list xmlns="http://www.tei-c.org/ns/1.0" type="simple">
				<xsl:apply-templates/>
			</list>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="xhtml:body//*/xhtml:li">
		<xsl:for-each select=".">
			<item xmlns="http://www.tei-c.org/ns/1.0">
				<xsl:apply-templates/>
			</item>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="tocCharacs">
		<xsl:for-each select="document(/Frankenstein/index/@code)/Frankenstein/part">
			<item xmlns="http://www.tei-c.org/ns/1.0">
				<ref target="{@n}">
					<xsl:value-of select="@code"/>
				</ref>
			</item>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
