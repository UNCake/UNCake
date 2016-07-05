<html class="no-js" lang="en" data-useragent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)">
<head>
    <meta name="layout" content="navbar"/>
    <title>UNCake - Edificios</title>

    <asset:stylesheet src="mapsSchedule.css"/>
    <asset:stylesheet src="maps.css"/>
    <script src="//maps.googleapis.com/maps/api/js"></script>

</head>
<body class="blue-grey lighten-5">

    <div class="content">
        <div class="row transparent">
            <br/>
            <div class="col m3 transparent">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title">Información</span>
                        <p>Los marcadores azules indican las entradas al campus. Digita el nombre o número del edificio a buscar y un marcador rojo te indicará la ubicación del destino.</p>
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


            <div class="col m6 transparent" >
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

            <div class="col m3">
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
                            <ul id="schedules" class="collapsible" data-collapsible="accordion" >
                                <g:each in="${uncake.User.findById( ((uncake.User)session.user).id ).schedules}">
                                    <li>
                                        <div class="collapsible-header"><i class="material-icons">schedule</i><p>${it.name}</p></div>
                                        <div class="collapsible-body transparent">
                                            <g:each in="${it.courses}" var="subj">
                                                <div class="subject-area">
                                                    <p class="title-subject truncate indigo lighten-4">${String.valueOf(subj.course.name)}</p>
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

    <asset:javascript src="maps/maps.js"/>
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