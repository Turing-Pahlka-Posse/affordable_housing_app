function findNeighborhoods() {
  $('#menu').on('click', '#submit-button', function() {
    address1 = $("#Address_1").val();
    address2 = $("#Address_2").val();
    address3 = $("#Address_3").val();
    // renderSpinnner();
    clearNeighborhooods();
    getNeighborhoods(address1, address2, address3);
  });
}

function renderSpinnner() {
  var opts = {
    lines: 13 // The number of lines to draw
  , length: 28 // The length of each line
  , width: 14 // The line thickness
  , radius: 42 // The radius of the inner circle
  , scale: 0.5 // Scales overall size of the spinner
  , corners: 1 // Corner roundness (0..1)
  , color: '#000' // #rgb or #rrggbb or array of colors
  , opacity: 0.25 // Opacity of the lines
  , rotate: 0 // The rotation offset
  , direction: 1 // 1: clockwise, -1: counterclockwise
  , speed: 1 // Rounds per second
  , trail: 60 // Afterglow percentage
  , fps: 20 // Frames per second when using setTimeout() as a fallback for CSS
  , zIndex: 2e9 // The z-index (defaults to 2000000000)
  , className: 'spinner' // The CSS class to assign to the spinner
  , top: '80%' // Top position relative to parent
  , left: '50%' // Left position relative to parent
  , shadow: false // Whether to render a shadow
  , hwaccel: false // Whether to use hardware acceleration
  , position: 'absolute' // Element positioning
  };

  var target = document.getElementById('return-addresses')
  spinner = new Spinner(opts).spin(target);
}

function clearNeighborhooods() {
  $('#return-addresses').empty();
  setStyle(neighborhoodsLayer);
  names = [];
}

function getNeighborhoods (address1, address2, address3) {
  renderSpinnner();
  $.ajax({
   type: "GET",
   url: "/api/v1/neighborhoods/",
   data: {
       Address_1: address1,
       Address_2: address2,
       Address_3: address3,
   },
   dataType: "json",
   success: function(data) {
     spinner.stop()
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
