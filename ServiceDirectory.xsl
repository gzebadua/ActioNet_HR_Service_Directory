<xsl:stylesheet xmlns:x="http://www.w3.org/2001/XMLSchema" xmlns:d="http://schemas.microsoft.com/sharepoint/dsp" version="1.0" exclude-result-prefixes="xsl msxsl ddwrt" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:asp="http://schemas.microsoft.com/ASPNET/20" xmlns:__designer="http://schemas.microsoft.com/WebParts/v2/DataView/designer" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:SharePoint="Microsoft.SharePoint.WebControls" xmlns:ddwrt2="urn:frontpage:internal">
<xsl:output method="html" indent="no"/>

<xsl:param name="ListTitle"></xsl:param>

<xsl:template match="/" xmlns:x="http://www.w3.org/2001/XMLSchema" xmlns:d="http://schemas.microsoft.com/sharepoint/dsp" xmlns:asp="http://schemas.microsoft.com/ASPNET/20" xmlns:__designer="http://schemas.microsoft.com/WebParts/v2/DataView/designer" xmlns:SharePoint="Microsoft.SharePoint.WebControls">

<div class="faqMain">
	<h2 class="volpe"><xsl:value-of select="$ListTitle"/></h2>

<div class="mainInner">
	<table class="surviceDir">
		<tr>
			<th rowspan="2">Category</th>
			<th rowspan="2">Service</th>
			<th colspan="2">Primary Contact</th>
			<th rowspan="2">HR Division</th>
			<th rowspan="2">Link</th>				
	</tr>
	<tr>
		<th colspan="2">Backup Contact</th>
	</tr>
		<xsl:apply-templates /> 
	</table>
	
</div>	
</div>

</xsl:template>

<xsl:template match="/dsQueryResponse/Rows/Row">
	<xsl:variable name="css-class">
    <xsl:choose>
      <xsl:when test="position() mod 2 = 0">even</xsl:when>
      <xsl:otherwise>odd</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <tr class="{$css-class}">
		<td rowspan="2" class="data2"><xsl:value-of select="substring-after(@Category., '#')" /></td>
		<td rowspan="2" class="data1"><xsl:value-of select="@Title"/></td>
		

		<td class="data3"><a href="mailto:{@Lead_x003a_email}"><xsl:value-of select="@Lead_x003a_First_x0020_Name" /><xsl:text xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" ddwrt:whitespace-preserve="yes" xml:space="preserve"> </xsl:text><xsl:value-of select="@Lead_x003a_Last_x0020_Name" /></a></td><td>Ext: <xsl:value-of select="@Lead_x003a_Extension"/></td>
		
		<td rowspan="2" class="data4"><xsl:value-of select="substring-after(@Division., '#')"/></td>
		<td rowspan="2" class="data5">		
			<xsl:if test="@URL!=''">
				<a href="{@URL}"><img src="http://spmain.volpe.dot.gov/sites/Tools/HumanResources/Site%20Assets/link-external.png" /></a>
			</xsl:if>
		</td>
	</tr>
	<tr class="{$css-class}">
		<td class="data6"><a href="mailto:{@Back_x002d_up_x003a_email}"><xsl:value-of select="@Back_x002d_up_x003a_First_x0020_" />
				<xsl:text xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" ddwrt:whitespace-preserve="yes" xml:space="preserve"> </xsl:text>
				<xsl:value-of select="@Back_x002d_up_x003a_Last_x0020_N" /></a></td><td>Ext: <xsl:value-of select="@Back_x002d_up_x003a_Extension" /></td>
	</tr>
		
</xsl:template>

</xsl:stylesheet>




