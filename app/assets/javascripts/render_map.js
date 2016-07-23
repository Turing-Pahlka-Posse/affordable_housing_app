$(document).ready(function () {
  renderBaseMap();
  //renderMarkersLayer is defined in renderAddresses.js
  //utilizes ajax to "GET" the three addresses and
  //createMarkers using said three addresses
  renderMarkersLayer();
  toggleNeighborhoods();
  findNeighborhoods();
});

//adding the base styling layer that July chose
function renderBaseMap() {
  var baseLayer = L.mapbox.styleLayer('mapbox://styles/julyytran/ciohh5muy0010bpneqm1tg1ij').addTo(map);
}


function toggleNeighborhoods() {
  var neighborhoodsLayer = L.mapbox.featureLayer()
    .setGeoJSON(neighborhoods);
//we would be wanting to get geoJSON for new neighborhood in here
//maybe utilize addLayer function since it seems to be versatile
// var affordabilityLayer = L.mapbox.featureLayer().setGeoJSON(affordability);
// addLayer(affordabilityLayer, 'Affordability', 2)
// addLayer function adds button within it
  addLayer(neighborhoodsLayer, 'Neighborhoods', 1);
}

function addLayer(featureLayer, name, zIndex) {
  featureLayer
//css property that lets you set "what's in front or behind of all of your different elements"
  .setZIndex(zIndex)
  .addTo(map);
//setStyle sets the styling for the given neighborhood
  setStyle(featureLayer);
  setHover(featureLayer);

//grabs info for button, refer to index.html.erb
  var layers = document.getElementById('menu-ui');

//new button for affordability would need to be added here
  var link = document.createElement('a');
  link.href = '#';
  link.className = 'active';
  link.innerHTML = name;

  link.onclick = function(e) {
    e.preventDefault();
    e.stopPropagation();
//if neighborhoodlayer is there, take it off
    if (map.hasLayer(featureLayer)) {
      map.removeLayer(featureLayer);
      this.className = '';
//if not, add it
    } else {
      map.addLayer(featureLayer);
      this.className = 'active';
    }
  };

  layers.appendChild(link);
}

function setHover(featureLayer) {
  featureLayer.eachLayer(function(layer) {
    layer.on({
      mousemove: mousemove,
      mouseout: mouseout,
      click: zoomToFeature,
      dblclick: zoomToMap
    });
  });
}

function setStyle(featureLayer) {
  featureLayer.eachLayer(function(layer) {
    layer.setStyle({
      weight: 2,
      opacity: 0.8,
      color: '#3887be',
      fillOpacity: 0.35,
      fillColor: '#82E899'
    });
  });
}

var closeTooltip;

function mousemove(e) {
  var popup = new L.Popup({ autoPan: false });
  var layer = e.target;

  popup.setLatLng(e.latlng);
  popup.setContent('<div class="marker-title">' + layer.feature.properties.name + '</div>');

  if (!popup._map) popup.openOn(map);
    window.clearTimeout(closeTooltip);

  layer.setStyle({
    weight: 3,
    opacity: 0.8,
    fillOpacity: 0.7
  });

  if (!L.Browser.ie && !L.Browser.opera) {
    layer.bringToFront();
  }
}

function mouseout(e) {
  var layer = e.target;

  if (names.includes(layer.feature.properties.name)) {
    layer.setStyle({
      weight: 2,
      opacity: 0.8,
      color: '#3887be',
      fillOpacity: 0.35,
      fillColor: '#ffcc66'
    });
  } else {
    layer.setStyle({
      weight: 2,
      opacity: 0.8,
      color: '#3887be',
      fillOpacity: 0.35,
      fillColor: '#82E899'
    });
  }

  closeTooltip = window.setTimeout(function() {
    map.closePopup();
  }, 100);
}

function zoomToFeature(e) {
  map.fitBounds(e.target.getBounds());
}

function zoomToMap(e) {
  map.setView([39.737074, -104.953460], 12);
}
