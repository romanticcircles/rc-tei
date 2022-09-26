<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="exsl estr edate a fo local rng tei teix xd html" extension-element-prefixes="exsl estr edate" version="1.0"
	xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0" xmlns:edate="http://exslt.org/dates-and-times" xmlns:estr="http://exslt.org/strings"
	xmlns:exsl="http://exslt.org/common" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:local="http://www.pantor.com/ns/local" xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:teix="http://www.tei-c.org/ns/Examples" xmlns:xd="http://www.pnp-software.com/XSLTdoc" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xd:doc type="stylesheet">
		<xd:short> TEI stylesheet dealing with elements from the core module, making HTML output. </xd:short>
		<xd:detail> This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License
			as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version. This library is
			distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
			FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details. You should have received a copy of the GNU Lesser
			General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
			MA 02111-1307 USA </xd:detail>
		<xd:author>See AUTHORS</xd:author>
		<xd:cvsId>$Id: core.xsl 4565 2008-05-07 02:17:56Z dsew $</xd:cvsId>
		<xd:copyright>2007, TEI Consortium</xd:copyright>
	</xd:doc>

	<xd:doc>
		<xd:short>Process elements tei:*</xd:short>
		<xd:param name="forcedepth">forcedepth</xd:param>
		<xd:detail>
			<p> anything with a head can go in the TOC </p>
		</xd:detail>
	</xd:doc>
	<xsl:template match="tei:*" mode="maketoc">
		<xsl:param name="forcedepth"/>
		<xsl:variable name="myName">
			<xsl:value-of select="local-name(.)"/>
		</xsl:variable>
		<xsl:if test="tei:head or $autoHead='true'">
			<xsl:variable name="Depth">
				<xsl:choose>
					<xsl:when test="not($forcedepth='')">
						<xsl:value-of select="$forcedepth"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$tocDepth"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="thislevel">
				<xsl:choose>
					<xsl:when test="$myName = 'div'">
						<xsl:value-of select="count(ancestor::tei:div)"/>
					</xsl:when>
					<xsl:when test="starts-with($myName,'div')">
						<xsl:choose>
							<xsl:when test="ancestor-or-self::tei:div0">
								<xsl:value-of select="substring-after($myName,'div')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring-after($myName,'div') - 1"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>99</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="pointer">
				<xsl:apply-templates mode="generateLink" select="."/>
			</xsl:variable>
			<li class="toc">
				<xsl:call-template name="header">
					<xsl:with-param name="toc" select="$pointer"/>
					<xsl:with-param name="minimal">false</xsl:with-param>
					<xsl:with-param name="display">plain</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="$thislevel &lt; $Depth">
					<xsl:call-template name="continuedToc"/>
				</xsl:if>
			</li>
		</xsl:if>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:ab</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:ab">
		<div xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="rendToClass">
				<xsl:with-param name="default">ab</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:addrLine</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:addrLine">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:address</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:address">
		<xsl:choose>
			<xsl:when test="not(parent::tei:p)">
				<xsl:choose>
					<xsl:when test="not(parent::tei:dateline)">
						<p xmlns="http://www.w3.org/1999/xhtml">
							<xsl:choose>
								<xsl:when test="@rendition">
									<xsl:call-template name="applyRendition"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="class">
										<xsl:text>l</xsl:text>
									</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:apply-templates/>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
				<xsl:text> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:bibl</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:bibl">
		<xsl:choose>
			<xsl:when test="parent::tei:cit">
				<div xmlns="http://www.w3.org/1999/xhtml">
					<xsl:choose>
						<xsl:when test="@rendition">
							<xsl:call-template name="applyRendition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">citbibl</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<p xmlns="http://www.w3.org/1999/xhtml" class="hang">
				<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:byline</xd:short>
		<xd:detail>
			<p> </p>
		</xd:detail>
	</xd:doc>
	<xsl:template match="tei:byline">
		<div xmlns="http://www.w3.org/1999/xhtml"  class="byline">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Process element tei:change</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:change">
		<tr>
			<td valign="top" width="15%">
				<xsl:value-of select="tei:date"/>
			</td>
			<td width="85%">
				<xsl:value-of select="tei:item"/>
			</td>
		</tr>
	</xsl:template>
	<xd:doc>
		<xd:short>Process element tei:choice</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:choice">
		<xsl:choose>
			<xsl:when test="tei:abbr and tei:expan">
				<xsl:apply-templates select="tei:expan"/>
				<xsl:text> (</xsl:text>
				<xsl:apply-templates select="tei:abbr"/>
				<xsl:text>)</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process element tei:cit</xd:short>
		<xd:detail>
			<p> quoting </p>
		</xd:detail>
	</xd:doc>
	<xsl:template match="tei:cit">
		<xsl:choose>
			<xsl:when test="@rend='display'">
				<blockquote>
					<xsl:choose>
						<xsl:when test="@rend">
							<xsl:attribute name="class">
								<xsl:value-of select="@rend"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="@rendition">
							<xsl:call-template name="applyRendition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">
								<xsl:text>cit</xsl:text>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<p class="quote">
						<xsl:apply-templates select="tei:q|tei:quote"/>
						<xsl:apply-templates select="tei:bibl"/>
					</p>
				</blockquote>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:code</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:code">
		<tt>
			<xsl:apply-templates/>
		</tt>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:corr</xd:short>
		<xd:detail>Does not do anything yet.</xd:detail>
	</xd:doc>
	<xsl:template match="tei:corr">
		<xsl:apply-templates/>
	</xsl:template>


	<xd:doc>
		<xd:short>Process elements tei:del</xd:short>
		<xd:detail/>
	</xd:doc>
	<xsl:template match="tei:del">
		<span style="text-decoration: line-through;">
			<xsl:apply-templates/>
		</span>
	</xsl:template>


	<xd:doc>
		<xd:short>Process elements tei:eg</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:eg">
		<div xmlns="http://www.w3.org/1999/xhtml" >
			<xsl:if test="$cssFile">
				<xsl:attribute name="class">
					<xsl:text>pre_eg</xsl:text>
					<xsl:if test="not(*)">
						<xsl:text> cdata</xsl:text>
					</xsl:if>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:emph</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:emph">
		<xsl:choose>
			<xsl:when test="@rend">
				<xsl:call-template name="rendering"/>
			</xsl:when>
			<xsl:when test="@rendition">
				<span>
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<em>
					<xsl:apply-templates/>
				</em>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:epigraph</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:epigraph">
		<div class="epigraph">
			<table align="{$epigraphPos}">
				<tr>
					<td>
						<xsl:apply-templates/>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:epigraph/tei:lg</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<!-- <xsl:template match="tei:epigraph/tei:lg">
		<xsl:apply-templates/>
		</xsl:template>  -->
	<xd:doc>
		<xd:short>Process elements tei:foreign</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:foreign">
		<xsl:choose>
			<xsl:when test="@rend">
				<xsl:call-template name="rendering"/>
			</xsl:when>
			<xsl:when test="@rendition">
				<span>
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="foreign">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xd:doc>
		<xd:short>forme work -- for catchwords and page headers</xd:short>
	</xd:doc>
	<xsl:template match="tei:fw">
		<xsl:choose>
			<xsl:when test="@type='catch'">
				
				<div xmlns="http://www.w3.org/1999/xhtml" class="catch">
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:when test="@type='head'">
				
				<div xmlns="http://www.w3.org/1999/xhtml" class="pbHead"><xsl:apply-templates/></div>
				
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Process elements tei:gap</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:gap"> [...]<xsl:apply-templates/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:gi</xd:short>
		<xd:detail>
			<p> special purpose </p>
		</xd:detail>
	</xd:doc>
	<xsl:template match="tei:gi">
		<span class="gi" xmlns="http://www.w3.org/1999/xhtml">
			<xsl:text>&lt;</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>&gt;</xsl:text>
		</span>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:gi</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:gi" mode="plain">
		<span class="gi" xmlns="http://www.w3.org/1999/xhtml">
			<xsl:text>&lt;</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>&gt;</xsl:text>
		</span>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:att</xd:short>
		<xd:detail>
			<p> special purpose </p>
		</xd:detail>
	</xd:doc>
	<xsl:template match="tei:att">
		<span class="gi">
			<b>@<xsl:apply-templates/></b>
		</span>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:gloss</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:gloss">
		<span class="gloss" xmlns="http://www.w3.org/1999/xhtml">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:head</xd:short>
		<xd:detail>
			<p> headings etc </p>
		</xd:detail>
	</xd:doc>
	<xsl:template match="tei:head">
		<xsl:variable name="parent" select="local-name(..)"/>
		<xsl:if test="not(starts-with($parent,'div'))">
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>
	<xd:doc>
		<xd:short>Process element tei:head in plain mode</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:head" mode="plain">
		<xsl:if test="preceding-sibling::tei:head">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates mode="plain"/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:hi in frontmatter</xd:short>
		<xd:detail> RC: This should work without having to specify the front, but it doesn't, I had to add it.</xd:detail>
	</xd:doc>
	<xsl:template match="tei:front//*/tei:hi">
		<xsl:choose>
			<xsl:when test="@rend='bold'">
				<strong xmlns="http://www.w3.org/1999/xhtml">
					<xsl:apply-templates/>
				</strong>
			</xsl:when>
			<xsl:when test="@rend='ital'">
				<em xmlns="http://www.w3.org/1999/xhtml"> booooooooooooooooooo
					<xsl:apply-templates/>
				</em>
			</xsl:when>
			<xsl:when test="@rend">
				<xsl:call-template name="rendering"/>
			</xsl:when>
			<xsl:when test="@rendition">
				<span xmlns="http://www.w3.org/1999/xhtml">
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<strong xmlns="http://www.w3.org/1999/xhtml">
					<xsl:apply-templates/>
				</strong>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:hi</xd:short>
		<xd:detail> in body</xd:detail>
	</xd:doc>
	<xsl:template match="tei:body//*/tei:hi">
		<xsl:choose>
			<xsl:when test="@rend='bold'">
				<strong>
					<xsl:apply-templates/>
				</strong>
			</xsl:when>
			<xsl:when test="@rend='ital'">
				<em>
					<xsl:apply-templates/>
				</em>
			</xsl:when>
			<xsl:when test="@rend='double underline'">
				<span class="doubleUnderline">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="@rend='underline'">
				<u>
					<xsl:apply-templates/>
				</u>
			</xsl:when>
			<xsl:when test="@rend">
				<xsl:call-template name="rendering"/>
			</xsl:when>
			<xsl:when test="@rendition">
				<span>
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<strong>
					<xsl:apply-templates/>
				</strong>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:ident</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:ident">
		<xsl:choose>
			<xsl:when test="@type">
				<span class="ident-{@type}">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<strong>
					<xsl:apply-templates/>
				</strong>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:item</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:item" mode="bibl">
		<p>
			<xsl:call-template name="makeAnchor"/>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:item</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:item" mode="glosstable">
		<tr>
			<td valign="top">
				<strong>
					<xsl:apply-templates mode="print" select="preceding-sibling::tei:*[1]"/>
				</strong>
			</td>
			<td>
				<xsl:call-template name="makeAnchor"/>
				<xsl:apply-templates/>
			</td>
		</tr>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:item</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:item" mode="compressed">
		<dd>
			<xsl:apply-templates/>
		</dd>
	</xsl:template>
	<xsl:template match="tei:item" mode="gloss">
		<dt>
			<xsl:call-template name="makeAnchor"/>
			<xsl:apply-templates mode="print" select="preceding-sibling::tei:label[1]"/>
		</dt>
		<dd>
			<xsl:apply-templates/>
		</dd>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:item</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:item">
		<li>
			<xsl:call-template name="rendToClass"/>
			<xsl:if test="@n">
				<xsl:attribute name="value">
					<xsl:value-of select="@n"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@xml:id">
					<xsl:call-template name="makeAnchor">
						<xsl:with-param name="name">
							<xsl:value-of select="@xml:id"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$generateParagraphIDs='true'">
					<xsl:call-template name="makeAnchor">
						<xsl:with-param name="name">
							<xsl:value-of select="generate-id()"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
			<xsl:apply-templates/>
		</li>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:item</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:item" mode="inline">
		<xsl:if test="preceding-sibling::tei:item">, </xsl:if>
		<xsl:if test="not(following-sibling::tei:item) and preceding-sibling::tei:item"> and </xsl:if>
		<xsl:text>&#x2022; </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:item/label</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:item/label">
		<xsl:choose>
			<xsl:when test="@rend">
				<xsl:call-template name="rendering"/>
			</xsl:when>
			<xsl:when test="@rendition">
				<span>
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<strong>
					<xsl:apply-templates/>
				</strong>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:kw</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:kw">
		<span class="kw">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:l</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:l" mode="Copying">
		<xsl:apply-templates/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:l[@copyOf]|lg[@copyOf]</xd:short>
		<xd:detail>
			<p> copyOf handling </p>
		</xd:detail>
	</xd:doc>
	<xsl:template match="tei:l[@copyOf]|lg[@copyOf]">
		<xsl:variable name="W">
			<xsl:choose>
				<xsl:when test="starts-with(@copyof,'#')">
					<xsl:value-of select="substring-after(@copyof,'#')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@copyof"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:apply-templates mode="Copying" select="key('IDS',$W)"/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:label</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:label">
		<xsl:call-template name="makeAnchor"/>
		<xsl:apply-templates/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:label</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:label" mode="print">
		<xsl:call-template name="makeAnchor"/>
		<xsl:choose>
			<xsl:when test="@rend">
				<xsl:call-template name="rendering"/>
			</xsl:when>
			<xsl:when test="@rendition">
				<span>
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:lb</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:lb">
		<br xmlns="http://www.w3.org/1999/xhtml" />
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:l</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:lg/tei:l">
		<!-- <xsl:variable name="lineNbrQT">
			<xsl:number level="any" count="//tei:quote/tei:lg/tei:l" from="//tei:quote"/>
		</xsl:variable>
		-->
		<xsl:variable name="lineNbrNT">
			<xsl:number level="any" count="//tei:note/tei:quote/tei:lg/tei:l" from="//tei:quote"/>
		</xsl:variable>
		<xsl:variable name="lineNbrEP">
			<xsl:number level="any" count="//tei:note/tei:quote/tei:lg/tei:l" from="//tei:quote"/>
		</xsl:variable>
		<xsl:variable name="lineNbrSP">
			<xsl:number level="any" count="//tei:div[@type='poetry']/tei:sp/tei:lg/tei:l" from="//tei:div[@type='poetry']"/>
		</xsl:variable>
		<xsl:variable name="lineNbr">
			<xsl:number level="any" count="//tei:div[@type='poetry']/tei:lg/tei:l" from="//tei:div[@type='poetry']"/>
		</xsl:variable>
		
				<div xmlns="http://www.w3.org/1999/xhtml">
					<xsl:choose>
						<xsl:when test="@rendition">
							<xsl:call-template name="applyRendition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">
								<xsl:text>l</xsl:text>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates/>
				
		
				<xsl:choose>
					<!-- <xsl:when test="parent::tei:lg/parent::tei:quote">
						<xsl:if test="$lineNbrQT mod 5 = 0">
							<xsl:value-of select="$lineNbrQT"/>
						</xsl:if>
					</xsl:when>
					-->
					<xsl:when test="parent::tei:lg/parent::tei:quote/parent::tei:note">
						<xsl:if test="$lineNbrNT mod 5 = 0">
							<span xmlns="http://www.w3.org/1999/xhtml" class="lineNumber">
								<xsl:value-of select="$lineNbrNT"/>
							</span>
						</xsl:if>
					</xsl:when>
					<xsl:when test="parent::tei:lg/parent::tei:quote/parent::tei:note/tei:quote/tei:epigraph">
						<xsl:if test="$lineNbrEP mod 5 = 0">
							<span xmlns="http://www.w3.org/1999/xhtml" class="lineNumber">
								<xsl:value-of select="$lineNbrEP"/>
							</span>
						</xsl:if>
					</xsl:when>
					<xsl:when test="parent::tei:lg/parent::tei:sp">
						<xsl:if test="$lineNbrSP mod 5 = 0">
							<span xmlns="http://www.w3.org/1999/xhtml" class="lineNumber">
							<xsl:value-of select="$lineNbrSP"/>
								</span>
						</xsl:if>
					</xsl:when>
					<xsl:when test="//tei:div[@type='poetry']">
						<xsl:if test="$lineNbr mod 5 = 0">
							<span xmlns="http://www.w3.org/1999/xhtml" class="lineNumber">
							<xsl:value-of select="$lineNbr"/>
							</span>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="tei:l"/>
					</xsl:otherwise>
				</xsl:choose>
				</div>	
			
	</xsl:template>
	<xsl:template match="tei:l">
		<div xmlns="http://www.w3.org/1999/xhtml">
			<xsl:choose>
				<xsl:when test="@rendition">
					<xsl:call-template name="applyRendition"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">
						<xsl:text>l</xsl:text>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<!-- <xsl:template match="tei:epigraph//*/tei:l">
		<div xmlns="http://www.w3.org/1999/xhtml">
			<xsl:choose>
				<xsl:when test="@rendition">
					<xsl:call-template name="applyRendition"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">
						<xsl:text>l</xsl:text>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	-->
	<xd:doc>
		<xd:short>Process elements tei:lg</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:lg">
		<div xmlns="http://www.w3.org/1999/xhtml" class="stanza">
				<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:lg</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:lg" mode="Copying">
		<xsl:apply-templates/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:lg/tei:head</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:lg/tei:head">
		<div xmlns="http://www.w3.org/1999/xhtml">
			<xsl:if test="@rendition">
				<xsl:call-template name="applyRendition"/>
			</xsl:if>
		<xsl:apply-templates/>
			</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:list</xd:short>
		<xd:detail>
			<p>Lists. Depending on the value of the 'type' attribute, various HTML lists are generated: <dl>
					<dt>bibl</dt>
					<dd>Items are processed in mode 'bibl'</dd>
					<dt>catalogue</dt>
					<dd>A gloss list is created, inside a paragraph</dd>
					<dt>gloss</dt>
					<dd>A gloss list is created, expecting alternate label and item elements</dd>
					<dt>glosstable</dt>
					<dd>Label and item pairs are laid out in a two-column table</dd>
					<dt>inline</dt>
					<dd>A comma-separate inline list</dd>
					<dt>runin</dt>
					<dd>An inline list with bullets between items</dd>
					<dt>unordered</dt>
					<dd>A simple unordered list</dd>
					<dt>ordered</dt>
					<dd>A simple ordered list</dd>
					<dt>vallist</dt>
					<dd>(Identical to glosstable)</dd>
				</dl>
			</p>
		</xd:detail>
	</xd:doc>
	<xsl:template match="tei:list">
		<xsl:if test="tei:head">
			<p class="listhead">
				<xsl:apply-templates select="tei:head"/>
			</p>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="@type='list'">
				<xsl:for-each select="tei:item">
					<dl>
						<dt>
							<xsl:apply-templates mode="gloss" select="."/>
						</dt>
					</dl>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="@type='catalogue'">
				<p>
					<dl>
						<xsl:call-template name="rendToClass"/>
						<xsl:for-each select="tei:item">
							<p/>
							<xsl:apply-templates mode="gloss" select="."/>
						</xsl:for-each>
					</dl>
				</p>
			</xsl:when>
			<xsl:when test="@type='gloss' and @rend='multicol'">
				<xsl:variable name="nitems">
					<xsl:value-of select="count(tei:item)div 2"/>
				</xsl:variable>
				<p>
					<table>
						<xsl:call-template name="rendToClass"/>
						<tr>
							<td valign="top">
								<dl>
									<xsl:apply-templates mode="gloss" select="tei:item[position()&lt;=$nitems ]"/>
								</dl>
							</td>
							<td valign="top">
								<dl>
									<xsl:apply-templates mode="gloss" select="tei:item[position() &gt;$nitems]"/>
								</dl>
							</td>
						</tr>
					</table>
				</p>
			</xsl:when>
			<xsl:when test="@type='gloss' or  tei:label">
				<dl>
					<xsl:call-template name="rendToClass"/>
					<xsl:apply-templates mode="gloss" select="tei:item"/>
				</dl>
			</xsl:when>
			<xsl:when test="@type='glosstable' or @type='vallist'">
				<table>
					<xsl:call-template name="rendToClass"/>
					<xsl:apply-templates mode="glosstable" select="tei:item"/>
				</table>
			</xsl:when>
			<xsl:when test="@type='inline'">
				<!--<xsl:if test="not(tei:item)">None</xsl:if>-->
				<xsl:apply-templates mode="inline" select="tei:item"/>
			</xsl:when>
			<xsl:when test="@type='runin'">
				<p>
					<xsl:apply-templates mode="runin" select="tei:item"/>
				</p>
			</xsl:when>
			<xsl:when test="@type='unordered' or @type='simple'">
				<ul> 
					<xsl:call-template name="rendToClass"/>
					<xsl:apply-templates select="tei:item"/>
					<!-- Why is this necessary? [DR]-->
					<!-- <br/>  -->
				</ul>
			</xsl:when>
			<xsl:when test="@type='toc'">
				<dl>
					<dt>
						<xsl:apply-templates select="tei:item" mode="compressed"/>
					</dt>
				</dl>
			</xsl:when>
			<xsl:when test="@type='bibl'">
				<xsl:apply-templates mode="bibl" select="tei:item"/>
			</xsl:when>
			<xsl:when test="starts-with(@type,'ordered')">
				<ol>
					<xsl:call-template name="rendToClass"/>
					<xsl:if test="starts-with(@type,'ordered:')">
						<xsl:attribute name="start">
							<xsl:value-of select="substring-after(@type,':')"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="tei:item"/>
				</ol>
			</xsl:when>
			<xsl:otherwise>
				<ul>
					<xsl:call-template name="rendToClass"/>
					<xsl:apply-templates select="tei:item"/>
				</ul>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:list/tei:label</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:list/tei:label"/>

	<xd:doc>
		<xd:short>Process elements tei:listBibl</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>

	<xd:doc>
		<xd:short>Process elements tei:listBibl</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	
	<xsl:template match="tei:listBibl">
		<xsl:choose>
			<xsl:when test="tei:biblStruct">  <!--RC: MLA Citation Style -->
				<div type="listBibl" xmlns="http://www.w3.org/1999/xhtml">
					<xsl:for-each select="tei:biblStruct">
						<p class="hang" xmlns="http://www.w3.org/1999/xhtml">
							<xsl:apply-templates select="tei:analytic" mode="mla"/>
							<xsl:apply-templates select="tei:monogr" mode="mla"/>
							<xsl:apply-templates select="tei:relatedItem" mode="mla"/>
							<xsl:choose>
								<xsl:when test="tei:note">
									<xsl:apply-templates select="tei:note"/>
								</xsl:when>
								<xsl:when test="*//tei:ref/@target and not(contains(*//tei:ref/@target, '#'))">
									<xsl:text>Web.&#10;</xsl:text>
									<xsl:if test="*//tei:imprint/tei:date/@type='access'">
										<xsl:value-of select="*//tei:imprint/tei:date[@type='access']"/>
										<xsl:text>.</xsl:text>
									</xsl:if>
								</xsl:when>
								<xsl:when test="tei:analytic/tei:title[@level='u'] or tei:monogr/tei:title[@level='u']"/>
								<xsl:otherwise>Print.&#10;</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="tei:monogr/tei:imprint/tei:extent"><xsl:value-of select="tei:monogr/tei:imprint/tei:extent"/>. </xsl:if>
							<xsl:if test="tei:series/tei:title[@level='s']">
								<xsl:apply-templates select="tei:series/tei:title[@level='s']"/>
								<xsl:text>. </xsl:text>
							</xsl:if>
						</p>
					</xsl:for-each>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<ol class="listBibl">
					<xsl:for-each select="tei:bibl|tei:biblItem">
						<li>
							<xsl:call-template name="makeAnchor">
								<xsl:with-param name="name">
									<xsl:apply-templates mode="ident" select="."/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:apply-templates select="."/>
						</li>
					</xsl:for-each>
				</ol>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="tei:analytic" mode="mla">
		<xsl:variable name="refIdwHash">
			<xsl:value-of select="following-sibling::tei:monogr/tei:ref/@target"/>
		</xsl:variable>
		<xsl:variable name="refId">
			<xsl:value-of select="substring-after($refIdwHash, '#')"/>
		</xsl:variable>
		<xsl:apply-templates/>
		<xsl:if test="not(following-sibling::tei:monogr/tei:title[@level='m']) and $refId!=''">
			<xsl:text> </xsl:text>
			<xsl:if test="following-sibling::tei:monogr/tei:imprint/tei:date">
				<xsl:value-of select="following-sibling::tei:monogr/tei:imprint/tei:date"/>
				<xsl:text>. </xsl:text>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:author[1]">
					<xsl:value-of select="substring-before(ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:author[1], ',')"/>
				</xsl:when>
				<xsl:when test="ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:editor[@role='editor'][1]">
					<xsl:value-of select="substring-before(ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:editor[@role='editor'][1], ',')"/>
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:author[3]">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="substring-before(ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:author[2], ',')"/>
					<xsl:text>, and </xsl:text>
				</xsl:when>
				<xsl:when test="ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:editor[@role='editor'][3]">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="substring-before(ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:editor[@role='editor'][2], ',')"/>
					<xsl:text>, and </xsl:text>
				</xsl:when>
				<xsl:when test="ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:author[2]">
					<xsl:text> and </xsl:text>
					<xsl:value-of select="substring-before(ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:author[2], ',')"/>
				</xsl:when>
				<xsl:when test="ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:editor[@role='editor'][2]">
					<xsl:text> and </xsl:text>
					<xsl:value-of select="substring-before(ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:editor[@role='editor'][2], ',')"/>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:author[3]">
				<xsl:value-of select="substring-before(ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:author[3], ',')"/>
			</xsl:if>
			<xsl:if test="ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:editor[@role='editor'][3]">
				<xsl:value-of select="substring-before(ancestor::tei:listBibl/tei:biblStruct[@xml:id=$refId]/tei:monogr/tei:editor[@role='editor'][3], ',')"/>
			</xsl:if>
			<xsl:text> </xsl:text>
			<xsl:value-of select="following-sibling::tei:monogr/tei:imprint/tei:biblScope[@type='pp']"/>
			<xsl:text>. </xsl:text>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="tei:monogr" mode="mla">
		<xsl:choose>
			<xsl:when test="preceding-sibling::tei:analytic">
				<xsl:choose>
					<xsl:when test="tei:author = parent::tei:biblStruct/tei:analytic/tei:author">
						<xsl:if test="tei:author[2]">
							<xsl:apply-templates select="tei:author"/>
						</xsl:if>
						<xsl:apply-templates select="tei:title"/>
						<xsl:if test="tei:edition"><xsl:apply-templates select="tei:edition"/></xsl:if>
						<xsl:apply-templates select="tei:editor[@role='editor']"/>
						<xsl:if test="tei:editor[@role='translator']">
							<xsl:apply-templates select="tei:editor[@role='translator']"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="tei:author"/>
						<xsl:apply-templates select="tei:title"/>
						<xsl:if test="tei:edition"><xsl:apply-templates select="tei:edition"/></xsl:if>
						<xsl:apply-templates select="tei:editor[@role='editor']"/>
						<xsl:if test="tei:editor[@role='translator']">
							<xsl:apply-templates select="tei:editor[@role='translator']"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="tei:editor[@role='editor'] and not(preceding-sibling::tei:analytic) and not(tei:author)">
				<xsl:apply-templates select="tei:editor[@role='editor']"/>
				<xsl:apply-templates select="tei:title"/>
				<xsl:if test="tei:edition"><xsl:apply-templates select="tei:edition"/></xsl:if>
				<xsl:if test="tei:editor[@role='translator']">
					<xsl:apply-templates select="tei:editor[@role='translator']"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="tei:author"/>
				<xsl:apply-templates select="tei:title"/>
				<xsl:if test="tei:edition"><xsl:apply-templates select="tei:edition"/></xsl:if>
				<xsl:apply-templates select="tei:editor[@role='editor']"/>
				<xsl:if test="tei:editor[@role='translator']">
					<xsl:apply-templates select="tei:editor[@role='translator']"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="*//tei:ref/@target and not(contains(*//tei:ref/@target, '#'))">
				<xsl:if test="tei:imprint/tei:date[@type='update']"><xsl:value-of select="tei:imprint/tei:date[@type='update']"/></xsl:if>
			</xsl:when>
			<xsl:when test="ancestor-or-self::tei:biblStruct/*/tei:title/@level='u'">
				<xsl:value-of select="tei:imprint"/>
			</xsl:when>
			<xsl:when test="tei:title/@level='m'">
				<xsl:if test="tei:imprint/tei:biblScope/@type='vol'">
					<xsl:value-of select="tei:imprint/tei:biblScope[@type='vol']"/>. </xsl:if>
				<xsl:choose>
					<xsl:when test="tei:imprint/tei:pubPlace"><xsl:value-of select="tei:imprint/tei:pubPlace"/>: </xsl:when>
					<xsl:otherwise>[n.p.]: </xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="tei:imprint/tei:publisher"><xsl:value-of select="tei:imprint/tei:publisher"/>, </xsl:when>
					<xsl:otherwise>[n.p.], </xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="tei:imprint/tei:date"><xsl:value-of select="tei:imprint/tei:date"/>. </xsl:when>
					<xsl:otherwise>[n.d.]  </xsl:otherwise>
				</xsl:choose>
				<xsl:if test="tei:imprint/tei:biblScope[@type='pp']"><xsl:value-of select="tei:imprint/tei:biblScope[@type='pp']"/>. </xsl:if>
			</xsl:when>
			<xsl:when test="tei:title/@level='j'">
				<xsl:if test="tei:imprint/tei:biblScope/@type='vol'"><xsl:value-of select="tei:imprint/tei:biblScope[@type='vol']"/></xsl:if>
				<xsl:if test="tei:imprint/tei:biblScope/@type='no'"><xsl:text>.</xsl:text><xsl:value-of select="tei:imprint/tei:biblScope[@type='no']"/></xsl:if>
				<xsl:if test="tei:imprint/tei:date"><xsl:text>&#10;</xsl:text>(<xsl:value-of select="tei:imprint/tei:date"/>)</xsl:if>
				<xsl:if test="tei:imprint/tei:biblScope/@type='pp'">: <xsl:value-of select="tei:imprint/tei:biblScope[@type='pp']"/></xsl:if>
				<xsl:text>. </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="tei:relatedItem" mode="mla">
		<xsl:if test="@type='otherEdition'"><xsl:text>Rpt. </xsl:text></xsl:if>
		<xsl:if test="tei:biblStruct/tei:analytic"><xsl:apply-templates select="tei:biblStruct/tei:analytic" mode="mla"/></xsl:if>
		<xsl:if test="tei:biblStruct/tei:monogr"><xsl:apply-templates select="tei:biblStruct/tei:monogr" mode="mla"/></xsl:if>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:mentioned</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:mentioned">
		<xsl:choose>
			<xsl:when test="@rend">
				<xsl:call-template name="rendering"/>
			</xsl:when>
			<xsl:when test="@rendition">
				<span>
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="mentioned">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Process elements tei:name in mode "plain"</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:name" mode="plain">
		<xsl:variable name="ident">
			<xsl:apply-templates mode="ident" select="."/>
		</xsl:variable>
		<xsl:call-template name="makeAnchor">
			<xsl:with-param name="name">
				<xsl:value-of select="$ident"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:apply-templates/>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:name and tei:persName</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:name|tei:persName">
		<xsl:apply-templates/>
		<xsl:choose>
			<xsl:when test="not(ancestor::tei:person|ancestor::tei:biblStruct)"/>
			<xsl:when test="following-sibling::tei:name|following-sibling::tei:persName">
				<xsl:text>, </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>. </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:note</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:note">
		<xsl:choose>
			<xsl:when test="@resp='editors' and @place='foot'">
				<a xmlns="http://www.w3.org/1999/xhtml">
					<xsl:attribute name="href">
						<xsl:text>#</xsl:text>
						<xsl:call-template name="noteN"/>
					</xsl:attribute>
					<xsl:text>&#160;[</xsl:text>
					<xsl:call-template name="noteN"/>
					<xsl:text>]</xsl:text>
				</a>
				<a xmlns="http://www.w3.org/1999/xhtml">
					<xsl:attribute name="name">
						<xsl:call-template name="noteN"/><xsl:text>back</xsl:text>
					</xsl:attribute>&#160;<!-- anchor --></a>
			</xsl:when>
			
			<xsl:when test="@resp='author' and @place='foot'">
				<a xmlns="http://www.w3.org/1999/xhtml">
					<xsl:attribute name="href">
						<xsl:text>#</xsl:text>
						<xsl:call-template name="noteN"/>
					</xsl:attribute>
					<xsl:text>&#160;[</xsl:text>
					<xsl:call-template name="noteN"/>
					<xsl:text>]</xsl:text>
				</a>
				<a xmlns="http://www.w3.org/1999/xhtml">
					<xsl:attribute name="name">
						<xsl:call-template name="noteN"/><xsl:text>back</xsl:text>
					</xsl:attribute>&#160;<!-- anchor --></a>
			</xsl:when>
				<xsl:when test="@place='inline' or ancestor::tei:bibl or ancestor::tei:biblStruct"> 
					<p xmlns="http://www.w3.org/1999/xhtml" class="small">
					<xsl:text>(</xsl:text>
					<xsl:apply-templates />
					<xsl:text>) </xsl:text>
					</p>				
				</xsl:when>
				
			<!-- 	<xsl:when test="@place='here'">
				<xsl:value-of select="substring-before(., ' ')"/>
				</xsl:when>  -->
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:note</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	
	<xsl:template match="tei:note" mode="localNotes">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="tei:note" mode="printnotes">
		<!-- <xsl:variable name="letterN">
			<xsl:value-of select="ancestor-or-self::tei:div/@n"/>
			</xsl:variable> -->
		<xsl:variable name="NN">
			<xsl:choose>
				<xsl:when test="not(@n)"/>
				<xsl:otherwise>
					<xsl:number level="any"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="not(ancestor::tei:bibl)">
			<xsl:variable name="identifier">
				<xsl:text>Note</xsl:text>
				<xsl:call-template name="noteID"/>
			</xsl:variable>
			<xsl:variable name="parent">
				<xsl:call-template name="locateParentdiv"/>
			</xsl:variable>
			<xsl:if test="$verbose='true'">
				<xsl:message>Note <xsl:value-of select="$identifier"/>
					<xsl:text> with parent </xsl:text>
					<xsl:value-of select="$parent"/></xsl:message>
			</xsl:if>
			<!-- With the below choose, I'm trying to test the entire document for multiple resp attributes, i.e. editors and author. If there are all multiple attributes, then we want labels for "Author's Note", "Editor's Note", etc. Otherwise, we do not. Not sure how to do this. [DR]-->
			<!-- <xsl:choose>
				<xsl:when test="@resp='editors' and  descendant::tei:note/@resp='author'"> -->
			<xsl:choose>
		  <xsl:when test="not(ancestor::tei:div[@type='essay'])">
		   <xsl:choose>
				<xsl:when test="@resp='editors'">
					<p class="note">
						<a xmlns="http://www.w3.org/1999/xhtml">
							<xsl:attribute name="name">
								<xsl:call-template name="noteN"/>
							</xsl:attribute>
							<xsl:text>[</xsl:text>
							<xsl:call-template name="noteN"/>
							<xsl:text>] </xsl:text>
						</a>
						<xsl:text>EDITOR'S NOTE: </xsl:text>
						<xsl:apply-templates/>
						<xsl:text>  </xsl:text>
						<a xmlns="http://www.w3.org/1999/xhtml">
							<xsl:attribute name="href">
								<xsl:text>#</xsl:text><xsl:call-template name="noteN"
								/><xsl:text>back</xsl:text>
							</xsl:attribute>BACK</a>
					</p>
				</xsl:when>
				<xsl:when test="@resp='author'">
					<p class="note">
						<a xmlns="http://www.w3.org/1999/xhtml">
							<xsl:attribute name="name">
								<xsl:call-template name="noteN"/>
							</xsl:attribute>
							<xsl:text>[</xsl:text>
							<xsl:call-template name="noteN"/>
							<xsl:text>] </xsl:text>
						</a>
						<xsl:text>AUTHOR'S NOTE: </xsl:text>
						<xsl:apply-templates/>
						<xsl:text>  </xsl:text>
						<a xmlns="http://www.w3.org/1999/xhtml">
							<xsl:attribute name="href">
								<xsl:text>#</xsl:text><xsl:call-template name="noteN"
								/><xsl:text>back</xsl:text>
							</xsl:attribute>BACK</a>
					</p>
				</xsl:when>
				<xsl:when test="@type='textual'">
					<p class="note">
						<a xmlns="http://www.w3.org/1999/xhtml">
							<xsl:attribute name="name">
								<xsl:call-template name="noteN"/>
							</xsl:attribute>
							<xsl:text>[</xsl:text>
							<xsl:call-template name="noteN"/>
							<xsl:text>] </xsl:text>
						</a>
						<xsl:text>TEXTUAL NOTE: </xsl:text>
						<xsl:apply-templates/>
						<xsl:text>  </xsl:text>
						<a xmlns="http://www.w3.org/1999/xhtml">
							<xsl:attribute name="href">
								<xsl:text>#</xsl:text><xsl:call-template name="noteN"
								/><xsl:text>back</xsl:text>
							</xsl:attribute>BACK</a>
					</p>
				</xsl:when>
				<xsl:when test="@place='foot'">
					<xsl:choose>
						<xsl:when test="@type='headnote'">
							<a xmlns="http://www.w3.org/1999/xhtml" href="#*">
								<xsl:text>*</xsl:text>
								<!-- might want to use &#8288; -->
							</a>
							<a xmlns="http://www.w3.org/1999/xhtml" name="back*">&#160;<!-- anchor --></a>
						</xsl:when>
						<xsl:otherwise>
							<a xmlns="http://www.w3.org/1999/xhtml" href="#{$NN}">
								<xsl:text>&#160;[</xsl:text>
								<xsl:value-of select="$NN"/>
								<xsl:text>]</xsl:text>
							</a>
							<a xmlns="http://www.w3.org/1999/xhtml" name="back{$NN}">&#160;<!-- anchor --></a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				</xsl:choose>
		  </xsl:when>
			  <xsl:otherwise>
			    <p class="note">
			      <a xmlns="http://www.w3.org/1999/xhtml">
			        <xsl:attribute name="name">
			          <xsl:call-template name="noteN"/>
			        </xsl:attribute>
			        <xsl:text>[</xsl:text>
			        <xsl:call-template name="noteN"/>
			        <xsl:text>] </xsl:text>
			      </a>
			      <xsl:apply-templates/>
			      <xsl:text>  </xsl:text>
			      <a xmlns="http://www.w3.org/1999/xhtml">
			        <xsl:attribute name="href">
			          <xsl:text>#</xsl:text><xsl:call-template name="noteN"
			          /><xsl:text>back</xsl:text>
			        </xsl:attribute>BACK</a>
			    </p>
			  </xsl:otherwise>
			</xsl:choose>
			<!--</xsl:when>
				<xsl:otherwise>
					<p class="note">
						<a xmlns="http://www.w3.org/1999/xhtml">
							<xsl:attribute name="name">
								<xsl:call-template name="noteN"/>
							</xsl:attribute>
							<xsl:text>[</xsl:text>
							<xsl:call-template name="noteN"/>
							<xsl:text>] </xsl:text>
						</a>
						<xsl:apply-templates/>
						<xsl:text>  </xsl:text>
						<a xmlns="http://www.w3.org/1999/xhtml">
							<xsl:attribute name="href">
								<xsl:text>#</xsl:text><xsl:call-template name="noteN"
								/><xsl:text>back</xsl:text>
							</xsl:attribute>BACK</a>
					</p>
				</xsl:otherwise>
			</xsl:choose>-->
		</xsl:if>
	</xsl:template>
	<!-- RC: I added this to get more control over the presentation of footnotes -->
	<xd:doc>
		<xd:short>Process elements inside notes</xd:short>
		<xd:detail>I have stanzas and lines, but you may need to add more.</xd:detail>
	</xd:doc>
	<xsl:template match="tei:note/tei:lg">
		<blockquote xmlns="http://www.w3.org/1999/xhtml">
			<blockquote xmlns="http://www.w3.org/1999/xhtml">
				<xsl:apply-templates/>
			</blockquote>
		</blockquote>
	</xsl:template>
	<xsl:template match="tei:note/tei:lg/tei:l">
		<div xmlns="http://www.w3.org/1999/xhtml">
			<xsl:choose>
				<xsl:when test="@rendition">
					<xsl:call-template name="applyRendition"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">
						<xsl:text>l</xsl:text>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates/>
		</div>
	</xsl:template>


	<xd:doc>
		<xd:short>Process elements tei:note[@type='action']</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:note[@type='action']">
		<div class="right"><b>Action <xsl:number count="tei:note[@type='action']" level="any"/></b>: <i>
				<xsl:apply-templates/>
			</i></div>
	</xsl:template>
	<xd:doc>
		<xd:short>Process element tei:pb</xd:short>
		<xd:detail>RCs: I changed this for house style.</xd:detail>
	</xd:doc>
	<xsl:template match="tei:pb">
		<xsl:choose>
		<xsl:when test="@rend='inline'">
			<xsl:comment>page-break-before: always</xsl:comment>
			<span xmlns="http://www.w3.org/1999/xhtml" class="pageNumberInline">
				<xsl:if test="@facs">
					<a xmlns="http://www.w3.org/1999/xhtml" href="{@facs}">
				<xsl:value-of select="concat('Page ', @n)"/>
					</a>
					</xsl:if>
			</span>
		</xsl:when>
			<xsl:otherwise>
				<xsl:comment>page-break-before: always</xsl:comment>
				<div xmlns="http://www.w3.org/1999/xhtml" class="absPageImages">
					<xsl:if test="@facs">
						<a xmlns="http://www.w3.org/1999/xhtml">
							<xsl:attribute name="href">
								<xsl:value-of select="concat(substring-before(@facs, 'Thumb'), substring-after(@facs, 'Thumb'))"/>
							</xsl:attribute>  
							<span class="pageNumber"><xsl:value-of select="concat('Page ', @n)"/></span>
							<img xmlns="http://www.w3.org/1999/xhtml" src="{@facs}" width="80"/>
						</a>
					</xsl:if>
				</div>
			</xsl:otherwise>
		<!-- <xsl:otherwise>
			<xsl:comment>page-break-before: always</xsl:comment>
			<span xmlns="http://www.w3.org/1999/xhtml" class="pageNumber">
				<xsl:if test="@facs">
					<a class="colorbox" xmlns="http://www.w3.org/1999/xhtml" href="{@facs}">
					<xsl:value-of select="concat('Page ', @n)"/>
					</a>
				</xsl:if>
			</span>
			</xsl:otherwise>  -->
	</xsl:choose>
	</xsl:template> 

	<!--RC: I changed this completely from the TEI to simplify para numbers -->
	<xd:doc>
		<xd:short>Process element tei:p</xd:short>
		<xd:detail>This numbers the paragraph and adds proper rendition information.</xd:detail>
	</xd:doc>
	<xsl:template match="tei:p">
		<xsl:variable name="totalNbrPs">
			<xsl:number level="any" from="tei:text"/>		
		</xsl:variable>
		<xsl:variable name="disqualifiedPs">
			<xsl:value-of select="count(preceding::tei:p[@rend='noCount'])"/>
		</xsl:variable>
		<xsl:variable name="toBeNumberedPs">
			<xsl:value-of select="$totalNbrPs - $disqualifiedPs"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@rendition">
				<p xmlns="http://www.w3.org/1999/xhtml">
					<xsl:call-template name="applyRendition"/>
					<xsl:if test="not(@rend='noCount')">
						<strong>
							<xsl:value-of select="$toBeNumberedPs"/>
						</strong>
						<xsl:text>.&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
					</xsl:if>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p xmlns="http://www.w3.org/1999/xhtml" class="pnoindent">
					<xsl:call-template name="applyRendition"/>
					<xsl:if test="not(@rend='noCount')">
						<strong>
							<xsl:value-of select="$toBeNumberedPs"/>
						</strong>
						<xsl:text>.&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
					</xsl:if>
					<xsl:apply-templates/>
					
					<!-- use this for the list pages of Southey, Bloomfield, and other editions
						<xsl:choose>
						<xsl:when test="child::tei:hi[@rend='bold']">
						<xsl:value-of select="substring-before(., tei:hi[@rend='bold'])"/>
						<strong><xsl:value-of select="tei:hi"/></strong>
						<xsl:value-of select="substring-after(.,tei:hi[@rend='bold'])"/>
						</xsl:when>
						<xsl:otherwise>
						<xsl:apply-templates/>
						</xsl:otherwise>
						</xsl:choose> -->
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:p[@rend='box']</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:p[@rend='box']">
		<p class="box">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
