$(document).ready(function () {
  renderMap();
});

function renderMap() {
  // var featureLayer = L.mapbox.featureLayer(usCoordinates)
  //   .addTo(map);
  L.mapbox.styleLayer('mapbox://styles/julyytran/ciohh5muy0010bpneqm1tg1ij').addTo(map);
}
