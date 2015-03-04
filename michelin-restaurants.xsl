<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<html> 

<head>
	<title>Restaurants</title>

	<meta name="viewport" content="width=device-width, initial-scale=1"></meta>

	<link rel="stylesheet" href="style.css" />

	<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"></link>
	<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
	<script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

	<script>


		<!-- Map page -->
		var loaded = false;

		function setupMap() {
			loaded = true;
			var options = {
				center:new google.maps.LatLng(51.508742,-0.120850),
				zoom:5,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			};
		    var map = new google.maps.Map(document.getElementById('map'), options);
		}

		function loadScript() {
			if (!loaded) {
				var script = document.createElement('script');
				script.type = 'text/javascript';
				script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp' + '&amp;signed_in=true&amp;callback=setupMap';
				document.body.appendChild(script);
			}
		}

		$(document).on("pageshow", "#map-page", loadScript);

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

		<div data-role="footer" data-id="f1" data-position="fixed" data-theme="a">
			<div data-role="navbar" data-iconpos="bottom">
				<ul>
					<li><a href="#home" data-icon="grid" class="ui-btn-active ui-state-persist">Restaurants</a></li>
					<li><a href="#map-page" data-transition="fade" data-icon="star">Map</a></li>
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

	<div data-role="page" id="map-page" onload="initialize()">

		<div data-role="header" data-position="fixed">
			<h1>Map</h1>
		</div>

		<div role="main" class="ui-content" data-fullscreen="true">
			<div id="map"></div>
		</div>

		<div data-role="footer" data-id="f1" data-position="fixed" data-theme="a">
			<div data-role="navbar" data-iconpos="bottom">
				<ul>
					<li><a href="#home" data-transition="fade" data-icon="grid">Restaurants</a></li>
					<li><a href="#map-page" data-icon="star" class="ui-btn-active ui-state-persist">Map</a></li>
				</ul>
			</div>
		</div>

	</div>

</body> 
</html> 

</xsl:template>

</xsl:stylesheet>