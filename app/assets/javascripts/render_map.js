$(document).ready(function () {
  renderMap();
});

function renderMap () {
  var featureLayer = L.mapbox.featureLayer(usCoordinates)
    .addTo(map);
}
