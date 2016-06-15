function renderAddresses(address1, address2, address3) {
  $.ajax({
   type: "GET",
   url: "/api/v1/addresses/",
   data: {
       Address_1: address1,
       Address_2: address2,
       Address_3: address3,
   },
   dataType: "json",
   success: function(data) {
    createMarkers(data);
   }
 });
}

function createMarkers(addresses) {
  for (var i = 0; i < addresses.length; i++) {
    L.marker(addresses[i].geometry.coordinates).addTo(map);
  }
}
