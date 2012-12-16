﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:doc="urn:doc"
                xmlns:hrc="urn:lostdoc-core:inheritance-hierarchy"
                xmlns:ld="urn:lostdoc-core"
                exclude-result-prefixes="msxsl doc hrc ld">

  <xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>

  <xsl:include href="Layout.xslt"/>
  <xsl:include href="Naming.xslt"/>
  <xsl:include href="Common.xslt"/>
  <xsl:include href="Navigation2.xslt"/>
  <xsl:include href="DocComments.xslt"/>

  <xsl:template name="title">
    <xsl:text>Library</xsl:text>
  </xsl:template>


  <xsl:template name="navigation">
    <xsl:apply-templates select="/bundle" mode="xnav"/>
  </xsl:template>




  <xsl:template name="content">
    <h1>Library</h1>
    <h2>
      <xsl:text>Assemblies</xsl:text>
    </h2>
    <table>
      <thead>
        <tr>
          <th>
          </th>
          <th>
            <xsl:text>Name</xsl:text>
          </th>
          <th>
            <xsl:text>Version</xsl:text>
          </th>
          <th>
            <xsl:text>Description</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="/bundle/assembly[@phase = '0']"/>
      </tbody>
    </table>

    <h2>
      <xsl:text>Namespaces</xsl:text>
    </h2>
    <table>
      <thead>
        <tr>
          <th>
          </th>
          <th>
            <xsl:text>Name</xsl:text>
          </th>
          <th>
            <xsl:text>Description</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="/bundle/assembly[@phase = '0']/namespace[@phase = '0']">
          <xsl:sort select="@name"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="assembly">
    <tr>
      <td class="icons"> 
        <span class="icon-assembly"></span>
      </td>
      <td>
        <xsl:apply-templates select="." mode="link"/>
      </td>
      <td>
        <xsl:value-of select="ld:significantVersion(@assetId)"/>
      </td>
      <td>
        <xsl:apply-templates select="doc:summary"/>
        <xsl:if test="not(doc:summary)">
          <xsl:call-template name="missing"/>
        </xsl:if>
      </td>
    </tr>
  </xsl:template>


  <xsl:template match="namespace">
    <xsl:variable name="aid" select="ld:nover(@assetId)"/>
    <xsl:if test="not(preceding::namespace[@assetId and ld:nover(@assetId) = $aid])">
      <tr>
        <td class="icons">
          <span class="icon-namespace"></span>
        </td>
        <td>
          <a href="{ld:resolve(ld:nover(@assetId))}">
            <xsl:apply-templates select="." mode="displayText"/>
          </a>
        </td>
        <td>
          <xsl:apply-templates select="doc:summary"/>
          <xsl:if test="not(doc:summary)">
            <xsl:call-template name="missing"/>
          </xsl:if>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>