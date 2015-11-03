<%--
  Created by IntelliJ IDEA.
  User: alej0
  Date: 04/10/2015
  Time: 21:05
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html class="no-js" lang="en" data-useragent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>UNCake - Edificios</title>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <asset:stylesheet src="foundation/foundation.css"/>
    <asset:stylesheet src="foundation/jquery-ui/jquery-ui.css"/>
    <asset:javascript src="foundation/vendor/modernizr.js"/>
    <script src="http://maps.googleapis.com/maps/api/js"></script>
    <asset:javascript src="maps/maps.js"/>
    <asset:javascript src="foundation/vendor/jquery.js"/>
</head>
<body>
<div class="row">
    <div class="large-12 columns">
        <div class="row">
            <div class="large-12 columns">
                <nav class="top-bar" data-topbar>
                    <ul class="title-area">
                        <li class="name">
                            <h1><a href="home">UNCake</a></h1>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="large-4 small-12 columns">
                <div class="panel">
                    <h3>Edificio</h3>
                    <g:textField name="selectedName" id="selectedName" placeholder="Digita número o nombre" value="" ></g:textField>
                    <g:submitButton name="pointer" value="Buscar" action="pointer"></g:submitButton>
                </div>
                <div class="panel">
                    <div class="row">
                        <div id="panel_ruta" style="float:right; overflow: auto; width:100%; height: 400px"></div>
                    </div>
                </div>
            </div>

            <div class="large-8 columns">
                <div class="row">
                    <div class="large-12 columns">
                        <div class="panel" style="border: none;padding-top: 0;padding-bottom: 0;background-color: #fff;">
                            <div class="row">
                                <div id="googleMap" class="large-10 columns" style="width:100%;height:500px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="row">
            <div class="large-12 columns">
                <hr>
                <div class="row">
                    <div class="large-6 columns">
                        <p>© Copyright no one at all. Go to town.</p>
                    </div>
                    <div class="large-6 columns">
                        <ul class="inline-list right">
                            <li>
                                <a href="#">Link 1</a>
                            </li>
                            <li>
                                <a href="#">Link 2</a>
                            </li>
                            <li>
                                <a href="#">Link 3</a>
                            </li>
                            <li>
                                <a href="#">Link 4</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
        <g:hiddenField name="doorMarker" id="doorMarker" value="${resource(dir:'images',file:'maps/entry.png', absolute:'true')}"></g:hiddenField>
        <g:hiddenField name="pointMarker" id="pointMarker" value="${resource(dir:'images',file:'maps/point2.png', absolute:'true')}"></g:hiddenField>
    </div>
</div>
<script>
    document.write('<script src=js/vendor/' +
            ('__proto__' in {} ? 'zepto' : 'jquery') +
            '.js><\/script>')
</script>
<asset:javascript src="foundation/vendor/jquery.js"/>
<asset:javascript src="foundation/foundation.min.js"/>
<script>
    $(document).foundation();
</script>
<asset:javascript src="foundation/vendor/jquery.js"/>
<asset:javascript src="foundation/jquery-ui/jquery-ui.js"/>
<asset:javascript src="foundation/foundation/foundation.js"/>
<g:javascript>
$(function() {
    $( "#pointer" ).button().click( function(){
        var selected = document.getElementById('selectedName').value;
        var url="${createLink(controller:'Building', action:'getItemByName')}";
        var response = $.ajax({
            url: url,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: {
                selectedName: selected
            },
            success:function( finalPosition ) {
                var posMarker = String(finalPosition).split("&");
                var buildingMarker = new google.maps.Marker({
                    position: new google.maps.LatLng(posMarker[0],posMarker[1]),
                    map: map,
                    title: String(selected),
                    animation: google.maps.Animation.DROP,
                    content: String(selected),
                    icon: document.getElementById("pointMarker").value
                });
                var infowindow = new google.maps.InfoWindow({
                    content: String(selected)
                });
                map.setCenter( new google.maps.LatLng(posMarker[0],posMarker[1]) );
                map.setZoom(15);
                google.maps.event.addListener(buildingMarker, 'click', function() {
                    infowindow.open(map,buildingMarker);
                });
            }
        });
    });
    $( "#selectedName" ).autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "${createLink(controller: 'Building', action: 'getAllNames')}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: {
                    maxRows: 12,
                    name_startsWith: request.term
                },
                success: function( data ) {
                    response( $.map( data, function( item ) {
                        return {
                            label: item,
                            value: item
                        }
                    }));
                }
            });
        }
    });
});
</g:javascript>
<script>
    $(document).foundation();
    var doc = document.documentElement;
    doc.setAttribute('data-useragent', navigator.userAgent);
</script>
</body>
</html>