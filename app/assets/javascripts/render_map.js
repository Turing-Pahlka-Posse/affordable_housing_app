$(document).ready(function () {
  renderBaseMap();
  renderMarkersLayer();
  toggleNeighborhoods();
  findNeighborhoods();
});

function renderBaseMap() {
  var baseLayer = L.mapbox.styleLayer('mapbox://styles/julyytran/ciohh5muy0010bpneqm1tg1ij').addTo(map);
}

function toggleNeighborhoods() {
  neighborhoodsLayer = L.mapbox.featureLayer()
    .setGeoJSON(neighborhoods);

  addLayer(neighborhoodsLayer, 'Neighborhoods', 1);
}

function addLayer(featureLayer, name, zIndex) {
  featureLayer
  .setZIndex(zIndex)
  .addTo(map);

  setStyle(featureLayer);
  setHover(featureLayer);

  var layers = document.getElementById('menu-ui');

  var link = document.createElement('a');
  link.href = '#';
  link.className = 'active';
  link.innerHTML = name;

  link.onclick = function(e) {
    e.preventDefault();
    e.stopPropagation();

    if (map.hasLayer(featureLayer)) {
      map.removeLayer(featureLayer);
      this.className = '';
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
