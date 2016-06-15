<%@ page import="uncake.User" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="navbarNoJS"/>
    <title>UNCake - Progreso</title>

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <asset:stylesheet src="grades.css"/>
</head>

<body id="grades-body" class="blue-grey lighten-5">

    <div id="modal-overwrite" class="modal bottom-sheet">
        <div class="modal-content">
            <h4 id="modal-header">REEMPLAZAR</h4>
            <p id="modal-content">La historia académica ingresada ya existe, ¿desea reemplazarla?</p>
            <a id="btn-overwrite" class="modal-action modal-close waves-effect waves-light btn light-blue lighten-3">Aceptar</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a class="modal-action modal-close waves-effect waves-light btn light-blue lighten-3">Cancelar</a>
        </div>
    </div>

    <div class="content">
        <div class="row transparent">
            <div class="col s10 offset-s1">
                <br/>
                <div class="col s12 transparent">
                    <div class="card indigo lighten-2 z-depth-2">
                        <div class="card-content white-text">
                            <span class="card-title">Información</span>
                            <p>Selecciona la historia académica del SIA con el comando Ctrl+A, luego copiala Ctrl+C y pégala en la caja de texto que está a continuación Ctrl+V.</p>
                        </div>
                    </div>
                </div>

                <div class="col s12 transparent">
                    <div class="card white z-depth-2">
                        <br/>
                        <div id="input-record" class="input-field col s12">
                            <i class="material-icons prefix">library_books</i>
                            <textarea class="materialize-textarea" id="academic-record"></textarea>
                            <label for="academic-record">Historia académica</label>
                        </div><div><br/><br/><br/><br/><br/><br/><br/></div>
                        <div style="text-align: center">
                            <a class="waves-effect waves-light btn light-blue lighten-3" id="calculate-papa"> Calcular </a><br/><br/>
                        </div>
                        <div class="card-action center-align">
                            <p class="indigo-text">UNCake no guarda ningún tipo de información de los usuarios si ellos no lo desean, cada usuario es responsable por el uso que le de a su información dentro de la plataforma.</p>
                        </div>
                    </div>
                </div><br/>

                <div id="saved-container" class="col s12 transparent" style="display: none;">
                    <div class="card white z-depth-2">
                        <div class="card-content black-text">
                            <span class="card-title">Cargar</span>
                            <p>Tienes historias académicas almacenadas ¿quieres ver una previamente guardada crear una nueva?</p><br/>
                            <g:if test="${session.user != null}">
                                <g:if test="${uncake.User.findById( ((User)session.user).id ).academicRecord.size() > 0}">
                                    <g:set var="records" value="[]"/>
                                    <g:each in="${uncake.User.findById( ((User)session.user).id ).academicRecord}">
                                        <g:each in="${it.studyPlan}" var="studyPlan">
                                            <div style="display: none;">${records.add(studyPlan.code + " | " + studyPlan.name)}</div>
                                        </g:each>
                                    </g:each>
                                    <div class="input-field col s8">
                                        <select id="select-record">
                                            <option value="" disabled selected>-Selecciona una historia académica-</option>
                                            <g:each in="${records}">
                                                <option value="${it}">${it}</option>
                                            </g:each>
                                        </select>
                                        <label for="select-record">Historias académicas</label>
                                    </div>
                                    <div class="col s4 right-align">
                                        <a class="waves-effect waves-light btn light-blue lighten-3" id="btn-load"> Cargar </a>
                                    </div>
                                    <br/><br/><br/><br/>
                                    <g:if test="${params.plan != null}">
                                        <g:javascript>
                                            document.getElementById('select-record').value = "${params.plan}".replace('&','|');
                                            window.onload = function(){
                                                $("#btn-load").trigger('click');
                                            }
                                        </g:javascript>
                                    </g:if>
                                </g:if>
                            </g:if>
                        </div>
                    </div>
                </div>

                <div id="information_container" style="display: none;">
                    <div id="record-title" class="col s12 transparent">
                        <div class="card col s12 indigo lighten-2 z-depth-2">
                            <div class="card-content white-text">
                                <div class="col s9">
                                    <span class="card-title" id="title-record"></span>
                                    <p id="papa-message"></p>
                                    <p id="pa-message"></p>
                                    <br/>
                                </div>
                                <g:if test="${session.user != null}">
                                    <g:if test="${uncake.User.findById( ( (User)session.user ).id ).academicRecord.size() > 0}">
                                        <g:javascript>
                                            document.getElementById("saved-container").style.display = 'block';
                                        </g:javascript>
                                    </g:if>
                                    <div class="col s3 center-align">
                                        <br/><br/><a class="waves-effect waves-light btn light-blue lighten-3" id="btn-save"> Guardar </a><br/><br/><br/>
                                    </div>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    <div id="record-data" class="col s12 transparent">
                        <div class="card col s12 white z-depth-2">
                            <ul class="collapsible" data-collapsible="expandable">
                                <li>
                                    <div class="collapsible-header active"><i class="material-icons">equalizer</i><p>Promedio</p></div>
                                    <div class="collapsible-body transparent">
                                        <div id="papa-chart"></div>
                                    </div>
                                </li>
                                <li>
                                    <div class="collapsible-header active"><i class="material-icons">track_changes</i><p>Avance</p></div>
                                    <div class="collapsible-body transparent">
                                        <div style="width: 100%; height: 400px;">
                                            <div id="advance-chart"></div>
                                            <div id="components-chart"></div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="collapsible-header active"><i class="material-icons">list</i><p>Materias</p></div>
                                    <div class="collapsible-body transparent">
                                        <div id="record-table"></div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="col s12 transparent">
                        <div class="card col s12 white z-depth-2">
                            <div id="new-subjects-1" class="center-align" style=" padding-bottom: 6em;">
                                <br/>
                                <div class="input-field col s4">
                                    <i class="material-icons prefix">schedule</i>
                                    <input placeholder="Créditos a cursar" id="input-credits-1" type="text" class="input-credits">
                                    <label for="input-credits-1">Créditos</label>
                                </div>

                                <div class="input-field col s2 center-align">
                                    <div class="switch">
                                        <label>
                                            Nota&nbsp;&nbsp;&nbsp;
                                            <input type="checkbox" id="check-grade-1" class="check-grade">
                                            <span class="lever"></span>
                                        </label>
                                    </div>
                                </div>

                                <div class="input-field col s4">
                                    <i class="material-icons prefix">done_all</i>
                                    <input placeholder="Nota esperada" id="input-grade-1" type="text" class="input-grade" disabled="disabled">
                                    <label for="input-grade-1">Nota esperada</label>
                                </div>
                                <div class="input-field col s2">
                                    <a id="btn-add-1" class="btn-add btn-floating btn-medium waves-effect waves-light light-blue lighten-3"><i id="icon-add-1" class="material-icons">add</i></a>
                                </div>
                            </div>
                        </div>

                        <div class="card col s12 white z-depth-2">
                            <div id="calculate" class="col s12 columns" style=" padding-bottom: 1em;">
                                <br>
                                <div id="box-average" class="input-field col s4 offset-s2">
                                    <i class="material-icons prefix">trending_up</i>
                                    <input placeholder="PAPA que esperas obtener" id="input-average" type="text" class="validate">
                                    <label for="input-average">Promedio esperado</label>
                                </div>
                                <div class="input-field col s2 right-align">
                                    <a class="waves-effect waves-light btn light-blue lighten-3" id="calculate-add"> Calcular </a>
                                </div>
                            </div>
                        </div>
                        <div id="card-result" class="card col s12 indigo lighten-2 z-depth-2" style="display: none;">
                            <div class="card-content white-text">
                                <span class="card-title">Resultado:</span>
                                <p id="projection-result"></p>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    <div/>

    <asset:javascript src="jquery-2.2.0.min.js"/>
    <asset:javascript src="bootstrap/js/bootstrap.min.js"/>
    <asset:javascript src="jquery-ui/jquery-ui.js"/>
    <asset:javascript src="materialize/js/materialize.js"/>
    <g:javascript>
        $(document).ready(function() {
            $('select').material_select();
            $('.caret').html('');
        });
        google.load("visualization", "1.1", {packages:["bar", "corechart", "imagebarchart", "table"]});
        const PAPA = 'PAPA', PA = 'PA', PERIOD_NAMES = 'period_names', SUBJECTS = 'subjects', ADVANCE_COMP = 'advance_comp', ADVANCE = 'advance', PLAN = 'plan';

        var textObtained = "";
        var dataCalculate = {};
        var dataVisible = false;

        $(function(){
            $(window).resize(function(){
                if( dataVisible ){
                    drawPAPA( dataCalculate[PAPA], dataCalculate[PA], dataCalculate[PERIOD_NAMES] );
                    drawPercentage( roundAverage( dataCalculate[ADVANCE] ) );
                    drawComponents( dataCalculate[ADVANCE_COMP] );
                    drawTable( dataCalculate[SUBJECTS] );
                }
            });
            $( "#calculate-papa" ).click( function() {
                var academicRecord = removeAccent( $( "#academic-record" ).val() );
                if( academicRecord.length > 0 ){
                    $.ajax({
                        type: 'POST',
                        url: "${ createLink( action: 'calculateAcademicRecord') }",
                        data: {academicRecord: academicRecord},
                        success: function( result ){
                            if( result == "false" ){
                                $( "#input-record" ).effect( "shake", {}, 500 );
                                Materialize.toast("Ingresa una historia académica válida", 4000, "light-blue lighten-3 z-depth-2");
                            }
                            else{
                                $("#information_container").show();
                                dataCalculate = splitDataCalculate( result );
                                textObtained = result;
                                showPlan( dataCalculate[PLAN] );
                                drawPAPA( dataCalculate[PAPA], dataCalculate[PA], dataCalculate[PERIOD_NAMES] );
                                drawPercentage( roundAverage( dataCalculate[ADVANCE] ) );
                                drawComponents( dataCalculate[ADVANCE_COMP] );
                                drawTable( dataCalculate[SUBJECTS] );
                                dataVisible = true;
                            }
                        }
                    });
                }else{
                    $( "#input-record" ).effect( "shake", {}, 500 );
                    Materialize.toast("Ingresa tu historia académica", 4000, "light-blue lighten-3 z-depth-2");
                }
            });
            $("#calculate-add").click( function() {
                if( validateInputCalculate() ){
                    var credits = "";
                    var grades = "";
                    var average;
                    $(".input-credits").each(function(){
                        credits = credits.concat( "&&" + parseInt( $(this).val() ) );
                    });
                    $(".input-grade").each(function(){
                        if( $(this).val() != "" )
                            grades = grades.concat( "&&" + $(this).val().replace(',','.') );
                        else
                            grades = grades.concat( "&&" + String(-1) );
                    });
                    credits = credits.substring( 2, String(credits).length );
                    grades = grades.substring( 2, String(grades).length );
                    average = $("#input-average").val().replace(',','.');
                    var inputData = credits.concat('&&&').concat(grades).concat('&&&').concat(average).concat('&&&').concat( dataCalculate[SUBJECTS] );
                    $.ajax({
                        type: 'POST',
                        url: "${ createLink( action: 'calculateProjection') }",
                        data: {inputData: inputData},
                        success: function( result ){
                            $("#card-result").hide();
                            var numSubjects = parseInt( result.split('&&&')[2] );
                            if( result.split('&&&')[0] == 0 ){
                                var gradeSubject = parseFloat( result.split('&&&')[1] );
                                $("#projection-result").text("");
                                if( gradeSubject < 0 ){
                                    Materialize.toast("Tu PAPA no puede bajar tanto con los créditos inscritos", 4000, "light-blue lighten-3 z-depth-2");
                                }else if( gradeSubject > 5){
                                    Materialize.toast("La nota mínima requerida es mayor a 5, exactamente: " + roundSubject(gradeSubject), 4000, "light-blue lighten-3 z-depth-2");
                                }else{
                                    $("#card-result").effect( "slide", {}, 500 );
                                    if( numSubjects > 1 )
                                        $("#projection-result").text("La nota mínima requerida en las " + numSubjects + " asignaturas para tener el PAPA en " + average + " es de " + roundSubject(gradeSubject) );
                                    else
                                        $("#projection-result").text("La nota mínima requerida en la asignatura para tener el PAPA en " + average + " es de " + roundSubject(gradeSubject) );
                                }
                            }else{
                                $("#card-result").effect( "slide", {}, 500 );
                                var averageObtained = parseFloat( result.split('&&&')[1] );
                                if( numSubjects > 1 )
                                    $("#projection-result").text("El PAPA obtenido cursando las " + numSubjects + " asignaturas es de " + roundAverage(averageObtained) + " exactamente " + averageObtained );
                                else
                                    $("#projection-result").text("El PAPA obtenido cursando la asignatura es de " + roundAverage(averageObtained) + " exactamente " + averageObtained );
                            }
                        }
                    });
                }
            });
            $( "#btn-save" ).click( function() {
                var record = removeAccent( $( "#academic-record" ).val() );
                $.ajax({
                    type: 'POST',
                    url: "${createLink(action: 'existAcademicRecord')}",
                    data: {record: record},
                    success: function( created ){
                        if( parseInt(created) == 1 )
                            $( "#modal-overwrite" ).openModal();
                        else
                            saveRecord( record );
                    },
                    error: function( data ){
                    }
                });
            });
            $( "#btn-overwrite" ).click( function() {
                var record = removeAccent( $( "#academic-record" ).val() );
                saveRecord( record );
            });
            $( "#btn-load" ).click( function() {
                var academicRecord = $("#select-record").val() != null ? String( $("#select-record").val() ) : null;
                if( academicRecord != null ){
                    $.ajax({
                        type: 'POST',
                        url: "${createLink(action: 'loadAcademicRecord')}",
                        data: {record: academicRecord},
                        success: function( result ){
                            $("#information_container").show();
                            dataCalculate = splitDataCalculate( result );
                            textObtained = result;
                            showPlan( dataCalculate[PLAN] );
                            drawPAPA( dataCalculate[PAPA], dataCalculate[PA], dataCalculate[PERIOD_NAMES] );
                            drawPercentage( roundAverage( dataCalculate[ADVANCE] ) );
                            drawComponents( dataCalculate[ADVANCE_COMP] );
                            drawTable( dataCalculate[SUBJECTS] );
                            dataVisible = true;
                        },
                        error: function( data ){
                            Materialize.toast("¡Ocurrió un error al cargar la historia académica!", 4000, "light-blue lighten-3 z-depth-2");
                        }
                    });
                }
                else
                    Materialize.toast("Selecciona una historia académica a cargar", 4000, "light-blue lighten-3 z-depth-2");
            });
            $(".btn-add").each(function (){
                $(this).bind("click",addField);
            });
            $( ".check-grade" ).on( "click", function() {
                var checkID = parseInt($(this).attr('id').replace('check-grade-',''));
                $( "#input-grade-" + checkID )[0].disabled = true;
                $( "#input-grade-" + checkID ).val('');
                if( $( "#check-grade-" + checkID ).is(":checked") ){
                    $( "#input-grade-" + checkID )[0].disabled = false;
                }
            });
            function saveRecord( record ){
                $.ajax({
                    type: 'POST',
                    url: "${createLink(action: 'saveAcademicRecord')}",
                    data: {record: record},
                    success: function(){
                        Materialize.toast("¡La historia académica ha sido guardada!", 4000, "light-blue lighten-3 z-depth-2");
                        //document.getElementById("saved-container").style.display = 'block';
                    },
                    error: function( data ){
                        Materialize.toast("¡Ocurrió un error al guardar la historia académica!", 4000, "light-blue lighten-3 z-depth-2");
                    }
                });
            }
            function validateInputCalculate(){
                var regExpCredits = /^[0-9]+$/g;
                var regExpGrade = /^[0-9](:?[\.\,][0-9])?$/g;
                var creditsError = false;
                var gradeError = false;
                var averageError = false;
                $(".input-credits").each(function(){
                    if( !$(this).val().match( regExpCredits ) ){
                        creditsError = true;
                        $(this).parent('div').effect( "shake", {}, 500 );
                        Materialize.toast("Revisa los créditos ingresados", 4000, "light-blue lighten-3 z-depth-2");
                    }
                });
                $(".input-grade").each(function(){
                    if( !$(this).is(":disabled") && !$(this).val().match( regExpGrade ) ){
                        gradeError = true;
                        $(this).parent('div').effect( "shake", {}, 500 );
                        Materialize.toast("Revisa las notas ingresadas de 0-5 con una cifra decimal", 4000, "light-blue lighten-3 z-depth-2");
                    }
                    else{
                        if( parseFloat( $(this).val() ) > 5 ){
                            gradeError = true;
                            $(this).parent('div').effect( "shake", {}, 500 );
                            Materialize.toast("La nota ingresada no puede ser mayor a 5", 4000, "light-blue lighten-3 z-depth-2");
                        }
                    }
                });

                if( !$("#input-average").val().match( regExpGrade ) )
                    averageError = true
                else{
                    if( parseFloat( $("#input-average").val() ) > 5 )
                        averageError = true
                }
                if( averageError ){
                    $("#box-average").effect( "shake", {}, 500 );
                    Materialize.toast("Revisa el promedio esperado de 0-5 con una cifra decimal", 4000, "light-blue lighten-3 z-depth-2");
                }
                return !creditsError & !gradeError & !averageError;
            }
            function addField(){
                var clickID = parseInt($(this).parent('div').parent('div').attr('id').replace('new-subjects-',''));
                var newID = (clickID + 1);

                var $newClone = $('#new-subjects-'+clickID).clone(true);

                $newClone.attr("id",'new-subjects-'+newID);

                $newClone.children('div').eq(0).children('input').eq(0).attr('id','input-credits-'+newID);
                $newClone.children('div').eq(0).children('label').eq(0).attr('for', 'input-credits-'+newID);
                $newClone.children('div').eq(1).children('div').eq(0).children('label').eq(0).children('input').eq(0).attr('id','check-grade-'+newID);
                $newClone.children('div').eq(2).children('input').eq(0).attr('id','input-grade-'+newID);
                $newClone.children('div').eq(2).children('label').eq(0).attr('for', 'input-grade-'+newID);
                $newClone.children('div').eq(3).children('a').eq(0).attr('id', 'btn-add-'+newID);
                $newClone.children('div').eq(3).children('a').eq(0).children('i').eq(0).attr('id', 'icon-add-'+newID);
                $newClone.children('div').eq(3).children('a').eq(0).children('div').eq(0).remove();
                $newClone.insertAfter($('#new-subjects-'+clickID));

                $("#icon-add-"+clickID).text('close');
                $("#btn-add-"+ clickID).unbind("click", addField);
                $("#btn-add-"+ clickID).bind("click", delRow);
            }
            function delRow() {
                $(this).parent('div').parent('div').remove();
            }
            function showPlan( plan ){
                plan = String( plan ).replace(/'/g, "");
                $("#title-record").text( String( plan ).split('\|')[1] );
                $("#papa-message").text( "PAPA actual: " + (dataCalculate[PAPA] )[ dataCalculate[PAPA].length - 1 ] );
                $("#pa-message").text( "PA actual: " + (dataCalculate[PA] )[ dataCalculate[PA].length - 1 ] );
            }

        });
        function splitDataCalculate( data ){
            var result = {};
            data = data.substring( 1 , data.length - 1 );  //To remove brackets
            var arrayData = data.split(", '&&&',");
            result[ PAPA ] = arrayData[0].split(',');
            result[ PA ] = arrayData[1].split(',');
            result[ PERIOD_NAMES ] = arrayData[2].split(',');
            result[ SUBJECTS ] = arrayData[3].split(',');
            result[ ADVANCE_COMP ] = arrayData[4].split(',');
            result[ ADVANCE ] = arrayData[5].split(',');
            result[ PLAN ] = arrayData[6].split(',');
            return result;
        }
        function removeAccent( input ){
            input = input.replace(/á/g,"a");
            input = input.replace(/é/g,"e");
            input = input.replace(/í/g,"i");
            input = input.replace(/ó/g,"o");
            input = input.replace(/ú/g,"u");
            input = input.replace(/Á/g,"A");
            input = input.replace(/É/g,"E");
            input = input.replace(/Í/g,"I");
            input = input.replace(/Ó/g,"O");
            input = input.replace(/Ú/g,"U");
            input = input.replace(/Ü/g,"U");
            input = input.replace(/ü/g,"u");
            input = input.replace(/Ñ/g,"N");
            input = input.replace(/ñ/g,"n");
            return input;
        }
        function roundAverage( avg ){
            if( avg * 10 - Math.floor( avg * 10 ) < 0.5 )
                return Math.floor( avg * 10 ) / 10;
            return Math.ceil( avg * 10 ) / 10;
        }
        function roundSubject( grade ){
            return Math.ceil( grade * 10 ) / 10;
        }
        function drawPAPA( papa, pa, periodNames ) {
            var data = new Array( papa.length + 1 );
            var max = 0;
            var min = 5;
            data[0] = new Array(3);
            data[0][0] = 'Semestre';
            data[0][1] = 'PAPA';
            data[0][2] = 'PA';
            for( i = 0; i < papa.length; i++ ) {
                papa[i] = roundAverage( papa[i] );
                pa[i] = roundAverage( pa[i] );
                max = papa[i] > max ? papa[i] : max;
                min = papa[i] < min ? papa[i] : min;
                max = pa[i] > max ? pa[i] : max;
                min = pa[i] < min ? pa[i] : min;
                data[i + 1] = new Array(3);
            }
            max = max < 4.9 ? max + 0.11 : 5;
            min = min > 0.1 ? min - 0.1 : 0;
            for (var i = 0; i < papa.length; i++){
                data[i + 1][0] = periodNames[i].replace(/'/g, "");
                data[i + 1][1] = papa[i];
                data[i + 1][2] = pa[i];
            }
            var data = new google.visualization.arrayToDataTable( data );
            var options = {
                title: 'PAPA y PA',
                titleTextStyle: {color: '#000'},
                legend: { position: 'none' },
                hAxis: { title: 'Semestre', titleTextStyle: { color: '#000'}  },
                vAxis: {
                    viewWindow: {
                        max: max,
                        min: min
                    },
                },
                colors: ['springGreen', 'dodgerBlue'],
                bar: { groupWidth: "80%" }
            };
            var chart = new google.charts.Bar( document.getElementById( 'papa-chart' ) );
            chart.draw( data, google.charts.Bar.convertOptions( options ) );
        }
        function drawPercentage( advance ) {
            var data = new Array(3);
            for( var i = 0; i < 3; i++ ) {
                data[i] = new Array(2);
            }
            data[0][0] = 'Detalle';
            data[0][1] = 'Porcentaje';
            data[1][0] = 'Avance';
            data[1][1] = advance;
            data[2][0] = 'Pendiente';
            data[2][1] = 100 - advance;

            var data = google.visualization.arrayToDataTable( data );
            var options = {
                title: 'Mi avance de carrera',
                titleTextStyle: {color: '#666'},
                pieHole: 0.1,
                slices: { 0: { color: 'springGreen' }, 1: { color: 'dodgerBlue' } },
                backgroundColor: 'transparent',
                is3D: true,
                pieSliceTextStyle: { color: '#000' }
            };
            var chart = new google.visualization.PieChart(document.getElementById('advance-chart'));
            chart.draw(data, options);
        }
        function drawComponents( advanceComp ) {
            var componentTitles = ['Fundamentación','Disciplinar','Libre elección', 'Nivelación'];
            var data = new Array(componentTitles.length + 1);
            for( var i = 0; i < componentTitles.length + 1; i++ ){
                data[i] = new Array(5);
            }
            data[0][0] = 'Componente';
            data[0][1] = 'Aprobados';
            data[0][2] = { role: 'style' };
            data[0][3] = 'Pendientes';
            data[0][4] = { role: 'style' };
            for (var i = 0; i < componentTitles.length; i++){
                data[i+1][0] = componentTitles[i];
                data[i+1][1] = parseInt( advanceComp[ i * 2 + 1 ] );
                data[i+1][2] = 'springGreen';
                data[i+1][3] = parseInt( advanceComp[ i * 2 ] - advanceComp[ i * 2 + 1 ] );
                data[i+1][4] = 'dodgerBlue';
            }
            var data = google.visualization.arrayToDataTable(data);

            var options = {
                title: 'Avance por componentes',
                titleTextStyle: {color: '#666'},
                backgroundColor: 'transparent',
                legend: { position: 'none' },
                bar: { groupWidth: '80%' },
                isStacked: 'percent',
                is3D: true
            };
            var chart = new google.visualization.ColumnChart(document.getElementById('components-chart'));
            chart.draw(data, options);
        }
        function drawTable( subjects ){
            var orderedSubjects = new Array( subjects.length );
            for (var i = 0; i < subjects.length; i++) {
                var subject = subjects[i].replace(/'/g, "");
                orderedSubjects[i] = new Array(4);
                orderedSubjects[i][0] = { v : parseFloat( subject.split('\\t')[9] ), f: '■' };
                orderedSubjects[i][1] = subject.split('\\t')[1];
                orderedSubjects[i][2] = parseInt( subject.split('\\t')[6] );
                orderedSubjects[i][3] = parseFloat( subject.split('\\t')[9] );
            }
            var dataTable = new google.visualization.DataTable();
            dataTable.addColumn( 'number', '' ); //{style: 'font-style:bold; font-size:36px; color: #f00; text-align: center;'}
            dataTable.addColumn( 'string', 'Materia' );
            dataTable.addColumn( 'number', 'Créditos' );
            dataTable.addColumn( 'number', 'Nota' );
            for (var i = 0; i < orderedSubjects.length; i++) {
                dataTable.addRows([
                    [ orderedSubjects[i][0], orderedSubjects[i][1], orderedSubjects[i][2], orderedSubjects[i][3] ]
                ]);
            }
            var table = new google.visualization.Table(document.getElementById('record-table'));
            var formatter = new google.visualization.ColorFormat();
            formatter.addRange(3.0, 5.1, 'springGreen');
            formatter.addRange(0.0, 3.0, '#ff5252');
            formatter.format( dataTable, 0 );
            table.draw( dataTable, {allowHtml: true, showRowNumber: true, width: '100%', height: '100%'} );
        }
    </g:javascript>
</body>
</html>