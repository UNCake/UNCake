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

    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'bootstrap/css/bootstrap.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'agency.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'mapsSchedule.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'jquery-ui/jquery-ui.css')}" type="text/css" />
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'materialize/css/materialize.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'maps.css')}" type="text/css">

    <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' ype='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

</head>
<body class="blue-grey lighten-5" style="/*background: url('${resource(dir: "images", file: "home/fotoUN_5.jpg")}'); background-repeat: no-repeat; background-size: 100% 100%;*/">
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
                <a class="navbar-brand page-scroll" href="/home">UNCake</a>
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
        <div><br/><br/><br/><br/></div>
    </header>

    <div class="content">
        <div class="row transparent">
            <br/>
            <div class="col-sm-3 transparent">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title">Información</span>
                        <p>Los marcadores azules indican las entradas al campus. Digita el nombre o número del edificio a buscar y un marcador rojo te indicará tu destino.</p>
                    </div>
                </div><br/>
                <div id="input-building" class="input-field col s12">
                    <i class="material-icons prefix">search</i>
                    <input placeholder="Nombre o código" id="building-name" type="text" onChange="clearAutoCompleteInput()">
                    <label for="building-name">Edificio</label>
                </div><div><br/><br/><br/><br/><br/></div>
                <div style="text-align: center">
                    <a class="waves-effect waves-light btn" id="search-building"> Buscar </a><br/><br/>
                </div>
            </div>


            <div class="col-sm-6 transparent" >
                <div class="card white">
                    <div>
                        <div class="large-12 columns">
                            <div class="panel" style="border: none;padding-top: 0;padding-bottom: 0;background-color: #fff;">
                                <div class="row">
                                    <div id="googleMap" class="large-10 columns" style="width:100%;height:550px;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-3">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title">Horarios</span>
                        <p>Selecciona cada clase, un marcador amarillo te indicará el lugar. Puedes mantener un marcador a la vez o acumular varios en el mapa.</p>
                    </div>
                </div>
                <g:if test="${session.user != null}">
                    <g:if test="${uncake.User.findById( ((uncake.User)session.user).id ).schedules.size() > 0}">
                        <div >
                            <br/>
                            <div class="switch">
                                <label>
                                    Acumular&nbsp;&nbsp;&nbsp;
                                    <input type="checkbox" id="check-accumulate">
                                    <span class="lever"></span>
                                </label>
                            </div><br/>
                        </div>
                            <ul class="collapsible" data-collapsible="expandable">
                                <g:each in="${uncake.User.findById( ((uncake.User)session.user).id ).schedules}">
                                    <li>
                                        <div class="collapsible-header active"><i class="material-icons">schedule</i><p>${it.name}</p></div>
                                        <div class="collapsible-body transparent">
                                            <g:each in="${it.courses}" var="subj">
                                                <div class="subject-area">
                                                    <p class="title-subject">${String.valueOf(subj.course)[0] + String.valueOf(subj.course).toLowerCase().substring(1)}</p>
                                                    <g:each in="${subj.timeSlots}" var="subjectGroup">
                                                        <g:if test="${subjectGroup.building != null}">
                                                            <div class="day-subject waves-effect waves-light" data-loc="${subjectGroup.building.coordinates}" data-title="${String.valueOf(subj.course)[0] + String.valueOf(subj.course).toLowerCase().substring(1)}" data-content="${String.valueOf(subjectGroup.day).substring(0,3)} ${subjectGroup.startHour}-${subjectGroup.endHour} ${subjectGroup.building.code}-${subjectGroup.classroom}">
                                                                <p class="subject-detail">${String.valueOf(subjectGroup.day).substring(0,3)} ${subjectGroup.startHour}-${subjectGroup.endHour}<br/>
                                                                ${subjectGroup.building.code}-${subjectGroup.classroom.replace('null', '')}</p>
                                                            </div>
                                                        </g:if>
                                                    </g:each>
                                                </div>
                                            </g:each>
                                        </div>
                                    </li>
                                </g:each>
                            </ul>
                    </g:if>
                </g:if>
            </div>
            <g:hiddenField name="doorMarker" id="door-marker" value="${resource(dir:'images',file:'maps/entry.png', absolute:'true')}"></g:hiddenField>
            <g:hiddenField name="pointMarker" id="point-marker" value="${resource(dir:'images',file:'maps/point2.png', absolute:'true')}"></g:hiddenField>
            <g:hiddenField name="subjectMarker" id="subject-marker" value="${resource(dir:'images',file:'maps/point6.png', absolute:'true')}"></g:hiddenField>
        </div>
    </div>
    <script src="//maps.googleapis.com/maps/api/js"></script>
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="bootstrap/js/bootstrap.min.js"/>
    <asset:javascript src="maps/maps.js"/>
    <asset:javascript src="materialize/js/materialize.js"/>
    <asset:javascript src="jquery-ui/jquery-ui.js"/>
    <g:javascript>
        arrayMarkers = [];
        $(function() {
            $( ".day-subject" ).click( function(){
                if( $("#check-accumulate").is(":checked") == false ){
                    for (var i = 0; i < arrayMarkers.length; i++) {
                        arrayMarkers[i].setMap(null);
                    };
                }
                var classMarker = String( $(this).data('loc') ).split("&");
                var subjectMarker = new google.maps.Marker({
                    position: new google.maps.LatLng(classMarker[0], classMarker[1]),
                    map: map,
                    title: String($(this).data('content')),
                    animation: google.maps.Animation.DROP,
                    content: String($(this).data('title')),
                    icon: document.getElementById("subject-marker").value
                });
                var infowindow = new google.maps.InfoWindow({
                    content: String($(this).data('title'))
                });
                map.setCenter( new google.maps.LatLng(classMarker[0],classMarker[1]) );
                map.setZoom(15);
                google.maps.event.addListener(subjectMarker, 'click', function() {
                    infowindow.open(map, subjectMarker);
                });
                arrayMarkers.push(subjectMarker);
            });

            $( "#search-building" ).click( function(){
                var selected = document.getElementById('building-name').value;
                if( selected != '' ){
                    var url="${createLink(controller: 'Building', action: 'getItemByName')}";
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
                                icon: document.getElementById("point-marker").value
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
                }else{
                    Materialize.toast("Selecciona el edificio a buscar", 4000);
                }
            });
            /*$("#building-name").keypress(function( event ) {
              if ( event.which == 13 ) {
                 $("#search-building").trigger('click');
              }
            });*/
            $( "#building-name" ).autocomplete({
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
        function clearAutoCompleteInput() {
            $("#building-name").val('');
        }
    </g:javascript>
</body>
</html>