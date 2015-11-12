<%--
  Created by IntelliJ IDEA.
  User: alej0
  Date: 11/10/2015
  Time: 18:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>UNCake - Progreso</title>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <asset:stylesheet src="foundation/foundation.css"/>
    <asset:stylesheet src="foundation/jquery-ui/jquery-ui.css"/>
    <asset:javascript src="foundation/vendor/modernizr.js"/>
    <asset:javascript src="foundation/vendor/jquery.js"/>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
    </script>
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
            <div class="large-12 columns">
                <div class="row" >
                    <div class="large-12 columns">
                        <div class="panel" style="background-color: #f7f7f7;padding-left: 36px;padding-right: 36px; border-radius: 5px; border: solid 1px; border-color: #a0a0a0;">
                            <div class="row">
                                <p style="text-align: left; display: inline-block;">Selecciona la historia académica del SIA con el comando Ctrl+A, luego copiala Ctrl+C y pégala en la caja de texto que está a continuación Ctrl+V.</p>
                                <g:textArea name="academicHistory" id="academicRecord" value="" rows="8" cols="40" style="background-color: #ffffff; border-radius: 5px; border: solid 1px; border-color: #a0a0a0"></g:textArea>
                                <g:submitButton name="calculatePAPA" value="Calcular" action="calculatePAPA"></g:submitButton>
                            </div>

                            <div class="row" id="information_container" style="display: none;" ><!--style="display: none; background-color: white; border-radius: 5px;">-->
                                <br/>
                                <div style="background-color: white; text-align: center; border-radius: 5px; border: solid 1px; border-color: #a0a0a0;">
                                    <div id="papa_chart" style="width: 800px; height: 500px; display: inline-block; padding-top: 40px; padding-bottom: 40px;"></div>
                                </div>
                                <br/>
                                <div class="large-12 columns" style="background-color: white; text-align: center; border-radius: 5px; border: solid 1px; border-color: #a0a0a0;">
                                    <div class="large-6 columns">
                                        <div id="percentage_chart" style="width: 450px; height: 350px"></div>
                                    </div>
                                    <div class="large-6 columns">
                                        <div id="components_chart" style="width: 450px; height: 350px"></div>
                                    </div>
                                </div>
                                <br/>
                                <div class="large-12 columns" style="text-align: center;">
                                    <br/>
                                    <div id="record_table" style="width: 900px; display: inline-block;"></div>
                                    <br/><br/>
                                </div>
                                <div id="new_subjects_1" class="large-12 columns" style="align-content: center; text-align: center;">
                                    <h5 style="line-height: 30px; display: inline-block; vertical-align: middle;">Créditos:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5>
                                    <input type="text" name="txtCredits" class="txtCredits" id="txtCredits_1" style="width: 200px; display: inline-block;" placeholder="Créditos a cursar"/>
                                    <h5 style="line-height: 30px; display: inline-block;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nota:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5>
                                    <input type="checkbox" id="checkNota_1" name="checkNota" class="checkNota" style="line-height: 30px; display: inline-block;" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="text" name="txtNota" id="txtNota_1" class="txtNota" disabled="true" placeholder="Nota esperada" style=" width: 200px; display: inline-block;"/>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="button" class="btn_add" id="1" value="+" style="height: 45px; width: 50px; display: inline-block;"/>
                                </div>
                                <div id="calculate" class="large-12 columns">
                                    <br>
                                    <div style="text-align: center;" >
                                        <h5 style="line-height: 30px; display: inline-block; vertical-align: middle;">Promedio esperado:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5>
                                        <input type="text" class="txtAverage" id="txtAverage" style="width: 200px; display: inline-block;" placeholder="Promedio"/>
                                    </div>
                                    <div style="text-align: right;">
                                        <input type="button" class="btn_calculate_add" id="btn_calculate_add" value="Calcular"/>
                                    </div>
                                    <br/>
                                </div>
                                <div style="text-align: center;">
                                    <br/>
                                    <p id="newSubjectsMessage" style="text-align: center;"></p>
                                    <br/>
                                </div>
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
$(function(){
    $( ".checkNota" ).on( "click", function() {
        var checkID = parseInt($(this).attr('id').replace('checkNota_',''));
        $( "#txtNota_" + checkID )[0].disabled = true;
        $( "#txtNota_" + checkID ).val('');
        if( $( "#checkNota_" + checkID ).is(":checked") ){
            $( "#txtNota_" + checkID )[0].disabled = false;
        }
    });
    $(".btn_add").button ();
    $(".btn_add").each(function (){
        $(this).bind("click",addField);
    });
    $( "#btn_calculate_add" ).button().click( function() {
        var calculate = true;
        var typedCredits = [];
        var typedGrades = [];
        var expectedPAPA = 0;
        $('.txtCredits').each( function() {
            if( $(this).val() == '' || !$(this).val().match(/[1-9][0-9]?[0-9]?/g) ){
                $(this).focus();
                $(this).effect( "pulsate", {}, 300 );
                calculate = false;
            }else{
                typedCredits.push( parseInt( $(this).val() ) );
            }
        });
        $('.txtNota').each( function() {
            if( $(this).val() != '' ){
                if( !$(this).val().match(/[0-4](?:\.[0-9])?/g) && !$(this).val().match(/5/g) ){
                    $(this).focus();
                    $(this).effect( "pulsate", {}, 300 );
                    calculate = false;
                }else{
                    typedGrades.push( parseFloat( $(this).val() ) );
                }
            }else{
                typedGrades.push( -1 );
            }
        });
        $('.txtAverage').each( function() {
            if( $(this).val() == '' ){
                $(this).focus();
                $(this).effect( "pulsate", {}, 300 );
                calculate = false;
            }
            if( $(this).val() != '' ){
                if( !$(this).val().match(/[0-4](?:\.[0-9])?/g) && !$(this).val().match(/5/g) ){
                    $(this).focus();
                    $(this).effect( "pulsate", {}, 300 );
                    calculate = false;
                }else{
                    expectedPAPA = parseFloat( $(this).val() ) - 0.05;
                }
            }
        });
        var gradeCredits = 0;
        var grades = 0;
        var ungradeCredits = 0;
        var ungradeSubjects = 0, gradeSubjects = 0;
        if( calculate == true ){
            var history = document.getElementById('academicRecord').value;
            var sums = getSums( history );
            for( var i = 0; i < typedGrades.length; i++ ){
                if( typedGrades[i] == -1 ){
                    ungradeCredits += typedCredits[i];
                    ungradeSubjects += 1;
                }else{
                    gradeCredits += typedCredits[i];
                    grades += typedCredits[i] * typedGrades[i];
                    gradeSubjects += 1;
                }
            }
            var plannedPAPA = (sums[0] + grades) / (sums[1] + gradeCredits);
            var gradeNeeded = 0;
            if( ungradeSubjects > 0 ){
                gradeNeeded = ( expectedPAPA *( sums[1] + ungradeCredits + gradeCredits) - plannedPAPA*( sums[1] + gradeCredits ) ) / ungradeCredits;
                if( gradeNeeded <= 5 ) {
                    $('#newSubjectsMessage').css('color', 'black');
                    if( ungradeSubjects > 1 )
                        $('#newSubjectsMessage').text('La nota mínima requerida en las ' + ungradeSubjects + ' asignaturas para tener el PAPA en ' + (expectedPAPA + 0.05) + ' es de: ' + ( Math.ceil(gradeNeeded * 10) / 10.0 ));
                    else
                        $('#newSubjectsMessage').text('La nota mínima requerida en la asignatura para tener el PAPA en ' + (expectedPAPA + 0.05) + ' es de: ' + ( Math.ceil(gradeNeeded * 10) / 10.0 ));
                }else{
                    $('#newSubjectsMessage').css('color', 'red');
                    if( ungradeSubjects > 1 )
                        $('#newSubjectsMessage').text('La nota mínima requerida en las ' + ungradeSubjects + ' asignaturas para tener el PAPA en ' + (expectedPAPA + 0.05) + ' es mayor a 5, exactamente es: ' + ( Math.ceil(gradeNeeded * 10) / 10.0 ));
                    else
                        $('#newSubjectsMessage').text('La nota mínima requerida en la asignatura para tener el PAPA en ' + (expectedPAPA + 0.05) + ' es mayor a 5, exactamente es: ' + ( Math.ceil(gradeNeeded * 10) / 10.0 ));
                }
            }else{
                $('#newSubjectsMessage').css('color', 'black');
                if( gradeSubjects > 1 )
                    $('#newSubjectsMessage').text('El PAPA obtenido cursando las ' + ungradeSubjects + ' asignaturas con las notas asignadas es de: ' + ( Math.ceil(plannedPAPA * 10) / 10.0 ) );
                else
                    $('#newSubjectsMessage').text('El PAPA obtenido cursando la asignatura con la nota asignada es de: ' + ( Math.ceil(plannedPAPA * 10) / 10.0 ) );
            }
        }
    });
    $( "#calculatePAPA" ).button().click( function() {
        $("#information_container").show();
        var history = document.getElementById('academicRecord').value;
        var periods = splitPeriods( history );
        var averages = [];
        for( var i = 0; i < periods.length; i++ ){
            averages.push( calculatePAPA(periods[i] )[0] );
            averages.push( calculatePAPA(periods[i] )[1] );
        }
        averages.push( calculatePAPA( history )[0] );
        averages.push( calculatePAPA( history )[1] );
        drawPAPA(averages);
        drawPercentage( getPercentage( history ) );
        drawComponents( getComponents( history ) );
        drawTable( getSubjects( history ) );
    });
    function getComponents( input ){
        var requiredPattern = /exigidos\t[0-9]+\t[0-9]+\t[0-9]+\t[0-9]+\t[0-9\-]+\t[0-9]+/i;
        var passedPattern = /aprobados plan\t[0-9]+\t[0-9]+\t[0-9]+\t[0-9]+\t[0-9\-]+\t[0-9]+/i;
        var component = String( requiredPattern.exec(input) );
        var components = [];
        components.push( component );
        component = String( passedPattern.exec(input) );
        components.push( component );
        return components;
    }
    function getPercentage( input ){
        var percentagePattern = /[0-9]+\.[0-9]+%\n+% de avance/i;
        var textPercentage = String( percentagePattern.exec(input) );
        var percentage = parseFloat( textPercentage.substring( 0, textPercentage.indexOf('%') ) );
        return percentage;
    }
    function calculatePAPA( input ){
        var subjectPattern = /[0-9][A-Z\-0-9]*[\t][A-Za-záéíóúüÁÉÍÓÚÜ:\.\- ]+[\t][0-9]+[\t][0-9]+[\t][0-9]+[\t][A-Z][\t][0-9]+[\t][0-9]+[\t]+[0-9]\.?[0-9]/i;
        var subjects = [];
        var subjectsAux;
        var sumSubjects = 0.0;
        var sumCredits = 0;
        var subject;
        var averages = [];
        var historySoFar = input;
        while( subjectPattern.test(historySoFar) ) {
            subject = String( subjectPattern.exec(historySoFar) );
            sumSubjects += parseFloat( subject.split('\t')[9] ) * parseInt( subject.split('\t')[6] );
            sumCredits += parseInt( subject.split('\t')[6] );
            subjects.push(subject);
            historySoFar = historySoFar.replace(subject, "");
        }
        averages.push( sumSubjects / sumCredits );
        subjectsAux = subjects;
        for( var i = 0; i < subjects.length - 1; i++ ){
            for( var j = i + 1; j < subjects.length; j++ ){
                if( subjects[i].split('\t')[0].valueOf() == subjects[j].split('\t')[0].valueOf() ){
                    subjectsAux.splice(i, 1);
                }
            }
        }
        sumSubjects = 0.0;
        sumCredits = 0;
        for( var i = 0; i < subjectsAux.length; i++ ){
            sumSubjects += parseFloat( subjectsAux[i].split('\t')[9] ) * parseInt( subjectsAux[i].split('\t')[6] );
            sumCredits += parseInt( subjectsAux[i].split('\t')[6] );
        }
        averages.push( sumSubjects / sumCredits );
        return averages;
    }
    function getSums( input ){
        var subjectPattern = /[0-9][A-Z\-0-9]*[\t][A-Za-záéíóúüÁÉÍÓÚÜ:\.\- ]+[\t][0-9]+[\t][0-9]+[\t][0-9]+[\t][A-Z][\t][0-9]+[\t][0-9]+[\t]+[0-9]\.?[0-9]/i;
        var subjects = [];
        var subjectsAux;
        var sumSubjects = 0.0;
        var sumCredits = 0;
        var subject;
        var historySoFar = input;
        var output = []
        while( subjectPattern.test(historySoFar) ) {
            subject = String( subjectPattern.exec(historySoFar) );
            sumSubjects += parseFloat( subject.split('\t')[9] ) * parseInt( subject.split('\t')[6] );
            sumCredits += parseInt( subject.split('\t')[6] );
            subjects.push(subject);
            historySoFar = historySoFar.replace(subject, "");
        }
        output.push( sumSubjects );
        output.push( sumCredits );
        subjectsAux = subjects;
        for( var i = 0; i < subjects.length - 1; i++ ){
            for( var j = i + 1; j < subjects.length; j++ ){
                if( subjects[i].split('\t')[0].valueOf() == subjects[j].split('\t')[0].valueOf() ){
                    subjectsAux.splice(i, 1);
                }
            }
        }
        sumSubjects = 0.0;
        sumCredits = 0;
        for( var i = 0; i < subjectsAux.length; i++ ){
            sumSubjects += parseFloat( subjectsAux[i].split('\t')[9] ) * parseInt( subjectsAux[i].split('\t')[6] );
            sumCredits += parseInt( subjectsAux[i].split('\t')[6] );
        }
        output.push( sumSubjects );
        output.push( sumCredits );
        return output;
    }
    function getSubjects( input ){
        var subjectPattern = /[0-9][A-Z\-0-9]*[\t][A-Za-záéíóúüÁÉÍÓÚÜ:\.\- ]+[\t][0-9]+[\t][0-9]+[\t][0-9]+[\t][A-Z][\t][0-9]+[\t][0-9]+[\t]+[0-9]\.?[0-9]/i;
        var subjects = [];
        var subject;
        var historySoFar = input;
        while( subjectPattern.test(historySoFar) ) {
            subject = String( subjectPattern.exec(historySoFar) );
            subjects.push(subject);
            historySoFar = historySoFar.replace(subject, "");
        }
        return subjects;
    }
    function splitPeriods( input ){
        var periodPattern = /[0-9]+[\t]periodo académico[ ]*\|[ ]*[0-9\-A-Z]+/i;
        var periods = [];
        var periodNames = [];
        var periodName;
        var historySoFar = input;
        periodName = String( periodPattern.exec(historySoFar) );
        periodNames.push(periodName);
        historySoFar = historySoFar.replace(periodName, "");
        while( periodPattern.test(historySoFar) ) {
            periodName = String( periodPattern.exec(historySoFar) );
            periodNames.push(periodName);
            periods.push( historySoFar.substring( 0, historySoFar.indexOf(periodName) ) );
            historySoFar = historySoFar.replace( periodName, "" );
        }

        return periods;
    }
});

