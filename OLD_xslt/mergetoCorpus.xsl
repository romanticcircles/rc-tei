<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <xsl:strip-space elements="*"/>


  <xsl:template match="/">
    <teiCorpus>
      <teiHeader>
        <fileDesc>
          <titleStmt>
            <title type="main">
              <xsl:value-of select="document(//part/@code[1])//tei:title[@type = 'main']"/>
            </title>
            <title type="subordinate">
              <xsl:value-of select="document(//part/@code[1])//tei:title[@type = 'subordinate']"/>
            </title>
            <editor role="editor">
              <xsl:value-of select="document(//part/@code[1])//tei:editor[@role = 'editor']"/>
            </editor>
            <sponsor>Romantic Circles</sponsor>
            <respStmt>
              <resp>General Editor,</resp>
              <name>Neil Fraistat</name>
            </respStmt>
            <respStmt>
              <resp>General Editor,</resp>
              <name>Steven E. Jones</name>
            </respStmt>
            <respStmt>
              <resp>Praxis Series,</resp>
              <name>Orrin N.C. Wang</name>
            </respStmt>
          </titleStmt>
          <publicationStmt>
            <publisher>Romantic Circles, http://www.rc.umd.edu, University of Maryland</publisher>
            <pubPlace>College Park, MD</pubPlace>
            <availability status="restricted">
              <p>Material from the Romantic Circles Website may not be downloaded, reproduced or disseminated in any manner without authorization
                unless it is for purposes of criticism, comment, news reporting, teaching, and/or classroom use as provided by the Copyright Act of
                1976, as amended.</p>
              <p>Unless otherwise noted, all Pages and Resources mounted on Romantic Circles are copyrighted by the author/editor and may be shared
                only in accordance with the Fair Use provisions of U.S. copyright law. Except as expressly permitted by this statement, redistribution
                or republication in any medium requires express prior written consent from the author/editors and advance notification of Romantic
                Circles. Any requests for authorization should be forwarded to Romantic Circles:&gt;
                <address>
<addrLine>Romantic Circles</addrLine>
<addrLine>c/o Professor Neil Fraistat</addrLine>
<addrLine>Department of English</addrLine>
<addrLine>University of Maryland</addrLine>
<addrLine>College Park, MD 20742</addrLine>
<addrLine>fraistat@umd.edu</addrLine>
</address>
              </p>
              <p>By their use of these texts and images, users agree to the following conditions: <list>
                  <item>These texts and images may not be used for any commercial purpose without prior written permission from Romantic
                    Circles.</item>
                  <item>These texts and images may not be re-distributed in any forms other than their current ones.</item>
                </list>
              </p>
              <p>Users are not permitted to download these texts and images in order to mount them on their own servers. It is not in our interest or
                that of our users to have uncontrolled subsets of our holdings available elsewhere on the Internet. We make corrections and additions
                to our edited resources on a continual basis, and we want the most current text to be the only one generally available to all Internet
                users. Institutions can, of course, make a link to the copies at Romantic Circles, subject to our conditions of use.</p>
            </availability>
          </publicationStmt>
          <sourceDesc>
            <biblStruct>
              <monogr>
                <title level="m">
                  <xsl:value-of select="document(//part/@code[1])//tei:title[@type = 'main']"/>
                </title>
                <title level="s">Electronic Editions</title>
                <imprint>
                  <publisher>Romantic Circles, http://www.rc.umd.edu, University of Maryland</publisher>
                  <pubPlace>College Park, MD</pubPlace>
                </imprint>
              </monogr>
            </biblStruct>
          </sourceDesc>
        </fileDesc>
        <encodingDesc>
          <editorialDecl>
            <quotation>
              <p>All quotation marks and apostrophes have been changed: " for â€œ," for â€, ' for ‘, and ' for '.</p>
            </quotation>
            <hyphenation eol="none">
              <p>Any dashes occurring in line breaks have been removed.</p>
              <p>Because of web browser variability, all hyphens have been typed on the U.S. keyboard</p>
              <p>Em-dashes have been rendered as #8212</p>
            </hyphenation>
            <normalization method="markup">
              <p>Spelling has not been regularized.</p>
              <p>Writing in other hands appearing on these manuscripts has been indicated as such, the content recorded in brackets.</p>
            </normalization>
            <normalization>
              <p>&amp; has been used for the ampersand sign.</p>
              <p>Â£ has been used for Â£, the pound sign</p>
              <p>All other characters, those with accents, non-breaking spaces, etc., have been encoded in HTML entity decimals.</p>
            </normalization>
          </editorialDecl>
        </encodingDesc>
        <revisionDesc>
          <change>Generated TEI Corpus file from individual edition files using custom XSLT</change>
        </revisionDesc>
      </teiHeader>
      <xsl:for-each select="//part[not(contains(@code, 'contribs.xml'))]">
        <xsl:copy-of select="document(@code)/tei:TEI"/>
      </xsl:for-each>
    </teiCorpus>
  </xsl:template>

</xsl:stylesheet>
