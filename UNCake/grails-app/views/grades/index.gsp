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
                <div class="col s6 transparent">
                    <div class="card blue-grey darken-1 z-depth-3">
                        <div class="card-content white-text">
                            <span class="card-title">Información</span>
                            <p>Selecciona la historia académica del SIA con el comando Ctrl+A, luego copiala Ctrl+C y pégala en la caja de texto que está a continuación Ctrl+V.</p>
                        </div>
                    </div>
                </div>

                <div class="col s12 transparent">
                    <div class="card white z-depth-3">
                        <br/>
                        <div id="prueba" class="input-field col s12 transparent">
                            <i class="material-icons prefix">library_books</i>
                            <textarea class="materialize-textarea transparent" id="academic-record" style="margin-top: 20px; max-height: 20em; overflow-y: auto;"></textarea>
                            <label for="academic-record" class="transparent">Historia académica</label>
                        </div><div><br/><br/><br/><br/><br/><br/><br/></div>
                        <div style="text-align: center">
                            <a class="waves-effect waves-light btn" id="calculate-papa"> Calcular </a><br/><br/><br/>
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

                <div id="information_container" style="/*display: none;*/" >
                    <div class="col s12 transparent">
                        <div class="card col s12 blue-grey darken-1 z-depth-3">
                            <div class="card-content white-text">
                                <span class="card-title" id="title-record">Información</span>
                                <p id="papa-message">Selecciona la historia académica del SIA con el comando Ctrl+A, luego copiala Ctrl+C y pégala en la caja de texto que está a continuación Ctrl+V.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col s12 transparent">
                        <div class="card col s12 white z-depth-3">
                            <div class="input-field col s12 transparent" style="text-align: center; padding: 20px;">
                                <div class="col s12" id="papa-chart" style="width: 100%; height: 500px; padding: 3%;"></div> <!-- display: inline-block; padding-top: 40px; padding-bottom: 40px; padding-right: 400px;-->
                            </div><br/>

                            <div class="col s12 transparent" style="padding-right: 80px;">
                                <div id="percentage_chart" style="width: 450px; height: 350px; float: left;  padding-left: 80px;"></div>
                                <div id="components_chart" style="width: 450px; height: 350px; float: right;"></div>
                            </div><br/>

                            <div class="col s12 transparent div-center">
                                <br/>
                                <div id="record_table" style="width: 1000px; display: inline-block;"></div><br/><br/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col s12 transparent" style="display: none;" >
                    <g:if test="${session.user != null}">
                        <g:if test="${uncake.User.findById( ( (User)session.user ).id ).academicRecord.size() > 0}">
                            <g:javascript>
                                $("#data_container").hide();
                                $("#saved_container").show();
                            </g:javascript>
                        </g:if>
                        <div class="div-center" id="container_save">
                            <input type="button" class="" id="btn_save" value="Guardar"/>
                        </div><br>
                    </g:if>

                    <div id="new-subjects" class="large-12 columns">
                        <h5 id="text-credits">Créditos:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5>
                        <input type="text" name="txtCredits" class="txtCredits" id="input-credits" placeholder="Créditos a cursar"/>
                        <h5 id="text-grade">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nota:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5>
                        <input type="checkbox" id="check-grade" name="checkNota" class="checkNota"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" name="txtNota" id="input-grade" class="txtNota" disabled="true" placeholder="Nota esperada"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" class="btn-add" id="1" value="+"/>
                    </div>

                    <div id="calculate" class="large-12 columns">
                        <br>
                        <div class="div-center">
                            <h5 id="text-expected-avg">Promedio esperado:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5>
                            <input type="text" class="txtAverage" id="text-average" style="" placeholder="Promedio"/>
                        </div>

                        <g:if test="${session.user == null}">
                            <div class="div-right">
                                <input type="button" class="btn_calculate_add" id="btn_calculate_add" value="Calcular"/>
                            </div><br/>
                        </g:if>

                        <g:else>
                            <div class="div-right">
                                <input type="button" class="btn_calculate_add_logged" id="btn_calculate_add_logged" value="Calcular"/>
                            </div><br/>
                            <g:hiddenField name="arraySubjects" id="arraySubjects" value=""></g:hiddenField>
                        </g:else>

                    </div>
                    <div class="div-center">
                        <br/><p id="newSubjectsMessage" class="div-center"></p><br/>
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

        const PAPA = 'PAPA', PA = 'PA', PERIOD_NAMES = 'period_names', SUBJECTS = 'subjects', ADVANCE_COMP = 'advance_comp', ADVANCE = 'advance';

        var dataCalculate = {};
        var dataVisible = false;

        $(function(){
            $(window).resize(function(){
                if( dataVisible )
                    drawPAPA( dataCalculate[PAPA], dataCalculate[PA], dataCalculate[PERIOD_NAMES] );
            });
            $( "#calculate-papa" ).click( function() {
                var academicRecord = removeAccent( $( "#academic-record" ).val() );
                if( academicRecord.length > 0 ){
                    $.ajax({
                        type: 'POST',
                        url: "${ createLink( action: 'calculateAcademicRecord') }",
                        data: {academicRecord: academicRecord},
                        success: function( result ){
                            $("#information_container").show();
                            dataCalculate = splitDataCalculate( result );
                            /*alert(dataCalculate[PAPA].length);
                            alert(dataCalculate[PA].length);
                            alert(dataCalculate[PERIOD_NAMES].length);*/
                            drawPAPA( dataCalculate[PAPA], dataCalculate[PA], dataCalculate[PERIOD_NAMES] );
                            dataVisible = true;
                            /*
                            input = String(input).substring( 1, String(input).length );
                            var averagesToDraw = input.split(']')[0].trim().substring(1).replace(/\[/g,"");
                            var advanceToDraw = input.split(']')[1].trim().substring(1).replace(/\[/g,"");
                            var advanceCmpToDraw = input.split(']')[2].trim().substring(1).replace(/\[/g,"").replace(/'/g,"").replace(/\\t/g,"\t");
                            var subjectsToDraw = input.split(']')[3].trim().substring(1).replace(/\[/g,"").replace(/'/g,"").replace(/\\t/g,"\t");

                            drawPercentage( parseFloat(advanceToDraw) );
                            drawComponents( advanceCmpToDraw.split(',') );
                            drawTable( subjectsToDraw.split(',') );
                            $("#container_save").hide();*/
                        }
                    });
                }else{
                    $( "#prueba" ).effect( "shake", {}, 500 );
                    Materialize.toast("Ingresa tu historia académica", 4000, "blue-grey darken-1 z-depth-3");
                }
            });
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
            data[0] = new Array(5);
            data[0][0] = 'Semestre';
            data[0][1] = 'PAPA';
            data[0][2] = { role: 'style' };
            data[0][3] = 'PA';
            data[0][4] = { role: 'style' };
            for( i = 0; i < papa.length; i++ ) {
                papa[i] = roundAverage( papa[i] );
                pa[i] = roundAverage( pa[i] );
                max = papa[i] > max ? papa[i] : max;
                min = papa[i] < min ? papa[i] : min;
                max = pa[i] > max ? pa[i] : max;
                min = pa[i] < min ? pa[i] : min;

                data[i + 1] = new Array(5);
            }
            max = max < 4.9 ? max + 0.11 : 5;
            min = min > 0.1 ? min - 0.1 : 0;
            for (var i = 0; i < papa.length; i++){
                data[i + 1][0] = periodNames[i].replace(/'/g, "");
                data[i + 1][1] = papa[i];
                data[i + 1][2] = 'springGreen';
                data[i + 1][3] = pa[i];
                data[i + 1][4] = 'dodgerBlue';
            }
            var data = new google.visualization.arrayToDataTable( data );
            var options = {
                title: 'PAPA y PA',
                legend: { position: 'none' },
                chart: { },
                axes: {
                    x: {
                        0: { side: 'bottom', label: 'Semestre'}
                    }
                },
                vAxis: {
                    viewWindow: {
                        max: max,
                        min: min
                    },
                },
                bar: { groupWidth: "70%" }
            };
            var chart = new google.charts.Bar( document.getElementById( 'papa-chart' ) );
            chart.draw( data, google.charts.Bar.convertOptions( options ) );
        }
    </g:javascript>
</body>
</html>