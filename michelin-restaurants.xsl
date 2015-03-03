<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<html> 

<head>
	<title>Restaurants</title>

	<meta name="viewport" content="width=device-width, initial-scale=1"></meta>

	<link rel="stylesheet" href="style.css" />

	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"></link>
	<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script> 
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

	<script src="http://maps.googleapis.com/maps/api/js"></script>
	<script>
		function initialize() {
		  var mapProp = {
		    center:new google.maps.LatLng(51.508742,-0.120850),
		    zoom:5,
		    mapTypeId:google.maps.MapTypeId.ROADMAP
		  };
		  var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
		}
		google.maps.event.addDomListener(window, 'load', initialize);
	</script>
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
					<li><a href="#home" data-icon="grid" class="ui-btn-active">Restaurants</a></li>
					<li><a href="#map" data-icon="star" >Map</a></li>
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

	<div data-role="page" id="map" data-fullscreen="true">

		<div data-role="header" data-position="fixed">
			<h1>Map</h1>
		</div>

		<div role="main" class="ui-content" data-fullscreen="true">
			<div id="googleMap"></div>
		</div>

		<div data-role="footer" data-id="thefooter" data-position="fixed">
			<div data-role="navbar" data-iconpos="bottom">
				<ul>
					<li><a href="#home" data-icon="grid" class="ui-btn-active">Restaurants</a></li>
					<li><a href="#map" data-icon="star" >Map</a></li>
					<li><a href="#" data-icon="gear">Setup</a></li>
				</ul>
			</div>
		</div>

	</div>

</body> 
</html> 

</xsl:template>

</xsl:stylesheet>