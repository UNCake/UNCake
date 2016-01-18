<%--
  Created by IntelliJ IDEA.
  User: alej0
  Date: 12/01/2016
  Time: 21:09
--%>

<%@ page import="uncake.User" contentType="text/html;charset=UTF-8" %>
<html>

<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>UNCake - Progreso</title>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <!--<link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'foundation/jquery-ui/jquery-ui.css')}" type="text/css">-->
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'bootstrap/css/bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'agency.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'dialogueStyle.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'grades.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'materialize/css/materialize.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'stylesheet',file:'jquery-ui/jquery-ui.css')}" type="text/css" />

    <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <style>
        .input-field label{
            color: #7986cb;
        }
        .input-field .prefix{
            color: #7986cb;
        }
        .input-field .prefix.active{
            color: #7986cb;
        }
        .input-field textarea{
            color: #779;
            border-bottom: 1px solid #7986cb;
        }
        .input-field textarea:focus + label{
            color: #000;
        }
        .collapsible-header i, .collapsible-header p{
            color: #7986cb;
        }
        /*.input-field input[type=text]:focus + label {
            color: #000;
        }
        .input-field input[type=text]:focus {
            border-bottom: 1px solid #000;
            box-shadow: 0 1px 0 0 #000;
        }*/
    </style>
</head>

<body id="grades-body" class="blue-grey lighten-5">
    <div id="replace_dialog" title="¿Reemplazar el registro?" class="dialog">
        <p><span class="ui-icon ui-icon-alert" class="dialog-body"></span>Ya tienes una historia académica guardada de esta carrera. ¿Deseas reemplazarla?</p>
    </div>
    <div id="ok_dialog" class="dialog">
        <p id="ok_msg"><span class="ui-icon ui-icon-alert" class="dialog-body"></span></p>
    </div>

    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
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
                        <li class="hidden"><a href="#page-top"></a></li>
                        <li><a class="page-scroll" href="profile"><span class="glyphicon glyphicon-user"></span>Hola ${session.user.name.split()[0]}!</a></li>
                        <li><a class="page-scroll" href="logout"><span class="glyphicon glyphicon-log-out"></span>Salir</a></li>
                    </ul>
                </div>
            </g:if>
            <g:if test="${session.user == null}">
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
                    <ul class="nav navbar-nav navbar-right">
                        <li class="hidden"><a href="#page-top"></a></li>
                        <li><a class="page-scroll" href="register"><span class="glyphicon glyphicon-user"></span>Registrarme</a></li>
                        <li><a class="page-scroll" href="login"><span class="glyphicon glyphicon-log-in"></span>Ingresar</a></li>
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
                        <div id="prueba" class="input-field col s12">
                            <i class="material-icons prefix">library_books</i>
                            <textarea class="materialize-textarea" id="academic-record"></textarea>
                            <label for="academic-record">Historia académica</label>
                        </div><div><br/><br/><br/><br/><br/><br/><br/></div>
                        <div style="text-align: center">
                            <a class="waves-effect waves-light btn light-blue lighten-3" id="calculate-papa"> Calcular </a><br/><br/><br/>
                        </div>
                    </div>
                </div><br/>

                <div class="row" id="saved_container">
                    <p id="saved-msj">Tienes historias académicas almacenadas ¿quieres ver una previamente guardada crear una nueva?</p>
                    <g:if test="${session.user != null}">
                        <g:if test="${uncake.User.findById( ((User)session.user).id ).academicRecord.size() > 0}">
                            <g:set var="records" value="[]"/>
                            <g:each in="${uncake.User.findById( ((User)session.user).id ).academicRecord}">
                                <g:each in="${it.studyPlan}" var="studyPlan">
                                    <div style="display: none;">${records.add(studyPlan.code + " | " + studyPlan.name)}</div>
                                </g:each>
                            </g:each>
                            <div>
                                <g:select id="recordSelector" name="${records}" from="${records}" noSelection="['':'-Selecciona una historia académica-']"/>
                            </div><br/>
                            <input type="button" id="loadRecord" name="loadRecord" value="Cargar" />
                            <input type="button" id="newRecord" name="newRecord" value="Nueva" />
                        </g:if>
                    </g:if><br/><br/>
                </div>

                <div id="information_container" style="display: none;">
                    <div id="record-title" class="col s12 transparent">
                        <div class="card col s12 indigo lighten-2 z-depth-2">
                            <div class="card-content white-text">
                                <span class="card-title" id="title-record"></span>
                                <p id="papa-message"></p>
                                <p id="pa-message"></p>
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
                </div>

                <div class="col s12 transparent" style="/*display: none;*/" >
                    <div class="card col s12 white z-depth-2">
                        <div id="new-subjects-1" class="center-align" style=" padding-bottom: 6em;">
                            <br/>
                            <div class="input-field col s4">
                                <i class="material-icons prefix">schedule</i>
                                <input placeholder="Créditos a cursar" id="input-credits-1" type="text" class="validate">
                                <label for="input-credits-1">Créditos</label>
                            </div>

                            <div class="input-field col s2 center-align">
                                <div class="switch">
                                    <label>
                                        Nota&nbsp;&nbsp;&nbsp;
                                        <input type="checkbox" id="check-grade-1">
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </div>

                            <div class="input-field col s4">
                                <i class="material-icons prefix">done_all</i>
                                <input placeholder="Nota esperada" id="input-grade-1" type="text" class="validate">
                                <label for="input-grade-1">Nota esperada</label>
                            </div>
                            <div class="input-field col s2">
                                <a id="btn-add-1" class="btn-add btn-floating btn-medium waves-effect waves-light light-blue lighten-3"><i id="icon-add-1" class="material-icons">add</i></a>
                            </div>
                        </div>
                    </div>

                    <g:if test="${session.user != null}">
                        <g:if test="${uncake.User.findById( ( (User)session.user ).id ).academicRecord.size() > 0}">
                            <g:javascript>
                                $("#saved_container").show();
                            </g:javascript>
                        </g:if>
                        <div class="div-center" id="container_save">
                            <input type="button" class="" id="btn_save" value="Guardar"/>
                        </div><br>
                    </g:if>

                    <div class="card col s12 white z-depth-2">
                        <div id="calculate" class="col s12 columns" style=" padding-bottom: 1em;">
                            <br>
                            <div class="input-field col s4 offset-s2">
                                <i class="material-icons prefix">trending_up</i>
                                <input placeholder="PAPA que esperas obtener" id="input-average" type="text" class="validate">
                                <label for="input-average">Promedio esperado</label>
                            </div>
                            <div class="input-field col s2 right-align">
                                <a class="waves-effect waves-light btn light-blue lighten-3" id="btn-calculate-add"> Calcular </a>
                            </div>
                        </div>
                    </div>
                    <div class="div-center" style="display: none">
                        <p id="newSubjectsMessage" class="div-center"></p>
                    </div>
                </div>

            </div>
        </div>
    <div/>
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="jquery-ui/jquery-ui.js"/>
    <asset:javascript src="materialize/js/materialize.js"/>
    <g:javascript>
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
                                $( "#prueba" ).effect( "shake", {}, 500 );
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
                    $( "#prueba" ).effect( "shake", {}, 500 );
                    Materialize.toast("Ingresa tu historia académica", 4000, "light-blue lighten-3 z-depth-2");
                }
            });
            $(".btn-add").each(function (){
                $(this).bind("click",addField);
            });

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