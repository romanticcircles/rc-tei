<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei"
	extension-element-prefixes="redirect" xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect">
	<xsl:output method="xml" encoding="utf-8" indent="no"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:TEI">
		<xsl:apply-templates select="tei:teiHeader"/>
		<xsl:apply-templates select="tei:text"/>
	</xsl:template>

	<xsl:template match="tei:teiHeader"/>

	<xsl:template match="tei:text/tei:body/tei:div">
		<TEI xmlns="http://www.tei-c.org/ns/1.0">
			<teiHeader>
				<fileDesc>
					<titleStmt>
						<title type="main">The Letters of Robert Bloomfield and His Circle</title>
						<title type="subordinate">A Romantic Circles Electronic Edition</title>
						<author>
							<name>Robert Bloomfield (1766–1823)</name>
						</author>
						<editor>Tim Fulford</editor>
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
						<idno type="edition">
							<xsl:choose>
								<xsl:when test="tei:head = 'People'">
									<xsl:text>people</xsl:text>
								</xsl:when>
								<xsl:when test="tei:head = 'Places'">
									<xsl:text>places</xsl:text>
								</xsl:when>
							</xsl:choose>
						</idno>
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
								<author>Tim Fulford</author>
								<title/>
							</analytic>
							<monogr>
								<title type="main">The Letters of Robert Bloomfield and His Circle</title>
								<title type="subordinate">A Romantic Circles Electronic Edition</title>
								<author>
									<name>Robert Bloomfield (1766–1823)</name>
								</author>
								<editor>Tim Fulford</editor>
								<imprint>
									<publisher>Romantic Circles</publisher>
									<pubPlace>University of Maryland</pubPlace>
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
							<p>Bloomfield's spelling has not been regularized.</p>
							<p>Writing in other hands appearing on these manuscripts has been indicated as such, the content recorded in brackets.</p>
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
						<taxonomy corresp="people.xml/category[@xml:id='EE25names']">
							<category xml:id="people">
								<catDesc>Romantic Circles people: Bloomfield Letters</catDesc>
							</category>
						</taxonomy>
						<taxonomy corresp="people.xml/category[@xml:id='EE25places']">
							<category xml:id="places">
								<catDesc>Romantic Circles places: Bloomfield Letters</catDesc>
							</category>
						</taxonomy>
					</classDecl>
				</encodingDesc>
				<profileDesc>
					<textClass>
						<catRef target="#g5 #g21" scheme="#genre"/>
						<catRef target="#EEd.25.names" scheme="#people"/>
						<catRef target="#EEd.25.places" scheme="#places"/>
					</textClass>
				</profileDesc>
				<revisionDesc>
					<change n="6" when="2009-07-25" who="#LM">
						<label>Changed by</label>
						<name>Averill Buchanan</name>
						<list>
							<item>changes from proofing a final time; new letter discovered and letters renumbered.</item>
						</list>
					</change>
					<change n="5" when="2009-06-08" who="#LM">
						<label>Changed by</label>
						<name>Laura Mandell</name>
						<list>
							<item>create image wrappers; run edition for last time through xslt.</item>
						</list>
					</change>
					<change n="4" when="2009-04-30" who="#AB">
						<label>Changed by</label>
						<name>Averill Buchanan</name>
						<list>
							<item>Proofing and TEI encoding of entire edition (further preliminary materials)</item>
						</list>
					</change>
					<change n="3" when="2009-03-30" who="#LM">
						<label>Changed by</label>
						<name xml:id="LM">Laura Mandell</name>
						<list>
							<item>XSLT Transforming</item>
						</list>
					</change>
					<change n="2" when="2009-03-20" who="#AB">
						<label>Changed by</label>
						<name xml:id="AB">Averill Buchanan</name>
						<list>
							<item>Proofing, re-coding letters, and TEI encoding of preliminary materials</item>
						</list>
					</change>
					<change n="1" when="2008-10-03" who="#KL">
						<label>Changed by</label>
						<name xml:id="KL">Kirstyn Leuner</name>
						<list>
							<item>TEI Encoding, first pass, all letters</item>
						</list>
					</change>
				</revisionDesc>
			</teiHeader>
			<text>
				<body>
					<div type="toc">
						<head>
							<xsl:choose>
								<xsl:when test="tei:head = 'People'">
									<xsl:text>Index of People</xsl:text>
								</xsl:when>
								<xsl:when test="tei:head = 'Places'">
									<xsl:text>Index of Places</xsl:text>
								</xsl:when>
							</xsl:choose>
						</head>
						<list type="toc">
							<xsl:for-each select="tei:list/tei:item/tei:term">
								<xsl:variable name="refURL">
									<xsl:value-of select="@xml:id"/>
								</xsl:variable>
								<item>
									<ref>
										<xsl:attribute name="target">
											<xsl:value-of select="concat('#', $refURL)"/>
										</xsl:attribute>
										<xsl:value-of select="substring-before(., ':')"/>
									</ref>
								</item>
							</xsl:for-each>
						</list>
					</div>
					<xsl:copy-of select="."/>
				</body>
			</text>
		</TEI>
	</xsl:template>

</xsl:stylesheet>