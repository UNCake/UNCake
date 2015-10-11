/**
 * Created by alej0 on 01/10/2015.
 */
var map = null;
var directionsDisplay = null;
var directionsService = null;
function initialize(){
    var myLatlng = new google.maps.LatLng(4.6385607,-74.0846136);
    var myOptions = {
        center:myLatlng,
        zoom:15,
        mapTypeId:google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("googleMap"),myOptions);
    //map = new google.maps.Map($("#googleMap").get(0), myOptions);
    directionsDisplay = new google.maps.DirectionsRenderer();
    directionsService = new google.maps.DirectionsService();
    var request = {
        origin: new google.maps.LatLng(4.634761756800125,-74.07968401908875),
        destination: /*"calle 47 # 78 k 35 sur, Bogotá, Bogotá, Colombia",*/  new google.maps.LatLng(4.637999283155514,-74.08469438552856),
        travelMode: google.maps.DirectionsTravelMode['DRIVING'],
        unitSystem: google.maps.DirectionsUnitSystem['METRIC'],
        provideRouteAlternatives: true
    };
    directionsService.route(request, function(response, status) {
        if(status == google.maps.DirectionsStatus.OK){
            directionsDisplay.setMap(map);
            directionsDisplay.setPanel(document.getElementById("panel_ruta"));
            directionsDisplay.setDirections(response);
        }else{
            alert("There is no directions available between these two points");
        }
    });
}
google.maps.event.addDomListener(window, 'load', initialize);
