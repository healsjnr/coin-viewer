var map;
var infowindow = null;

var currentLocation = new google.maps.LatLng(51.543, -1.1649);

function initialize() {

  $('#coin-data-form').submit(function( event ) {
    getContent()
    event.preventDefault();
  });

  var mapOptions = {
    center: currentLocation,
    zoom: 12
  };

  map = new google.maps.Map($('#map-canvas').get(0), mapOptions);
  infowindow = new google.maps.InfoWindow();
}

function getContent() {
  var url = 'coins/default';
  $.get(url, function populate_data(resp) {
    coin_data = JSON.parse(resp);
    plotCoins(coin_data);
  });
}

function createInfoString(coin) {
  var infoString = "<div>" + 
    "<table>" +
    "<tr><td>Findsport</td><td>" + coin.findspot + "</td></tr>" +
    "<tr><td>ABC Type</td><td>" + coin.abtype + "</td></tr>" +
    "<tr><td>Allen</td><td>" + coin.allen + "</td></tr>" +
    //"<tr><td>CCI/PAS ID</td><td>" + coin + "</td></tr>" +
    "<tr><td>Wt</td><td>" + coin.wt + "</td></tr>" +
    "</table>" +
    "</div>";
  return infoString
}

function plotCoins(coin_data) {
  var markers = [];
  for(var i in coin_data) {
    var coin = coin_data[i];

    var infoString = createInfoString(coin);
    var lat = coin.lat;
    var lon = coin.long;
    if (lat === null || lon === null) { continue; }
    var latLng = new google.maps.LatLng(lat, lon);
    var marker = new google.maps.Marker({
      position: latLng,
      label: coin.allen,
      title: coin.findspot + "(" + coin.abctype + "/" + coin.allen + ")",
      html: infoString
    });

    marker.addListener('click', function() {
      infowindow.setContent(this.html);
      infowindow.open(map, this);
    });
    
    markers.push(marker);
  }
  var markerCluser = new MarkerClusterer(map, markers);
}

google.maps.event.addDomListener(window, 'load', initialize)
