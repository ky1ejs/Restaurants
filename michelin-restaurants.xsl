<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<html> 

<head>
	<title>Restaurants</title>
	<meta name="viewport" content="width=device-width, initial-scale=1"></meta>
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"></link>
	<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script> 
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>

<body> 
	<div data-role="page" id="home">

		<div data-role="header">
			<h1>Restaurants</h1>
		</div>

		<div role="main" class="ui-content">

			<ul data-role="listview" data-filter="true">
				<xsl:for-each select="michelin-restaurants/restaurant"> 
					<li>
						<a data-transition="slide">
							<xsl:attribute name="href">
								#<xsl:value-of select="id"/>
							</xsl:attribute>
							<img>
								<xsl:attribute name="src">
									<xsl:value-of select="picture-tile"/>
								</xsl:attribute>
							</img>
							<h3><xsl:value-of select="name"/></h3>
							<p><xsl:value-of select="short-description"/></p>
						</a>
					</li>
				</xsl:for-each> 
			</ul>

		</div>

		<div data-role="footer" data-id="thefooter" data-position="fixed">
			<div data-role="navbar" data-iconpos="bottom">
				<ul>
					<li><a href="#" data-icon="grid">Summary</a></li>
					<li><a href="#" data-icon="star" class="ui-btn-active">Favs</a></li>
					<li><a href="#" data-icon="gear">Setup</a></li>
				</ul>
			</div>
		</div>

	</div>

	<xsl:for-each select="michelin-restaurants/restaurant">
		<div data-role="page">
			<xsl:attribute name="id">
				<xsl:value-of select="id"/>
			</xsl:attribute>

			<div data-role="header" data-add-back-btn="true" data-direction="reverse">
				<h1><xsl:value-of select="name" /></h1>
			</div>

			<div role="main" class="ui-content">
				<xsl:value-of select="long-description" />
			</div>

		</div>
	</xsl:for-each>

</body> 
</html> 

</xsl:template>

</xsl:stylesheet>