google.load("visualization", "1.1", {packages:["bar", "corechart", "imagebarchart", "table"]});

function drawPAPA( averages ) {
    var data = new Array(averages.length/2 + 1);
    var max = 0;
    var min = 5;
    var maxGraph;
    var minGraph;
    var adjustedAverages = [];
    for( i = 0; i < averages.length; i++ ) {
        if( averages[i]*10 - Math.floor(averages[i]*10) < 0.5 )
            adjustedAverages[i] = Math.floor( averages[i]*10 ) / 10;
        else
            adjustedAverages[i] = Math.ceil( averages[i]*10 ) / 10;
        if( adjustedAverages[i] > max )
            max = adjustedAverages[i];
        if( adjustedAverages[i] < min )
            min = adjustedAverages[i];
    }
    maxGraph = max < 4.9 ? max + 0.11 : 5;
    minGraph = min > 0.1 ? min - 0.1 : 0;
    for( i = 0; i < averages.length/2 + 1; i++ ) {
        data[i] = new Array(5);
    }
    data[0][0] = 'Semestre';
    data[0][1] = 'PAPA';
    data[0][2] = { role: 'style' };
    data[0][3] = 'PA';
    data[0][4] = { role: 'style' };

    for (var i = 0; i < averages.length/2; i++){
        data[i+1][0] = String( i + 1 );
        data[i+1][1] = adjustedAverages[i * 2];
        data[i+1][2] = 'springGreen';
        data[i+1][3] = adjustedAverages[i * 2 + 1];
        data[i+1][4] = 'dodgerBlue';
    }
    var data = new google.visualization.arrayToDataTable(
        data
    );
    var options = {
        title: 'PAPA y PA',
        width: 800,
        legend: { position: 'none' },
        chart: { },
        axes: {
            x: {
                0: { side: 'bottom', label: 'Semestre'}
            }
        },
        vAxis: {
            viewWindow: {
                max: maxGraph,
                min: minGraph
            },
        },
        bar: { groupWidth: "70%" }
    };
    var chart = new google.charts.Bar(document.getElementById('papa_chart'));
    chart.draw(data, google.charts.Bar.convertOptions(options));
}

