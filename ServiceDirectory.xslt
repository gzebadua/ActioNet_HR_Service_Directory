<xsl:stylesheet xmlns:x="http://www.w3.org/2001/XMLSchema" xmlns:d="http://schemas.microsoft.com/sharepoint/dsp"
    version="1.0" exclude-result-prefixes="xsl msxsl ddwrt" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime"
    xmlns:asp="http://schemas.microsoft.com/ASPNET/20" xmlns:__designer="http://schemas.microsoft.com/WebParts/v2/DataView/designer"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:sharepoint="Microsoft.SharePoint.WebControls" xmlns:ddwrt2="urn:frontpage:internal"
    xmlns:o="urn:schemas-microsoft-com:office:office" ddwrt:ghost="show_all">
  <xsl:include href="/_layouts/xsl/main.xsl" />
  <xsl:include href="/_layouts/xsl/internal.xsl" />
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
  <xsl:output method='html' indent='yes' />
  
  <xsl:template match="/" xmlns:x="http://www.w3.org/2001/XMLSchema" xmlns:d="http://schemas.microsoft.com/sharepoint/dsp"
       xmlns:asp="http://schemas.microsoft.com/ASPNET/20" xmlns:__designer="http://schemas.microsoft.com/WebParts/v2/DataView/designer"
       xmlns:sharepoint="Microsoft.SharePoint.WebControls" xmlns:o="urn:schemas-microsoft-com:office:office"
       ddwrt:ghost="" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime">
    
    <xsl:param name="ListTitle" />
    
    <xsl:variable name="Rows" select="/dsQueryResponse/Rows/Row[$EntityName = '' or (position() &gt;= $FirstRow and position() &lt;= $LastRow)]" />
    
    <div class="faqMain">
      <h2 class="volpe">
        <xsl:value-of select="$ListTitle"/>
      </h2>

      <div class="mainInner">
        <table class="surviceDir">
          <tr>
            <th rowspan="2">Program</th>
            <th rowspan="2">Service</th>
            <th colspan="2">Primary Contact</th>
            <th rowspan="2">HR Division</th>
            <th rowspan="2">Link</th>
          </tr>
          <tr>
            <th colspan="2">Backup Contact</th>
          </tr>
          <xsl:for-each select="$Rows">
          	<xsl:call-template name="RowView">
            </xsl:call-template>
          </xsl:for-each>
          <tr>
            <td colspan="6">
              <xsl:call-template name="pagingButtons" />
            </td>
          </tr>
        </table>

      </div>
    </div>
    
  </xsl:template>

  <xsl:template name="RowView">
  	
    <xsl:variable name="thisNode" select="." />
    <xsl:variable name="css-class">
      <xsl:choose>
        <xsl:when test="position() mod 2 = 0">even</xsl:when>
        <xsl:otherwise>odd</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tr class="{$css-class}">
      <td rowspan="2" class="data2">
        <xsl:value-of select="substring-after(@Category., '#')" />
      </td>
      <td rowspan="2" class="data1">
        <xsl:value-of select="@Title"/>
      </td>
      <td class="data3">
        <a href="mailto:{@Lead_x003a_email}">
          <xsl:value-of select="@Lead_x003a_First_x0020_Name" />
          <xsl:text xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" ddwrt:whitespace-preserve="yes" xml:space="preserve"> </xsl:text>
          <xsl:value-of select="@Lead_x003a_Last_x0020_Name" />
        </a>
      </td>
      <td>
        Ext: <xsl:value-of select="@Lead_x003a_Extension"/>
      </td>

      <td rowspan="2" class="data4">
        <xsl:value-of select="substring-after(@Division., '#')"/>
      </td>
      <td rowspan="2" class="data5">
        <xsl:if test="@URL!=''">
          <a href="{@URL}">
            <img src="http://spmain.volpe.dot.gov/sites/Tools/HumanResources/Site%20Assets/link-external.png" />
          </a>
        </xsl:if>
      </td>
    </tr>
    <tr class="{$css-class}">
      <td class="data6">
        <a href="mailto:{@Back_x002d_up_x003a_email}">
          <xsl:value-of select="@Back_x002d_up_x003a_First_x0020_" />
          <xsl:text xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" ddwrt:whitespace-preserve="yes" xml:space="preserve"> </xsl:text>
          <xsl:value-of select="@Back_x002d_up_x003a_Last_x0020_N" />
        </a>
      </td>
      <td>
        Ext: <xsl:value-of select="@Back_x002d_up_x003a_Extension" />
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="pagingButtons">
    <xsl:choose>
      <xsl:when test="$XmlDefinition/List/@TemplateType = 106 and $XmlDefinition/@RecurrenceRowset='TRUE'">
        <xsl:if test="$dvt_nextpagedata or $dvt_prevpagedata">
          <xsl:call-template name="CalendarExpandedRecurrenceFooter"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$XmlDefinition/RowLimit[@Paged='TRUE']">
          <xsl:call-template name="CommandFooter">
            <xsl:with-param name="FirstRow" select="$FirstRow" />
            <xsl:with-param name="LastRow" select="$LastRow" />
            <xsl:with-param name="dvt_RowCount" select="$dvt_RowCount" />
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="CommandFooter">
    <xsl:param name="FirstRow" select="1"/>
    <xsl:param name="LastRow" select="1"/>
    <xsl:param name="dvt_RowCount" select="1"/>
    <xsl:if test="$FirstRow &gt; 1 or $dvt_nextpagedata">
      <xsl:call-template name="Navigation">
        <xsl:with-param name="FirstRow" select="$FirstRow" />
        <xsl:with-param name="LastRow" select="$LastRow" />
        <xsl:with-param name="dvt_RowCount" select="$dvt_RowCount" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="Navigation">
    <xsl:param name="FirstRow" select="1"/>
    <xsl:param name="LastRow" select="1"/>
    <xsl:param name="dvt_RowCount" select="1"/>
    <xsl:variable name="LastRowValue">
      <xsl:choose>
        <xsl:when test="$EntityName = '' or $LastRow &lt; $RowTotalCount">
          <xsl:value-of select="$LastRow"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$RowTotalCount"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="NextRow">
      <xsl:value-of select="$LastRowValue + 1"/>
    </xsl:variable>
    <table id="bottomPagingCell{$WPQ}" style="font-size:25px;width:100%;padding:5px;" border="0">
      <tr>
        <td style="width:50%">
          <xsl:if test="$dvt_firstrow &gt; 1">
            <a>
              <xsl:choose>
                <xsl:when test="$dvt_RowCount = 0 and not($NoAJAX)">
                  <xsl:attribute name="onclick">
                    javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$ShowWebPart"/>\u0026<xsl:value-of select='$FieldSortParam'/><xsl:value-of select='$SortQueryString'/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;
                  </xsl:attribute>
                  <xsl:attribute name="href">javascript:</xsl:attribute>
                  <img src="/_layouts/{$LCID}/images/prev.gif" border="0" alt="{$Rows/@idRewind}" />
                  <img src="/_layouts/{$LCID}/images/prev.gif" border="0" alt="{$Rows/@idRewind}" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="RealRowLimit">
                    <xsl:choose>
                      <xsl:when test="$XmlDefinition/Query/GroupBy[@Collapse='TRUE']/@GroupLimit">
                        <xsl:value-of select ="$XmlDefinition/Query/GroupBy[@Collapse='TRUE']/@GroupLimit"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select = "$XmlDefinition/RowLimit"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <xsl:choose>
                    <xsl:when test="not($NoAJAX)">
                      <xsl:attribute name="onclick">
                        javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$dvt_prevpagedata"/><xsl:value-of select="$ShowWebPart"/>\u0026PageFirstRow=<xsl:value-of select="$FirstRow - $RealRowLimit"/>\u0026<xsl:value-of select='$FieldSortParam'/><xsl:value-of select='$SortQueryString'/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;
                      </xsl:attribute>
                      <xsl:attribute name="href">javascript:</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="href">
                        javascript: <xsl:call-template name="GenFireServerEvent">
                          <xsl:with-param name="param" select="concat('dvt_firstrow={',$FirstRow - $XmlDefinition/RowLimit,'};dvt_startposition={',$dvt_prevpagedata,'}')"/>
                        </xsl:call-template>
                      </xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>
                  <img src="/_layouts/{$LCID}/images/prev.gif" border="0" alt="{$Rows/@idPrevious}" />Previous
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </xsl:if>
        </td>

        <td style="width:50%" align="right">
          <xsl:if test="$LastRowValue &lt; $dvt_RowCount or string-length($dvt_nextpagedata)!=0">

            <a>
              <xsl:choose>
                <xsl:when test="not($NoAJAX)">
                  <xsl:attribute name="onclick">
                    javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$dvt_nextpagedata"/><xsl:value-of select="$ShowWebPart"/>\u0026PageFirstRow=<xsl:value-of select="$NextRow"/>\u0026<xsl:value-of select='$FieldSortParam'/><xsl:value-of select='$SortQueryString'/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;
                  </xsl:attribute>
                  <xsl:attribute name="href">javascript:</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="href">
                    javascript: <xsl:call-template name="GenFireServerEvent">
                      <xsl:with-param name="param" select="concat('dvt_firstrow={',$NextRow,'};dvt_startposition={',$dvt_nextpagedata,'}')"/>
                    </xsl:call-template>
                  </xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
              Next<img src="/_layouts/{$LCID}/images/next.gif" border="0" alt="{$Rows/@tb_nextpage}" />
            </a>
          </xsl:if>
        </td>
      </tr>
    </table>

    <xsl:if test="not($GroupingRender)">
      <script>
        var topPagingCell = document.getElementById(&quot;topPagingCell<xsl:value-of select="$WPQ" />&quot;);
        var bottomPagingCell = document.getElementById(&quot;bottomPagingCell<xsl:value-of select="$WPQ" />&quot;);
        if (topPagingCell != null &amp;&amp; bottomPagingCell != null)
        {
        topPagingCell.innerHTML = bottomPagingCell.innerHTML;
        }
      </script>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>