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
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;signed_in=true"></script>

	<script type="text/javascript">

		var mainMap;
		var mainMapMarkers = new Array();

		function fitMarkersOnMainMap() {
			var bounds = new google.maps.LatLngBounds();

			mainMapMarkers.forEach(function(entry) {
				bounds.extend(entry.getPosition());
			});

			mainMap.fitBounds(bounds);
		}

		$(document).on("pageshow", "#map-page", function(event) {
			var options = {
				center: new google.maps.LatLng(51.508742,-0.120850),
				zoom: 13,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			};

			mainMap = new google.maps.Map($(event.target).find('#map').get(0), options);

			<xsl:for-each select="michelin-restaurants/restaurant">
				var restLocation = new google.maps.LatLng(
					<xsl:value-of select="location/longitude"/>,
					<xsl:value-of select="location/latitude"/>
				);

				var marker = new google.maps.Marker({
				    position: restLocation,
				    map: mainMap,
				    clickable: true,
				});

				mainMapMarkers.push(marker);

				var info = new google.maps.InfoWindow({
			       content: "<xsl:value-of select="name"/>"
			    });

			    info.open(mainMap, marker);

			    google.maps.event.addListener(marker, "click", function(e) {
					$.mobile.changePage("#" + "<xsl:value-of select="id"/>", {
						transition: "slide"
					});
			    });
			</xsl:for-each>

			fitMarkersOnMainMap();
		});

		function findUsersLocation() {
			navigator.geolocation.getCurrentPosition(function(position) {
				<!-- handle no geoLocation available -->
				userLocation = new google.maps.LatLng(
					position.coords.latitude,
					position.coords.longitude
				);

				var marker = new google.maps.Marker({
				    position: userLocation,
				    map: mainMap,
				});

				mainMapMarkers.push(marker);

				var info = new google.maps.InfoWindow({
			       content: "<b>YOU ARE HERE</b>"
			    });

				info.open(mainMap, marker);

			    google.maps.event.addListener(marker, "click", function(e) {
					info.open(mainMap, marker);
			    });

				fitMarkersOnMainMap();

			});
		}

		<!-- Maps for each page -->
		<xsl:for-each select="michelin-restaurants/restaurant">

			$(document).on("pageshow", "#" + "<xsl:value-of select="id"/>", function(event) {
				var latLng = new google.maps.LatLng(
					<xsl:value-of select="location/longitude"/>,
					<xsl:value-of select="location/latitude"/>
				);

				var options = {
					center: latLng,
					zoom: 15,
					mapTypeId: google.maps.MapTypeId.ROADMAP
				};

				var map = new google.maps.Map($(event.target).find('#map').get(0), options);

				var marker = new google.maps.Marker({
				    position: latLng,
				    map: map,
				    clickable: true,
				});

				var info = new google.maps.InfoWindow({
			       content: "<xsl:value-of select="name"/>"
			    });

			    info.open(map, marker);

			    google.maps.event.addListener(marker, "click", function (e) { info.open(map, marker); });

			});
		</xsl:for-each>

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
		<div data-role="page" class="map-page-container">
			<xsl:attribute name="id">
				<xsl:value-of select="id"/>
			</xsl:attribute>

			<div data-role="header" data-add-back-btn="true" data-direction="reverse">
				<h1><xsl:value-of select="name" /></h1>
			</div>

			<div role="main" class="ui-content">
				<div class="wrapper">
					<div class="rest-description">
						<xsl:value-of select="long-description" />
					</div>
					<div class="map-container">
						<div id="map"></div>
					</div>
				</div>
			</div>

		</div>
	</xsl:for-each>

	<div data-role="page" class="map-page-container" id="map-page">
		<div data-role="header" data-position="fixed">
			<h1>Map</h1>
			<a href="#" onclick="findUsersLocation()" data-icon="gear" class="ui-btn-right">Current location</a>
		</div>

		<div role="main" class="ui-content">
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