function drawPercentage( percentaje ) {
    var data = new Array(3);
    for( var i = 0; i < 3; i++ ) {
        data[i] = new Array(2);
    }
    data[0][0] = 'Detalle';
    data[0][1] = 'Porcentaje';
    data[1][0] = 'Avance';
    data[1][1] = percentaje;
    data[2][0] = 'Pendiente';
    data[2][1] = 100 - percentaje;

    var data = google.visualization.arrayToDataTable(
        data
    );

    var options = {
        title: 'Mi avance de carrera',
        pieHole: 0.1,
        width: 450,
        height: 350,
        slices: {
            0: { color: 'springGreen' },
            1: { color: 'dodgerBlue' }
        },
        backgroundColor: 'transparent',
        is3D: true,
        pieSliceTextStyle: {
            color: 'black',
        }
    };

    var chart = new google.visualization.PieChart(document.getElementById('percentage_chart'));
    chart.draw(data, options);
}
function drawComponents( components ) {
    var componentTitles = ['Fundamentación','Disciplinar','Libre elección'];
    var data2 = new Array(componentTitles.length + 1);
    var componentValues = new Array(components.length);
    for (var i = 0; i < componentTitles.length + 1; i++) {
        data2[i] = new Array(5);
    }
    for (var i = 0; i < components.length; i++) {
        componentValues[i] = new Array(3);
        for (var j = 0; j < componentValues[i].length; j++) {
            componentValues[i][j] = components[i].split('\t')[j+1];
        }
    }

    data2[0][0] = 'Componente';
    data2[0][1] = 'Aprobados';
    data2[0][2] = { role: 'style' };
    data2[0][3] = 'Pendientes';
    data2[0][4] = { role: 'style' };

    for (var i = 0; i < componentTitles.length; i++){
        data2[i+1][0] = componentTitles[i];
        data2[i+1][1] = parseInt( componentValues[1][i] );
        data2[i+1][2] = 'springGreen';
        data2[i+1][3] = parseInt( componentValues[0][i] - componentValues[1][i] );
        data2[i+1][4] = 'dodgerBlue';
    }
    var data2 = google.visualization.arrayToDataTable(data2);

    var options2 = {
        title: 'Avance por componentes',
        width: 450,
        height: 350,
        backgroundColor: 'transparent',
        legend: { position: 'none' },
        bar: { groupWidth: '70%' },
        isStacked: 'percent',
        is3D: true
    };
    var chart2 = new google.visualization.ColumnChart(document.getElementById('components_chart'));
    chart2.draw(data2, options2);
}
function drawTable( subjects ){
    var orderedSubjects = new Array( subjects.length );
    for (var i = 0; i < subjects.length; i++) {
        orderedSubjects[i] = new Array(3);
        orderedSubjects[i][0] = subjects[i].split('\t')[1];
        orderedSubjects[i][1] = parseInt( subjects[i].split('\t')[6] );
        orderedSubjects[i][2] = parseFloat( subjects[i].split('\t')[9] );
    }
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn( 'string', 'Materia', {style: 'font-style:bold; font-size:36px;'} );
    dataTable.addColumn( 'number', 'Créditos', {style: 'font-style:bold; font-size:36px;'} );
    dataTable.addColumn( 'number', 'Nota', {style: 'font-style:bold; font-size:36px;'} );
    for (var i = 0; i < orderedSubjects.length; i++) {
        dataTable.addRows([
            [ orderedSubjects[i][0], orderedSubjects[i][1], orderedSubjects[i][2] ]
        ]);
    }
    var table = new google.visualization.Table(document.getElementById('record_table'));
    table.draw(dataTable, {showRowNumber: true, width: '100%', height: '100%'});
}
function addField(){
    var clickID = parseInt($(this).parent('div').attr('id').replace('new_subjects_',''));
    var newID = (clickID + 1);

    $newClone = $('#new_subjects_'+clickID).clone(true);
    $newClone.attr("id",'new_subjects_'+newID);

    $newClone.children("input").eq(0).attr("id",'txtCredits_' + newID);
    $newClone.children("input").eq(1).attr("id",'checkNota_' + newID);
    $newClone.children("input").eq(2).attr("id",'txtNota_' + newID);
    $newClone.children("input").eq(3).attr("id",newID);

    $newClone.insertAfter($('#new_subjects_'+clickID));

    $("#" + clickID).val('-').unbind("click",addField);
    $("#" + clickID).bind("click",delRow);
}
function delRow() {
    $(this).parent('div').remove();
}
</g:javascript>
<script>
    $(document).foundation();
    var doc = document.documentElement;
    doc.setAttribute('data-useragent', navigator.userAgent);
</script>
</body>
</html>
