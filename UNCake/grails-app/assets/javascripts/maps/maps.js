/**
 * Created by alej0 on 01/10/2015.
 */
var map = null;
var directionsDisplay = null;
var directionsService = null;
function initialize(){
    var myLatlng = new google.maps.LatLng(4.642163936049374, -74.0873122215271); //4.6385607,-74.0846136
    var myOptions = {
        center:myLatlng,
        zoom:15,
        mapTypeId:google.maps.MapTypeId.HYBRID
    };
    map = new google.maps.Map(document.getElementById("googleMap"),myOptions);

    directionsDisplay = new google.maps.DirectionsRenderer();
    directionsService = new google.maps.DirectionsService();
    var request = {
        origin: new google.maps.LatLng(4.63963702231072,-74.08902615308762),
        destination: new google.maps.LatLng(4.647981250849492,-74.09545943140984),
        travelMode: google.maps.DirectionsTravelMode['WALKING'],
        unitSystem: google.maps.DirectionsUnitSystem['METRIC'],
        provideRouteAlternatives: true
    };
    directionsService.route(request, function(response, status) {
        if(status == google.maps.DirectionsStatus.OK){
            directionsDisplay.setDirections(response);
            directionsDisplay.setOptions( { suppressMarkers: true, preserveViewport: true } );
            directionsDisplay.setMap(map);
        }
    });

    var texto45 = "Entrada calle 45";
    var texto26 = "Entrada calle 26";
    var textoICTA = "Entrada ICTA";
    var texto38 = "Entrada transversal 38";
    var texto53 = "Entrada calle 53";
    var textoCAN = "Entrada sector CAN";

    var entryMarker45 = new google.maps.Marker({
        position: new google.maps.LatLng(4.634847306820322,-74.08012121915817),
        map: map,
        title: texto45,
        content: texto45,
        icon: document.getElementById("door-marker").value
    });
    var infowindow45 = new google.maps.InfoWindow({
        content: texto45
    });
    google.maps.event.addListener(entryMarker45, 'click', function() {
        infowindow45.open(map,entryMarker45);
    });

    var entryMarker26 = new google.maps.Marker({
        position: new google.maps.LatLng(4.632451902341316,-74.08394068479538),
        map: map,
        title: texto26,
        content: texto26,
        icon: document.getElementById("door-marker").value
    });
    var infowindow26 = new google.maps.InfoWindow({
        content: texto26
    });
    google.maps.event.addListener(entryMarker26, 'click', function() {
        infowindow26.open(map,entryMarker26);
    });

    var entryMarkerIcta = new google.maps.Marker({
        position: new google.maps.LatLng(4.634162906368862,-74.08840656280518),
        map: map,
        title: textoICTA,
        content: textoICTA,
        icon: document.getElementById("door-marker").value
    });
    var infowindowIcta = new google.maps.InfoWindow({
        content: textoICTA
    });
    google.maps.event.addListener(entryMarkerIcta, 'click', function() {
        infowindowIcta.open(map,entryMarkerIcta);
    });

    var entryMarker38 = new google.maps.Marker({
        position: new google.maps.LatLng(4.639298567016606,-74.08878475427628),
        map: map,
        title: texto38,
        content: texto38,
        icon: document.getElementById("door-marker").value
    });
    var infowindow38 = new google.maps.InfoWindow({
        content: texto38
    });
    google.maps.event.addListener(entryMarker38, 'click', function() {
        infowindow38.open(map,entryMarker38);
    });

    var entryMarker53 = new google.maps.Marker({
        position: new google.maps.LatLng(4.643864755524597,-74.08303946256638),
        map: map,
        title: texto53,
        content: texto53,
        icon: document.getElementById("door-marker").value
    });
    var infowindow53 = new google.maps.InfoWindow({
        content: texto53
    });
    google.maps.event.addListener(entryMarker53, 'click', function() {
        infowindow53.open(map,entryMarker53);
    });

    var entryMarkerCAN = new google.maps.Marker({
        position: new google.maps.LatLng(4.647981250849492,-74.09545943140984),
        map: map,
        title: textoCAN,
        content: textoCAN,
        icon: document.getElementById("door-marker").value
    });
    var infowindowCAN = new google.maps.InfoWindow({
        content: textoCAN
    });
    google.maps.event.addListener(entryMarkerCAN, 'click', function() {
        infowindowCAN.open(map,entryMarkerCAN);
    });
    map.setCenter(myLatlng);
}
google.maps.event.addDomListener(window, 'load', initialize);
