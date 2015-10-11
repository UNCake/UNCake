/**
 * Created by alej0 on 01/10/2015.
 */
var map = null;
var directionsDisplay = null;
var directionsService = null;
function initialize(){
    var myLatlng = new google.maps.LatLng(4.6385607,-74.0846136);   /* 4.6385607,-74.0846136 */
    var myOptions = {
        center: myLatlng,
        zoom: 15,
        mapTypeId: google.maps.MapTypeId.HYBRID
    };
    map = new google.maps.Map(document.getElementById("googleMap"),myOptions);

    var entryMarker45 = new google.maps.Marker({
        position: new google.maps.LatLng(4.634847306820322,-74.08012121915817),
        map: map,
        title: String("Entrada calle 45"),
        content: String("Entrada calle 45")
    });
    var infowindow45 = new google.maps.InfoWindow({
        content: String("Entrada calle 45")
    });
    google.maps.event.addListener(entryMarker45, 'click', function() {
        infowindow45.open(map,entryMarker45);
    });

    var entryMarker26 = new google.maps.Marker({
        position: new google.maps.LatLng(4.632451902341316,-74.08394068479538),
        map: map,
        title: String("Entrada calle 26"),
        content: String("Entrada calle 26")
    });
    var infowindow26 = new google.maps.InfoWindow({
        content: String("Entrada calle 26")
    });
    google.maps.event.addListener(entryMarker26, 'click', function() {
        infowindow26.open(map,entryMarker26);
    });

    var entryMarkerIcta = new google.maps.Marker({
        position: new google.maps.LatLng(4.634162906368862,-74.08840656280518),
        map: map,
        title: String("Entrada ICTA"),
        content: String("Entrada ICTA")
    });
    var infowindowIcta = new google.maps.InfoWindow({
        content: String("Entrada ICTA")
    });
    google.maps.event.addListener(entryMarkerIcta, 'click', function() {
        infowindowIcta.open(map,entryMarkerIcta);
    });

    var entryMarker38 = new google.maps.Marker({
        position: new google.maps.LatLng(4.639298567016606,-74.08878475427628),
        map: map,
        title: String("Entrada transversal 38"),
        content: String("Entrada transversal 38")
    });
    var infowindow38 = new google.maps.InfoWindow({
        content: String("Entrada transversal 38")
    });
    google.maps.event.addListener(entryMarker38, 'click', function() {
        infowindow38.open(map,entryMarker38);
    });

    var entryMarker53 = new google.maps.Marker({
        position: new google.maps.LatLng(4.643864755524597,-74.08303946256638),
        map: map,
        title: String("Entrada calle 53"),
        content: String("Entrada calle 53")
    });
    var infowindow53 = new google.maps.InfoWindow({
        content: String("Entrada calle 53")
    });
    google.maps.event.addListener(entryMarker53, 'click', function() {
        infowindow53.open(map,entryMarker53);
    });

    /*
    *
    *
    * */

    /*directionsDisplay = new google.maps.DirectionsRenderer();
    directionsService = new google.maps.DirectionsService();
    var request = {
        origin: new google.maps.LatLng(4.634761756800125,-74.07968401908875),
        destination: new google.maps.LatLng(4.637999283155514,-74.08469438552856),
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
    });*/
}
google.maps.event.addDomListener(window, 'load', initialize);
