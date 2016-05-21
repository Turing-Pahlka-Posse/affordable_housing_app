$(document).ready(function () {
  renderMap();
});

function renderMap() {
  var baseLayer = L.mapbox.styleLayer('mapbox://styles/julyytran/ciohh5muy0010bpneqm1tg1ij').addTo(map);
  var neighborhoodsLayer = L.mapbox.featureLayer(neighborhoods).addTo(map);
}
