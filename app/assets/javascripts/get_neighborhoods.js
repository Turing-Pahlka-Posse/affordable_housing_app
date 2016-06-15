function findNeighborhoods() {
  $('#menu').on('click', '#submit-button', function() {
    address1 = $("#Address_1").val();
    address2 = $("#Address_2").val();
    address3 = $("#Address_3").val();
    getNeighborhoods(address1, address2, address3);
  });
}

function getNeighborhoods (address1, address2, address3) {
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
     appendNeighborhoods(data);
    //  highlightNeighborhoods();
   }
 });
}

function appendNeighborhoods(data) {
  for (var i = 0; i < data.length; i++) {
    $('#return-addresses').append(createNeighborhoodHTML(data[i]));
  }
}

function createNeighborhoodHTML (datum) {
  return "<div class='pick-3'><strong>"
  + datum.Neighborhood
  + "</strong><br>Average Travel Time: "
  + datum.Distance
  + " min<br>----------------</div>"
}

// function highlightNeighborhoods() {
//   neighborhoodsLayer.eachLayer(function(layer) {
//     layer.setStyle({
//       weight: 2,
//       opacity: 0.8,
//       color: '#3887be',
//       fillOpacity: 0.35,
//       fillColor: '#82E899'
//     });
//   });
//   console.log("success");
// }
