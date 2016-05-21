$(document).ready(function () {
  renderMap();
  toggleNeighborhoods();
});

function renderMap() {
  var baseLayer = L.mapbox.styleLayer('mapbox://styles/julyytran/ciohh5muy0010bpneqm1tg1ij').addTo(map);
  // var neighborhoodsLayer = L.mapbox.featureLayer(neighborhoods).addTo(map);
  // toggleNeighborhoods(neighborhoodsLayer)
}

function toggleNeighborhoods() {
  var layers = document.getElementById('menu-ui');

  addLayer(L.mapbox.featureLayer(neighborhoods), 'View Neighborhoods', 1);

  function addLayer(layer, name, zIndex) {
    layer
        .setZIndex(zIndex)
        .addTo(map);

    // Create a simple layer switcher that
    // toggles layers on and off.
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
}
