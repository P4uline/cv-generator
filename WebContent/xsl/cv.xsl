<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <!-- margins of the sheet-->
    <xsl:variable name="margin-left" select="number('1')"/>
    <xsl:variable name="margin-right" select="number('1')"/>
    <xsl:variable name="margin-top" select="number('1')"/>
    <xsl:variable name="width-body" select="21-$margin-right - $margin-left"/>
    <!-- table variables -->
    <xsl:variable name="default-empty-row-height" select="number('0.5')"/>
    <xsl:variable name="default-padding-cell" select="number('0.1')"/>
    <xsl:variable name="default-margin-table" select="number('0.1')"/>
    <xsl:variable name="fichier-configuration" select="document('../xml/cv.xml')"/>
    <xsl:template match="/">
        <fo:root>
            <xsl:call-template name="layoutMaster"/>
            <fo:page-sequence master-reference="page-portrait">
                <fo:static-content flow-name="entete-page-blanche">
                    <fo:block margin-top="9cm">Cette page est blanche</fo:block>
                </fo:static-content>
                <fo:static-content flow-name="bas-de-page">
                    <xsl:call-template name="bas-de-page"/>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" font-family="frutiger" font-size="10pt" color="rgb(88,88,88)">
                    <!-- head table -->
                    <xsl:call-template name="emptyTable"/>
                    <xsl:call-template name="candidat"/>
                    <xsl:call-template name="emptyTable"/>
                    <xsl:call-template name="title"/>
                    <xsl:call-template name="emptyTable"/>
                    <xsl:call-template name="presentation"/>
                    <xsl:call-template name="emptyTable"/>
                    <xsl:call-template name="skills"/>
                    <xsl:call-template name="emptyTable"/>
                    <xsl:call-template name="hobbies"/>
                    <xsl:call-template name="emptyTable"/>
                    <xsl:call-template name="experiences"/>
                    <xsl:call-template name="emptyTable"/>
                    <xsl:call-template name="education"/>
                    <fo:block id="last-block"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <!-- ****************************************************************************************************
        ***************** Template de présenation des données                   *****************************
        *********************************************************************************************************-->
    <!-- Résolution des références -->
    <xsl:template match="* | @*">
        <xsl:apply-templates select="*|text()|@*"/>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="@id">
        <xsl:text>ceci est du texte</xsl:text>
    </xsl:template>

    <xsl:template match="*[@reference]">
        <xsl:variable name="reference" select="./@reference"/>
        <xsl:apply-templates select="//*[@id=$reference]"/>
    </xsl:template>

    <xsl:decimal-format name="onf" decimal-separator="," grouping-separator=" "/>
    <xsl:template match="nombre">
        <xsl:value-of select="format-number(number(.),' ###,00','onf')"/>
    </xsl:template>

    <!-- ****************************************************************************************************
        ***************** Template nommé de définition des pages et feuilles *****************************
        *********************************************************************************************************-->
    <xsl:template name="layoutMaster">
        <xsl:variable name="TailleBasDePage">1cm</xsl:variable>
        <fo:layout-master-set>
            <fo:simple-page-master master-name="portrait" page-height="29.7cm" page-width="21cm"
                margin-top="{$margin-top}cm" margin-bottom="0cm" margin-left="{$margin-left}cm"
                margin-right="{$margin-right}cm" reference-orientation="0">
                <fo:region-body margin-top="0cm" margin-bottom="{$TailleBasDePage}"
                    background-repeat="no-repeat" background-color="white">
                </fo:region-body>
                <fo:region-after region-name="bas-de-page" extent="{$TailleBasDePage}"
                    precedence="true"/>
            </fo:simple-page-master>
            <fo:simple-page-master master-name="page-blanche" page-height="29.7cm" page-width="21cm">
                <fo:region-body/>
                <fo:region-before region-name="entete-page-blanche" extent="10cm" precedence="true"/>
                <fo:region-after region-name="bas-de-page" extent="1cm" precedence="true"/>
            </fo:simple-page-master>
            <fo:page-sequence-master master-name="page-portrait">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="page-blanche"
                        blank-or-not-blank="blank"/>
                    <fo:conditional-page-master-reference master-reference="portrait"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>
        </fo:layout-master-set>
    </xsl:template>

    <xsl:template name="emptyTable">
        <fo:block>
            <fo:table table-layout="fixed" width="{$width-body}cm">
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell padding-top="{$default-empty-row-height}cm">
                            <fo:block/>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="emptyLine">
    	<fo:block padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px"><xsl:text> </xsl:text></fo:block>
    </xsl:template>
    
    <xsl:template name="candidat">
        <fo:block text-align="left"
                  display-align="auto"
                  padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px"
                  border-collapse="separate"
                  font-size="{normalize-space($fichier-configuration/cv/parameters/taillePolice/medium)}pt">
        	<fo:block><xsl:value-of select="normalize-space($fichier-configuration/cv/candidat/name)"/></fo:block>
        	<fo:block><xsl:value-of select="normalize-space($fichier-configuration/cv/candidat/address)"/></fo:block>
        	<fo:block><xsl:value-of select="normalize-space($fichier-configuration/cv/candidat/email)"/></fo:block>
        	<fo:block><xsl:value-of select="normalize-space($fichier-configuration/cv/candidat/twitter)"/></fo:block>
        	<fo:block><xsl:value-of select="normalize-space($fichier-configuration/cv/candidat/tel)"/></fo:block>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="title">
        <fo:block text-align="left"
               padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px"
               border-collapse="separate"
               font-size="{normalize-space($fichier-configuration/cv/parameters/taillePolice/big)}pt"
               font-weight="bold">
        	<fo:inline text-transform="uppercase"><xsl:value-of select="./cv/title"/></fo:inline>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="presentation">
    	<fo:block>
            <fo:table table-layout="fixed" width="{$width-body}cm" 
            	background-color="{normalize-space($fichier-configuration/cv/parameters/colors/studies)}">
            	<fo:table-column column-width="19cm"/>
                <fo:table-body>
                	<fo:table-row font-size="10px">
				        <fo:table-cell text-align="left"
				            display-align="auto"
				            padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
				            <fo:block>
	                    		<xsl:value-of select="./cv/presentation/content"/>
				            </fo:block>
				        </fo:table-cell>
			        </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="skills">
    	<fo:block font-size="20px"><xsl:value-of select="./cv/skillsTechnical/title"/></fo:block>
    	<fo:block>
            <fo:table table-layout="fixed" width="{$width-body}cm"  
            	border-color="{normalize-space($fichier-configuration/cv/parameters/colors/skills)}"
            	background-color="{normalize-space($fichier-configuration/cv/parameters/colors/skills)}">
            	<fo:table-column column-width="6cm"/>
                <fo:table-column column-width="13cm"/>
                <fo:table-body>
                    <xsl:apply-templates select="./cv/skillsTechnical/content"/>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <!-- 
        <xsl:call-template name="emptyTable"/>
        <fo:block font-size="20px"><xsl:value-of select="./cv/skillsTheorical/title"/></fo:block>
    	<fo:table table-layout="fixed" width="{$width-body}cm"  border-color="{normalize-space($fichier-configuration/cv/parameters/colors/skills)}">
            <fo:table-body>
    			<xsl:apply-templates select="./cv/skillsTheorical/skill-th-container/skill-th"/>
    		</fo:table-body>
    	</fo:table>
    	 -->
    </xsl:template>
    
    <xsl:template match="content">
    	<xsl:param name="hobbies"/>
    	<fo:table-row font-size="10px">
	        <fo:table-cell text-align="left"
	            display-align="auto"
	            font-weight="bold"
	            padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
	            <fo:block><xsl:value-of select="normalize-space(./category)"/></fo:block>
	        </fo:table-cell>
	        <fo:table-cell text-align="left"
	            display-align="auto"
	            padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
         		<fo:block>
     				<xsl:apply-templates select="./value">
     					<xsl:with-param name="hobbies" select="$hobbies"/>
     				</xsl:apply-templates>
         		</fo:block>
	        </fo:table-cell>
		</fo:table-row>
    </xsl:template>
    
    <xsl:template match="skill-th">
    	<fo:table-row background-color="{normalize-space($fichier-configuration/cv/parameters/colors/skills)}" font-size="10px">
	        <fo:table-cell text-align="left" display-align="auto"
	            		   padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
	            <fo:block><xsl:value-of select="."/></fo:block>
	        </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template name="hobbies">
    	<fo:block font-size="20px"><xsl:value-of select="./cv/hobbies/title"/></fo:block>
    	<fo:block>
            <fo:table table-layout="fixed" width="{$width-body}cm" 
            	background-color="{normalize-space($fichier-configuration/cv/parameters/colors/hobbies)}">
            	<fo:table-column column-width="6cm"/>
                <fo:table-column column-width="13cm"/>
                <fo:table-body>
                    <xsl:apply-templates select="./cv/hobbies/content">
                    	<xsl:with-param name="hobbies" select="'hob'"/>
                    </xsl:apply-templates>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="experiences">
    	<fo:block font-size="20px" keep-with-next="always" padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
    		<xsl:value-of select="./cv/experiences/title"/>
    	</fo:block>
        <xsl:apply-templates select="./cv/experiences/experience"/>
    </xsl:template>
    
    <xsl:template match="experience">
    	<fo:block keep-together="always" keep-together.within-line="0">
    	<fo:table table-layout="fixed" width="{$width-body}cm" 
            	background-color="{normalize-space($fichier-configuration/cv/parameters/colors/exp)}">
            <fo:table-column column-width="5cm"/>
            <fo:table-column column-width="10cm"/>
            <fo:table-column column-width="4cm"/>
	    	<fo:table-body>
		    	<fo:table-row font-size="11px" font-weight="bold" keep-with-next="always">
		    		<fo:table-cell padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
		    			<fo:block>
		    				<xsl:value-of select="duration/from"/><xsl:text> </xsl:text><xsl:value-of select="duration/to"/>
		    			</fo:block>
		    		</fo:table-cell>
		    		<fo:table-cell padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px"><fo:block><xsl:value-of select="what"/></fo:block></fo:table-cell>
		    		<fo:table-cell padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px" text-align-last="center"><fo:block><xsl:value-of select="where"/></fo:block></fo:table-cell>
		    	</fo:table-row>
		    	<fo:table-row>
		    		<fo:table-cell number-columns-spanned="3" padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
		    			<fo:block><xsl:apply-templates select="presentation"/></fo:block>
		    		</fo:table-cell>
		    	</fo:table-row>
		    	<xsl:if test="tasks/task">
			    	<fo:table-row>
			    		<fo:table-cell number-columns-spanned="3" padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px"
			    					   display-align="center">
			    			<fo:table background-color="{normalize-space($fichier-configuration/cv/parameters/colors/exp-tasks)}" keep-together="always">
			    				<fo:table-body>
			    					<xsl:apply-templates select="tasks/task"/>
			    				</fo:table-body>
			    			</fo:table>
			    		</fo:table-cell>
			    	</fo:table-row>
		    	</xsl:if>
		    	<xsl:if test="skills/value">
			    	<fo:table-row>
			    		<fo:table-cell number-columns-spanned="3"
			    						padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
			    			<fo:block font-weight="bold">
			    				<fo:block><xsl:text>Environnement technique : </xsl:text></fo:block>
			    				<xsl:apply-templates select="skills/value"/>
			    			</fo:block>
			    		</fo:table-cell>
			    	</fo:table-row>
		    	</xsl:if>
    		</fo:table-body>
    	</fo:table>
    	</fo:block>
    	<xsl:call-template name="emptyTable"/>
    </xsl:template>
    
    <xsl:template match="presentation">
    	<fo:block><xsl:value-of select="current()"/></fo:block>
    	<xsl:if test="not(position()=last())">
    		<xsl:call-template name="emptyLine"/>
    	</xsl:if>
    </xsl:template>
    
    <xsl:template match="task">
    	<fo:table-row>
    		<fo:table-cell padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
    			<fo:block><xsl:value-of select="."/></fo:block>
    		</fo:table-cell>
    	</fo:table-row>
    </xsl:template>
    
    <xsl:template name="education">
    	<fo:block font-size="20px" keep-with-next="always" padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px">
    		<xsl:value-of select="./cv/education/title" />
    	</fo:block>
    	<xsl:apply-templates select="./cv/education/education-content"/>
    </xsl:template>
    
    <xsl:template match="education-content">
    	<fo:table width="{$width-body}cm"
    				padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px"
    				background-color="{normalize-space($fichier-configuration/cv/parameters/colors/studies)}">
    		<fo:table-body>
    			<fo:table-row><fo:table-cell padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px"><fo:block font-size="15px" keep-with-next="always"><xsl:value-of select="title" /></fo:block></fo:table-cell></fo:table-row>
    			<fo:table-row><fo:table-cell><xsl:call-template name="emptyLine"/></fo:table-cell></fo:table-row>
    			<fo:table-row><fo:table-cell>
		    		<fo:table table-layout="fixed" width="{$width-body}cm">
		    			<fo:table-column column-width="2cm"/>
			    		<fo:table-column column-width="17cm"/>
			    		<fo:table-body>
			    			<xsl:apply-templates select="education-unit"/>
			    		</fo:table-body>
		    		</fo:table>
    			</fo:table-cell></fo:table-row>
    		</fo:table-body>
    	</fo:table>
    	<xsl:call-template name="emptyTable"/>
    </xsl:template>
    
    <xsl:template match="education-unit">
    	<fo:table-row>
    		<fo:table-cell padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px"><fo:block><xsl:value-of select="when"/></fo:block></fo:table-cell>
    		<fo:table-cell padding-top="5px" padding-left="10px" padding-right="10px" padding-bottom="5px"><fo:block><xsl:value-of select="what"/></fo:block></fo:table-cell>
    	</fo:table-row>
    </xsl:template>
    
    <xsl:template match="value">
    	<xsl:param name="hobbies"/>
    	<xsl:choose>
    		<xsl:when test="$hobbies = 'hob'">
    			<fo:block><xsl:value-of select="."/></fo:block>
    		</xsl:when>
    		<xsl:otherwise>
    			<xsl:value-of select="current()"/>
    			<xsl:if test="not(position()=last())">
					<xsl:text> - </xsl:text>
				</xsl:if>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

    <xsl:template name="bas-de-page">
        <fo:block font-family="Arial"
            font-size="{normalize-space($fichier-configuration/cv/parameters/taillePolice/medium)}pt">
            <fo:table table-layout="fixed" width="{$width-body}cm"
                border-top="{normalize-space($fichier-configuration/cv/parameters/bordureTableau)}"
                border-collapse="separate">
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                <fo:inline><xsl:value-of select="normalize-space($fichier-configuration/cv/name)"/></fo:inline>
                                <fo:inline><xsl:value-of select="normalize-space($fichier-configuration/cv/email)"/></fo:inline>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align-last="right">
                            <fo:block>
                                <fo:inline>
                                    <fo:page-number/>/<fo:page-number-citation ref-id="last-block"/></fo:inline>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>
