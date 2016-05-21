$(document).ready(function () {
  renderBaseMap();
  toggleNeighborhoods();
});

function renderBaseMap() {
  var baseLayer = L.mapbox.styleLayer('mapbox://styles/julyytran/ciohh5muy0010bpneqm1tg1ij').addTo(map);
}

function toggleNeighborhoods() {
  var neighborhoodsLayer = L.geoJson(neighborhoods, {
    style: getStyle
  });
  addLayer(neighborhoodsLayer, 'Neighborhoods', 1);
}

function getStyle() {
  return {
    weight: 2,
    opacity: 0.8,
    color: '#3887be',
    fillOpacity: 0.35,
    fillColor: '#82E899'
   };
}

function addLayer(layer, name, zIndex) {
  layer
  .setZIndex(zIndex)
  .addTo(map);

  var layers = document.getElementById('menu-ui');

  var link = document.createElement('a');
  link.href = '#';
  link.className = 'active';
  link.innerHTML = name;

  link.onclick = function(e) {
    e.preventDefault();
    e.stopPropagation();

    if (map.hasLayer(layer)) {
      map.removeLayer(layer);
      this.className = '';
    } else {
      map.addLayer(layer);
      this.className = 'active';
    }
  };

  layers.appendChild(link);
}
