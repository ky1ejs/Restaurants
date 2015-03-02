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
	<div data-role="page">

		<div data-role="header">
		</div>

		<div role="main" class="ui-content">

			<ul data-role="listview" data-inset="true">
				<xsl:for-each select="michelin-restaurants/restaurant"> 
					<li>
						<xsl:value-of select="name"/>
						<img>
							<xsl:attribute name="src">
								<xsl:value-of select="pictures/picture"/>
							</xsl:attribute>
						</img>
					</li>
				</xsl:for-each> 
			</ul>

		</div>

		<div data-role="footer">
		</div>

	</div>  
</body> 
</html> 

</xsl:template>

</xsl:stylesheet>