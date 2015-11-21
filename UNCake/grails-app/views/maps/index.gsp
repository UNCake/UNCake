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
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="bootstrap/js/bootstrap.min.js"/>
    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="dialogueStyle.css"/>
    <asset:stylesheet src="foundation/jquery-ui/jquery-ui.css"/>
    <asset:javascript src="foundation/vendor/modernizr.js"/>
    <script src="http://maps.googleapis.com/maps/api/js"></script>
    <asset:javascript src="maps/maps.js"/>
    <asset:javascript src="foundation/vendor/jquery.js"/>
    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="dialogueStyle.css"/>

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

</head>
<body>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand page-scroll" href="home">UNCake</a>
            </div>
            <g:if test="${session.user != null}">
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
                    <ul class="nav navbar-nav navbar-right">
                        <li class="hidden">
                            <a href="#page-top"></a>
                        </li>
                        <li>
                            <a class="page-scroll" href="profile"><span class="glyphicon glyphicon-user"></span>Hola ${session.user.name.split()[0]}!</a>
                        </li>
                        <li>
                            <a class="page-scroll" href="logout"><span class="glyphicon glyphicon-log-out"></span>Salir</a>
                        </li>
                    </ul>
                </div>
            </g:if>

            <g:if test="${session.user == null}"   >
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
                    <ul class="nav navbar-nav navbar-right">
                        <li class="hidden">
                            <a href="#page-top"></a>
                        </li>
                        <li>
                            <a class="page-scroll" href="register"><span class="glyphicon glyphicon-user"></span>Registrarme</a>
                        </li>
                        <li>
                            <a class="page-scroll" href="login"><span class="glyphicon glyphicon-log-in"></span>Ingresar</a>
                        </li>
                    </ul>
                </div>
            </g:if>
        </div>
    </nav>

    <header>
        <div class="container">
            <br><br><br>
        </div>
    </header>

    <div class="container">
        <div class="row">
            <div class="large-12 columns" >
                <div class="row">
                    <div class="large-4 small-12 columns" style="padding-left: 50px; padding-right: 50px; padding-top: 60px;">
                        <div class="panel">
                            <h3 style="font-family: 'Kaushan Script','Helvetica Neue',Helvetica,Arial,cursive; color: #1ab394;">Edificio</h3>
                            <br/>
                            <g:textField name="selectedName" id="selectedName" placeholder="Digita número o nombre" value="" style="width: 300px;" ></g:textField>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <g:submitButton name="pointer" value="Buscar" action="pointer"></g:submitButton>
                            <br/><br/>
                            <p>Los marcadores azules indican las entradas al campus, digita el nombre o número del edificio a buscar, un marcador rojo te indicará tu destino.</p>
                        </div>
                    </div>

                    <div class="large-8 columns" style="padding: 80px;">
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
                <g:hiddenField name="doorMarker" id="doorMarker" value="${resource(dir:'images',file:'maps/entry.png', absolute:'true')}"></g:hiddenField>
                <g:hiddenField name="pointMarker" id="pointMarker" value="${resource(dir:'images',file:'maps/point2.png', absolute:'true')}"></g:hiddenField>
                <g:if test="${session.user != null}">
                    <g:if test="${uncake.User.findById( ((uncake.User)session.user).id ).schedules.size() > 0}">
                        <g:set var="records" value="[]"/>
                        <g:each in="${uncake.User.findById( ((uncake.User)session.user).id ).schedules}">
                            <g:each in="${it.courses}" var="cur">
                                <div style="display: none;">
                                    ${records.add(cur.name)}
                                </div>
                            </g:each>
                        </g:each>
                        <div>
                            <g:select id="recordSelector" name="${records}" from="${records}" noSelection="['':'-Selecciona un horario-']"/>
                        </div>
                    </g:if>
                </g:if>
            </div>
        </div>
    </div>
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