<!-- I added this just to get a rendition of center around the performance element - DR -->	
	<xd:doc>
		<xd:short>Process elements tei:performance</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	
	<xsl:template match="tei:performance">
		<div xmlns="http://www.w3.org/1999/xhtml">
			<xsl:choose>
				<xsl:when test="@rendition">
					<xsl:call-template name="applyRendition"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">
						<xsl:text>performance</xsl:text>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
	<div xmlns="http://www.w3.org/1999/xhtml">
		<xsl:choose>
			<xsl:when test="@rendition">
				<xsl:call-template name="applyRendition"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">
					<xsl:text>performance</xsl:text>
				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates/>
	</div>

	<xd:doc>
		<xd:short>Process elements tei:postmark</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>

	<xsl:template match="tei:postmark">
		<p xmlns="http://www.w3.org/1999/xhtml">
			<xsl:choose>
				<xsl:when test="tei:dateline/@rend=''">
					<em>
						<xsl:value-of select="tei:dateline/tei:rs"/>
					</em>
					<xsl:value-of select="tei:date"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="@rendition">
							<xsl:call-template name="applyRendition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">
								<xsl:text>l</xsl:text>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<em>
						<xsl:value-of select="ancestor-or-self::tei:dateline/tei:rs"/>
					</em>
					<xsl:apply-templates select="ancestor-or-self::tei:dateline/tei:date"/>
				</xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:q and tei:said</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:q|tei:said">
		<xsl:choose>
			<xsl:when test="tei:p">
				<blockquote>
					<xsl:choose>
						<xsl:when test="@rend">
							<xsl:attribute name="class">
								<xsl:value-of select="@rend"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="@rendition">
							<xsl:call-template name="applyRendition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">
								<xsl:text>q</xsl:text>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates/>
				</blockquote>
			</xsl:when>
			<xsl:when test="@rend='display'">
				<p class="blockquote">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="tei:text">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="tei:lg">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="makeQuote"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:q[@rend='display']</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:q[@rend='display']">
		<blockquote>
			<xsl:choose>
				<xsl:when test="@rend">
					<xsl:attribute name="class">
						<xsl:value-of select="@rend"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="@rendition">
					<xsl:call-template name="applyRendition"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">
						<xsl:text>q</xsl:text>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="tei:p">
					<xsl:apply-templates/>
				</xsl:when>
				<xsl:otherwise>
					<p>
						<xsl:apply-templates/>
					</p>
				</xsl:otherwise>
			</xsl:choose>
		</blockquote>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:q[@rend='eg']</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:q[@rend='eg']">
		<div xmlns="http://www.w3.org/1999/xhtml" >
			<xsl:if test="$cssFile">
				<xsl:attribute name="class">eg</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:quote</xd:short>
		<xd:detail>RCs: do not use renditions.  CSS stylesheet needs to contain ".blockquote" to style this whether blockquote or
			span elements are used; both will have that blockquote class</xd:detail>
	</xd:doc>
	<xsl:template match="tei:quote"><xsl:choose>
			<xsl:when test="parent::tei:cit">
				<div xmlns="http://www.w3.org/1999/xhtml">
					<xsl:choose>
						<xsl:when test="@rendition">
							<xsl:call-template name="applyRendition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">citquote</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:when test="contains(concat(' ', @rend, ' '), ' quoted ')">
				<xsl:value-of select="$preQuote"/>
				<xsl:apply-templates/>
				<xsl:value-of select="$postQuote"/>
				<xsl:if test="following-sibling::tei:bibl">
					<span class="quotedbibl">
						<xsl:text>(</xsl:text>
						<xsl:apply-templates select="following-sibling::tei:bibl"/>
						<xsl:text>)</xsl:text>
					</span>
				</xsl:if>
			</xsl:when>
		<xsl:when test="parent::tei:p or parent::tei:note">
				<xsl:choose>
					<xsl:when test="@rendition">
						<div xmlns="http://www.w3.org/1999/xhtml">
							<xsl:call-template name="applyRendition"/>
							<xsl:apply-templates/>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<div xmlns="http://www.w3.org/1999/xhtml" class="blockquote">
							<xsl:apply-templates/>
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<blockquote xmlns="http://www.w3.org/1999/xhtml">
					<xsl:choose>
						<xsl:when test="@rend">
							<xsl:attribute name="class">
								<xsl:value-of select="@rend"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="@rendition">
							<xsl:call-template name="applyRendition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">
								<xsl:text>blockquote</xsl:text>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="tei:p">
							<xsl:apply-templates/>
						</xsl:when>
						<xsl:when test="tei:l">
							<xsl:apply-templates/>
						</xsl:when>
						<xsl:otherwise>
							<p><xsl:apply-templates/></p>
						</xsl:otherwise>
					</xsl:choose>
				</blockquote>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:resp</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:resp">
		<xsl:apply-templates/>
		<xsl:text> </xsl:text>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:respStmt</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:respStmt">
		<xsl:apply-templates/>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:rs</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:rs">
		<em xmlns="http://www.w3.org/1999/xhtml">
			<xsl:value-of select="ancestor-or-self::tei:rs/text()"/>
		</em>
	</xsl:template>



	<xd:doc>
		<xd:short>Process elements tei:salute</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:opener/tei:salute | tei:closer/tei:salute | tei:closer/tei:signed">
		<xsl:choose>
			<xsl:when test="@rendition">
				<p xmlns="http://www.tei-c.org/ns/1.0">
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p xmlns="http://www.tei-c.org/ns/1.0" class="pnonindent">
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:seg</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:seg">
		<span xmlns="http://www.w3.org/1999/xhtml">
			<xsl:choose>
				<xsl:when test="@type">
					<xsl:attribute name="class">
						<xsl:value-of select="@type"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="@rend">
					<xsl:attribute name="class">
						<xsl:value-of select="@rend"/>
					</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:sic</xd:short>
		<xd:detail>Does not do anything yet.</xd:detail>
	</xd:doc>
	<xsl:template match="tei:sic">
		<xsl:apply-templates/>
		<xsl:text> (</xsl:text>
		<em xmlns="http://www.w3.org/1999/xhtml">sic</em>
		<xsl:text>)</xsl:text>
		
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:signed</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:signed">
		<xsl:choose>
			<xsl:when test="@rendition">
				<p xmlns="http://www.tei-c.org/ns/1.0">
					<xsl:call-template name="applyRend"/>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p xmlns="http://www.tei-c.org/ns/1.0" class="pnonindent">
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:time</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:time">
		<xsl:choose>
			<xsl:when test="not(parent::tei:p)">
				<xsl:choose>
					<xsl:when test="not(parent::tei:dateline)">
						<p xmlns="http://www.w3.org/1999/xhtml">
							<xsl:apply-templates/>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
				<xsl:text> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:space</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:space">
		<xsl:choose>
			<xsl:when test="@quantity|@extent">
				<xsl:call-template name="space_loop">
					<xsl:with-param name="extent" select="@quantity|@extent"/>
				</xsl:call-template>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:term</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:term">
		<a>
			<xsl:attribute name="name">
				<xsl:value-of select="@xml:id"/>
			</xsl:attribute>
			<xsl:comment>html anchor</xsl:comment>
		</a>
		<xsl:choose>
			<xsl:when test="@rend">
				<xsl:call-template name="rendering"/>
			</xsl:when>
			<xsl:when test="@rendition">
				<span>
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="term">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:title</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:title" mode="withbr">
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:titleStmt/tei:title</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:titleStmt/tei:title">
		<xsl:if test="preceding-sibling::tei:title">
			<br/>
		</xsl:if>
		<xsl:apply-templates/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process element tei:title</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>

	<!-- <xsl:template match="tei:title">
		<xsl:choose>
			<xsl:when test="@level = 'a'">
				<span xmlns="http://www.w3.org/1999/xhtml" class="titlea">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="@level = 'm'">
				<span xmlns="http://www.w3.org/1999/xhtml" class="titlem">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span xmlns="http://www.w3.org/1999/xhtml" class="titlem">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:template>  -->

	<!-- RC: I added this bc it seemed necessary 
	<xsl:template match="tei:front//*/tei:titlePart">
		<xsl:apply-templates/>
		</xsl:template> -->

	<xd:doc>
		<xd:short>Process elements tei:witList</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:witList">
		<xsl:apply-templates select="./witness"/>
	</xsl:template>
	<xd:doc>
		<xd:short>Process elements tei:witness</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:witness">
		<p>
			<a name="{@xml:id}"/>
			<b>Witness <xsl:value-of select="@xml:id"/>.</b>
			<br/>
			<xsl:value-of select="text()"/>
			<br/>
			<xsl:apply-templates select="tei:biblStruct"/>
			<xsl:if test="child::tei:note"><br/>Zie noot: <xsl:apply-templates select="child::tei:note"/></xsl:if>
		</p>
	</xsl:template>


	<xd:doc>
		<xd:short>[html] Activate a value for @rendition</xd:short>
		<xd:param name="value">value</xd:param>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="applyRendition">
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="@rendition=''"/>
				<xsl:when test="contains(normalize-space(@rendition),' ')">
					<xsl:call-template name="splitRendition">
						<xsl:with-param name="value">
							<xsl:value-of select="normalize-space(@rendition)"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="findRendition">
						<xsl:with-param name="value">
							<xsl:value-of select="@rendition"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>

	<xd:doc>
		<xd:short>[html] Get another value from a space-separated list</xd:short>
		<xd:param name="value">value</xd:param>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="splitRendition">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="$value=''"/>
			<xsl:when test="contains($value,' ')">
				<xsl:call-template name="findRendition">
					<xsl:with-param name="value">
						<xsl:value-of select="substring-before($value,' ')"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="splitRendition">
					<xsl:with-param name="value">
						<xsl:value-of select="substring-after($value,' ')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="findRendition">
					<xsl:with-param name="value">
						<xsl:value-of select="$value"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="findRendition">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="starts-with($value,'#')">
				<xsl:value-of select="substring-after($value,'#')"/>
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="document($value)">
					<xsl:apply-templates select="@xml:id"/>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>[html] Active a value for @rend</xd:short>
		<xd:param name="value">value</xd:param>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="applyRend">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="not($value='')">
				<xsl:variable name="thisparm" select="substring-before($value,$rendSeparator)"/>
				<xsl:call-template name="renderingInner">
					<xsl:with-param name="value" select="$thisparm"/>
					<xsl:with-param name="rest" select="substring-after($value,$rendSeparator)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>[html] </xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="continuedToc">
		<xsl:if test="tei:div|tei:div0|tei:div1|tei:div2|tei:div3|tei:div4|tei:div5|tei:div6">
			<ul class="toc">
				<xsl:apply-templates mode="maketoc" select="tei:div|tei:div0|tei:div1|tei:div2|tei:div3|tei:div4|tei:div5|tei:div6"/>
			</ul>
		</xsl:if>
	</xsl:template>
	<xd:doc>
		<xd:short>[html] How to identify a note</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="noteID">
		<xsl:choose>
			<xsl:when test="@xml:id">
				<xsl:value-of select="@xml:id"/>
			</xsl:when>
			<xsl:when test="@n">
				<xsl:value-of select="@n"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:number count="tei:note" level="any"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>[html] How to label a note</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="noteN">
		<xsl:choose>
			<xsl:when test="@n">
				<xsl:value-of select="@n"/>
			</xsl:when>
			<xsl:when test="not(@place) and $consecutiveFootnoteNumbers='true'">
				<xsl:number count="tei:note[not(@place)]" level="any"/>
			</xsl:when>
			<xsl:when test="not(@place)">
				<xsl:choose>
					<xsl:when test="ancestor::tei:front">
						<xsl:number count="tei:note[not(@place)]" from="tei:front" level="any"/>
					</xsl:when>
					<xsl:when test="ancestor::tei:back">
						<xsl:number count="tei:note[not(@place)]" from="tei:back" level="any"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:number count="tei:note[not(@place)]" from="tei:body" level="any"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@place='end'">
				<xsl:choose>
					<xsl:when test="$consecutiveFootnoteNumbers = 'true'">
						<xsl:number count="tei:note[./@place='end']" level="any"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="ancestor::tei:front">
								<xsl:number count="tei:note[./@place='end']" from="tei:front" level="any"/>
							</xsl:when>
							<xsl:when test="ancestor::tei:back">
								<xsl:number count="tei:note[./@place='end']" from="tei:back" level="any"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:number count="tei:note[./@place='end']" from="tei:body" level="any"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$consecutiveFootnoteNumbers = 'true'">
						<xsl:number count="tei:note[./@place='foot']" level="any"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="ancestor::tei:front">
								<xsl:number count="tei:note[./@place='foot']" from="tei:front" level="any"/>
							</xsl:when>
							<xsl:when test="ancestor::tei:back">
								<xsl:number count="tei:note[./@place='foot']" from="tei:back" level="any"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:number count="tei:note[./@place='foot']" from="tei:body" level="any"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>[html] Show relevant footnotes</xd:short>
		<xd:param name="currentID">currentID</xd:param>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="partialFootNotes">
		<xsl:param name="currentID"/>
		<xsl:choose>
			<xsl:when test="$currentID='current'"/>
			<xsl:when test="$currentID='' and $splitLevel=-1">
				<xsl:call-template name="printNotes"/>
			</xsl:when>
			<xsl:when test="$currentID=''">
				<xsl:for-each select=" descendant::tei:text">
					<xsl:call-template name="printNotes"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="count(key('IDS',$currentID))&gt;0">
						<xsl:for-each select="key('IDS',$currentID)">
							<xsl:call-template name="printNotes"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates mode="xpath" select="ancestor-or-self::tei:TEI/descendant::tei:text">
							<xsl:with-param name="xpath" select="$currentID"/>
							<xsl:with-param name="action">notes</xsl:with-param>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>[html] </xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>

	<xsl:template name="printNotes">
		<xsl:choose>
			<xsl:when test="$footnoteFile='true' and ancestor-or-self::tei:TEI/tei:text/descendant::tei:note[@place='foot' or @place='end']">
				<xsl:variable name="BaseFile">
					<xsl:value-of select="$masterFile"/>
					<xsl:call-template name="addCorpusID"/>
				</xsl:variable>
				<xsl:call-template name="outputChunk">
					<xsl:with-param name="ident">
						<xsl:value-of select="concat($BaseFile,'-notes')"/>
					</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="writeNotes"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="self::tei:div">
				<xsl:variable name="depth">
					<xsl:apply-templates mode="depth" select="."/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$depth &lt; $splitLevel ">
						<xsl:if test="child::*[not(self::tei:div)]/descendant::tei:note[@place='foot' or @place='end']">
							<div xmlns="http://www.w3.org/1999/xhtml" class="notes">
								<div class="noteHeading">
									<xsl:call-template name="i18n">
										<xsl:with-param name="word">noteHeading</xsl:with-param>
									</xsl:call-template>
								</div>
								<xsl:apply-templates mode="printnotes"
									select="child::*[not(self::tei:div)]/descendant::tei:note[@place='foot' or @place='end']"/>
							</div>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="descendant::tei:note[@place='foot' or @place='end']">
							<div xmlns="http://www.w3.org/1999/xhtml" class="notes">
								<div class="noteHeading">
									<xsl:call-template name="i18n">
										<xsl:with-param name="word">noteHeading</xsl:with-param>
									</xsl:call-template>
								</div>
								<xsl:apply-templates mode="printnotes" select="descendant::tei:note[@place='foot' or @place='end']"/>
							</div>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$splitLevel &gt;-1 and $requestedID='' and
			$STDOUT='true'">
				<xsl:for-each select="descendant-or-self::text/*[1]/*[1]">
					<xsl:call-template name="printNotes"/>
				</xsl:for-each>
			</xsl:when>

			<xsl:when test="$splitLevel &gt;-1 and self::tei:text"/>
			<!--
	    <div class="notes text">
	    <div class="noteHeading">
	    <xsl:call-template name="i18n">
	    <xsl:with-param name="word">noteHeading</xsl:with-param>
	    </xsl:call-template>
	    </div>
	    <xsl:for-each
	    select="descendant::tei:note[(@place='foot' or @place='end') and
	    not(ancestor::tei:div)]">
	    <xsl:apply-templates mode="printnotes" select="."/>
	    </xsl:for-each>
	    </div>
	    </xsl:when>
	-->

			<xsl:otherwise>
				<xsl:if test="descendant::tei:note[@place='foot' or @place='end']">
					<div xmlns="http://www.w3.org/1999/xhtml" class="notes">
						<div class="noteHeading">
							<h3>
								<xsl:call-template name="i18n">
									<xsl:with-param name="word">noteHeading</xsl:with-param>
								</xsl:call-template>
							</h3>
						</div>

						<xsl:apply-templates mode="printnotes" select="descendant::tei:note[@place='foot' or @place='end']"/>
					</div>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="ancestor-or-self::tei:TEI/tei:text/descendant::tei:app">

			<div xmlns="http://www.w3.org/1999/xhtml" class="variantNotes">
				<div xmlns="http://www.w3.org/1999/xhtml" class="variantNoteHeading">
					<xsl:call-template name="i18n">
						<xsl:with-param name="word">variantNoteHeading</xsl:with-param>
					</xsl:call-template>
				</div>
				<xsl:apply-templates mode="printnotes" select="descendant::tei:app"/>
			</div>
		</xsl:if>

	</xsl:template>
	<xd:doc>
		<xd:short>[html] </xd:short>
		<xd:detail>
			<p> rendering. support for multiple rendition elements added by Nick Nicholas </p>
		</xd:detail>
	</xd:doc>
	<xsl:template name="rendering">
		<xsl:call-template name="applyRend">
			<xsl:with-param name="value" select="@rend"/>
		</xsl:call-template>
	</xsl:template>
	<xd:doc>
		<xd:short>[html] </xd:short>
		<xd:param name="value">the current segment of the value of the rend attribute</xd:param>
		<xd:param name="rest">the remainder of the attribute</xd:param>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="renderingInner">
		<xsl:param name="value"/>
		<xsl:param name="rest"/>
		<xsl:choose>
			<xsl:when test="$value='bold'">
				<strong>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</strong>
			</xsl:when>
			<xsl:when test="$value='center'">
				<center>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</center>
			</xsl:when>
			<xsl:when test="$value='code'">
				<strong>
					<tt>
						<xsl:call-template name="applyRend">
							<xsl:with-param name="value" select="$rest"/>
						</xsl:call-template>
					</tt>
				</strong>
			</xsl:when>
			<xsl:when test="$value='ital'">
				<i>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</i>
			</xsl:when>
			<xsl:when test="$value='italic'">
				<i>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</i>
			</xsl:when>
			<xsl:when test="$value='it'">
				<i>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</i>
			</xsl:when>
			<xsl:when test="$value='italics'">
				<i>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</i>
			</xsl:when>
			<xsl:when test="$value='i'">
				<i>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</i>
			</xsl:when>
			<xsl:when test="$value='sc'">
				<!--   <small>
	   <xsl:value-of
	   select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
	   </small>
      -->
				<span style="font-variant: small-caps">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='plain'">
				<xsl:call-template name="applyRend">
					<xsl:with-param name="value" select="$rest"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$value='quoted'">
				<xsl:text>‘</xsl:text>
				<xsl:call-template name="applyRend">
					<xsl:with-param name="value" select="$rest"/>
				</xsl:call-template>
				<xsl:text>’</xsl:text>
			</xsl:when>
			<xsl:when test="$value='sub'">
				<sub>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</sub>
			</xsl:when>
			<xsl:when test="$value='sup'">
				<sup>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</sup>
			</xsl:when>
			<xsl:when test="$value='important'">
				<span class="important">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<!-- NN added -->
			<xsl:when test="$value='ul'">
				<u>
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</u>
			</xsl:when>
			<!-- NN added -->
			<xsl:when test="$value='interlinMarks'">
				<xsl:text>`</xsl:text>
				<xsl:call-template name="applyRend">
					<xsl:with-param name="value" select="$rest"/>
				</xsl:call-template>
				<xsl:text>´</xsl:text>
			</xsl:when>
			<xsl:when test="$value='overbar'">
				<span style="text-decoration:overline">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='expanded'">
				<span style="letter-spacing: 0.15em">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='strike'">
				<span style="text-decoration: line-through">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='small'">
				<span style="font-size: 75%">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='large'">
				<span style="font-size: 150%">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='smaller'">
				<span style="font-size: 50%">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='larger'">
				<span style="font-size: 200%">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='calligraphic'">
				<span style="font-family: cursive">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='gothic'">
				<span style="font-family: fantasy">
					<xsl:call-template name="applyRend">
						<xsl:with-param name="value" select="$rest"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="$value='noindex'">
				<xsl:call-template name="applyRend">
					<xsl:with-param name="value" select="$rest"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="local-name(.)='p'">
						<xsl:call-template name="unknownRendBlock">
							<xsl:with-param name="rest" select="$rest"/>
							<xsl:with-param name="value" select="$value"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="unknownRendInline">
							<xsl:with-param name="rest" select="$rest"/>
							<xsl:with-param name="value" select="$value"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>[html] </xd:short>
		<xd:param name="extent">extent</xd:param>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="space_loop">
		<xsl:param name="extent"/>
		<xsl:choose>
			<xsl:when test="$extent &lt; 1"> </xsl:when>
			<xsl:otherwise>
				<xsl:text> </xsl:text>
				<xsl:variable name="newextent">
					<xsl:value-of select="$extent - 1"/>
				</xsl:variable>
				<xsl:call-template name="space_loop">
					<xsl:with-param name="extent" select="$newextent"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:short>[html] Process unknown rend attribute by turning it into an HTML class</xd:short>
		<xd:param name="value">current value</xd:param>
		<xd:param name="rest">remaining values</xd:param>
		<xd:detail> </xd:detail>
	</xd:doc>

	<xsl:template name="unknownRendBlock">
		<xsl:param name="value"/>
		<xsl:param name="rest"/>
		<xsl:if test="not($value='')">
			<xsl:attribute name="class">
				<xsl:value-of select="$value"/>
			</xsl:attribute>
			<xsl:call-template name="applyRend">
				<xsl:with-param name="value" select="$rest"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xd:doc>
		<xd:short>[html] Process unknown rend attribute by turning it into an HTML class</xd:short>
		<xd:param name="value">value</xd:param>
		<xd:param name="rest">rest</xd:param>
		<xd:detail> </xd:detail>
	</xd:doc>

	<xsl:template name="unknownRendInline">
		<xsl:param name="value"/>
		<xsl:param name="rest"/>
		<xsl:if test="not($value='')">
			<span class="{$value}">
				<xsl:call-template name="applyRend">
					<xsl:with-param name="value" select="$rest"/>
				</xsl:call-template>
			</span>
		</xsl:if>
	</xsl:template>
	<xd:doc>
		<xd:short>[html] create external notes file</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="writeNotes">
		<html>
			<xsl:call-template name="addLangAtt"/>
			<head>
				<title>
					<xsl:apply-templates select="descendant-or-self::tei:text/tei:front//tei:docTitle//text()"/>
					<xsl:text>: </xsl:text>
					<xsl:call-template name="i18n">
						<xsl:with-param name="word">noteHeading</xsl:with-param>
					</xsl:call-template>
				</title>
				<xsl:call-template name="includeCSS"/>
				<xsl:call-template name="cssHook"/>
			</head>
			<body>
				<xsl:attribute name="onload">
					<xsl:text>startUp()</xsl:text>
				</xsl:attribute>
				<xsl:call-template name="bodyHook"/>
				<xsl:call-template name="bodyJavascriptHook"/>
				<div class="stdheader">
					<xsl:call-template name="stdheader">
						<xsl:with-param name="title">
							<xsl:apply-templates select="descendant-or-self::tei:text/tei:front//tei:docTitle//text()"/>
							<xsl:text>: </xsl:text>
							<xsl:call-template name="i18n">
								<xsl:with-param name="word">noteHeading</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</div>
				<div xmlns="http://www.w3.org/1999/xhtml" class="notes">
					<div xmlns="http://www.w3.org/1999/xhtml" class="noteHeading">
						<xsl:call-template name="i18n">
							<xsl:with-param name="word">noteHeading</xsl:with-param>
						</xsl:call-template>
					</div>
					<xsl:apply-templates mode="printnotes" select="descendant::tei:note[@place]"/>
				</div>
				<xsl:call-template name="stdfooter"/>
				<xsl:call-template name="bodyEndHook"/>
			</body>
		</html>
	</xsl:template>

	<xd:doc>
		<xd:short>[html] convert rend attribute to HTML class</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="rendToClass">
		<xsl:param name="id">true</xsl:param>
		<xsl:param name="default"/>
		<xsl:choose>
			<xsl:when test="@rend and starts-with(@rend,'class:')">
				<xsl:attribute name="class">
					<xsl:value-of select="substring-after(@rend,'class:')"/>
				</xsl:attribute>
			</xsl:when>


			<xsl:when test="@rend">
				<xsl:attribute name="class">
					<xsl:value-of select="@rend"/>
				</xsl:attribute>
			</xsl:when>
			<xsl:when test="@rendition">
				<xsl:call-template name="applyRendition"/>
			</xsl:when>
			<xsl:when test="not($default='')">
				<xsl:attribute name="class">
					<xsl:value-of select="$default"/>
				</xsl:attribute>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="$id='true'">
			<xsl:choose>
				<xsl:when test="@id">
					<xsl:copy-of select="@id"/>
				</xsl:when>
				<xsl:when test="@xml:id">
					<xsl:attribute name="id">
						<xsl:value-of select="@xml:id"/>
					</xsl:attribute>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xd:doc>
		<xd:short>[html] Create a point to which we can link in the HTML</xd:short>
		<xd:param name="name">value for identifier</xd:param>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="makeAnchor">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="$name and $xhtml='true'">
				<span>
					<xsl:attribute name="id">
						<xsl:value-of select="$name"/>
					</xsl:attribute>
					<xsl:comment>anchor</xsl:comment>
				</span>
			</xsl:when>
			<xsl:when test="$name">
				<a name="{$name}">
					<xsl:comment>anchor</xsl:comment>
				</a>
			</xsl:when>
			<xsl:when test="@xml:id and $xhtml='true'">
				<span>
					<xsl:attribute name="id">
						<xsl:value-of select="@xml:id"/>
					</xsl:attribute>
					<xsl:comment>anchor</xsl:comment>
				</span>
			</xsl:when>
			<xsl:when test="@xml:id">
				<a name="{@xml:id}">
					<xsl:comment>anchor</xsl:comment>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="me">
					<xsl:value-of select="$masterFile"/>-<xsl:value-of select="local-name(.)"/>-<xsl:value-of select="generate-id()"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$xhtml='true'">
						<span>
							<xsl:attribute name="id">
								<xsl:value-of select="$me"/>
							</xsl:attribute>
							<xsl:comment>anchor</xsl:comment>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<a name="{$me}">
							<xsl:comment>anchor</xsl:comment>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:short>Process elements tei:soCalled</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template match="tei:soCalled">
		<xsl:choose>
			<xsl:when test="@rend">
				<xsl:call-template name="rendering"/>
			</xsl:when>
			<xsl:when test="@rendition">
				<span>
					<xsl:call-template name="applyRendition"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$preQuote"/>
				<xsl:apply-templates/>
				<xsl:value-of select="$postQuote"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xd:doc>
		<xd:short>Copy all attributes in HTML namespace</xd:short>
		<xd:detail> </xd:detail>
	</xd:doc>
	<xsl:template name="htmlAttributes">
		<xsl:for-each select="@*">
			<xsl:if test="namespace-uri(.)='http://www.w3.org/1999/xhtml'">
				<xsl:attribute name="{local-name(.)}">
					<xsl:value-of select="."/>
				</xsl:attribute>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>




</xsl:stylesheet>
