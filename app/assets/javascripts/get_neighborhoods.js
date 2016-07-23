function findNeighborhoods() {
  $('#menu').on('click', '#submit-button', function() {
    var trans_type = $("input[name='transportation']:checked").val();
    var address1 = $("#Address_1").val();
    var address2 = $("#Address_2").val();
    var address3 = $("#Address_3").val();
    clearNeighborhooods();
    clearMarkers();
    getNeighborhoods(address1, address2, address3, trans_type);
    renderAddresses(address1, address2, address3);
  });
}

function clearNeighborhooods() {
  $('#return-addresses').empty();
  setStyle(neighborhoodsLayer);
  names = [];
}

function getNeighborhoods (address1, address2, address3, trans_type) {
  renderSpinnner();
  $.ajax({
    type: "GET",
    url: "/api/v1/neighborhoods/",
    data: {
      Address_1: address1,
      Address_2: address2,
      Address_3: address3,
      transportation: trans_type,
    },
    dataType: "json",
    success: function(data) {
      spinner.stop();
      appendNeighborhoods(data);
    }
  });
}

function appendNeighborhoods(data) {
  for (var i = 0; i < data.length; i++) {
    $('#return-addresses').append(createNeighborhoodHTML(data[i]));
  }
  highlightNeighborhoods();
}

function createNeighborhoodHTML (datum) {
  return "<div class='pick-3'><div id='"
  + datum.Neighborhood
  + "'><strong>"
  + datum.Neighborhood
  + "</strong></div>Average Travel Time: "
  + datum.Distance
  + " min<br>----------------</div>"
}

var names = [];

function highlightNeighborhoods() {
  neighborhoodsLayer.eachLayer(function(layer) {
    var $neighborhoods = $('.pick-3').children();
    for (var i = 0; i < $neighborhoods.length; i++) {
      names.push($neighborhoods[i].id);
    }

    if (names.includes(layer.feature.properties.name)) {
      layer.setStyle({
        weight: 2,
        opacity: 0.8,
        color: '#3887be',
        fillOpacity: 0.35,
        fillColor: '#ffcc66'
      });
    }
  });
}
