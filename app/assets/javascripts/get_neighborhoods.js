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
     console.log("success");
   }
 });
}
