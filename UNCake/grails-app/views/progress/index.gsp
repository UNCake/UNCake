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
                            <h1><a href="#">UNCake</a></h1>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="large-12 columns">
                <div class="row">
                    <div class="large-12 columns">
                        <div class="panel" style="padding-left: 32px;padding-right: 32px;">
                            <div class="row">
                                <g:textArea name="academicHistory" id="academicRecord" value="" rows="8" cols="40" style="background-color: #ffffff; border-radius: 5px; border: solid 1px; border-color: #a0a0a0"></g:textArea>
                                <g:submitButton name="calculatePAPA" value="Calcular" action="calculatePAPA"></g:submitButton>
                            </div>
                            <div class="row">
                                <br/>
                                <div id="papa_chart" style="width: 900px; height: 500px;"></div>
                                <div id="percentage_chart" style="width: 400px; height: 300px"></div>
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
$(function() {
    $( "#calculatePAPA" ).button().click( function() {
        var history = document.getElementById('academicRecord').value;
        var periods = splitPeriods( history );
        var averages = [];
        for( var i = 0; i < periods.length; i++ ){
            averages.push( calculatePAPA(periods[i] )[0] );
            averages.push( calculatePAPA(periods[i] )[1] );
        }
        averages.push( calculatePAPA( history )[0] );
        averages.push( calculatePAPA( history )[1] );
        drawPercentage( getPercentage( history ) );
        drawPAPA(averages);
    });
    function getPercentage( input ){
        var percentagePattern = /[0-9]+\.[0-9]+%\n+% de avance/i;
        var textPercentage = String( percentagePattern.exec(input) );
        var percentage = parseFloat( textPercentage.substring( 0, textPercentage.indexOf('%') ) );
        return percentage;
    }
    function calculatePAPA( input ){
        var subjectPattern = /[0-9][A-Z\-0-9]*[\t][A-Za-záéíóúüÁÉÍÓÚÜ\- ]+[\t][0-9]+[\t][0-9]+[\t][0-9]+[\t][A-Z][\t][0-9]+[\t][0-9]+[\t]+[0-9]\.?[0-9]/i;
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
        var sumSubjects = 0.0;
        var sumCredits = 0;
        for( var i = 0; i < subjectsAux.length; i++ ){
            sumSubjects += parseFloat( subjectsAux[i].split('\t')[9] ) * parseInt( subjectsAux[i].split('\t')[6] );
            sumCredits += parseInt( subjectsAux[i].split('\t')[6] );
        }
        averages.push( sumSubjects / sumCredits );
        return averages;
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

google.load("visualization", "1.1", {packages:["bar"]});
google.load("visualization", "1", {packages:["corechart"]});

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
        data[i] = new Array(3);
    }
    data[0][0] = 'Semestre';
    data[0][1] = 'PAPA';
    data[0][2] = 'PA';
    for (var i = 0; i < averages.length/2; i++){
        data[i+1][0] = String( i + 1 );
        data[i+1][1] = adjustedAverages[i * 2];
        data[i+1][2] = adjustedAverages[i * 2 + 1];
    }
    var data = new google.visualization.arrayToDataTable(
        data
    );
    var options = {
        title: 'PAPA y PA',
        width: 900,
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
            }
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
        slices: {
            0: { color: 'springGreen' },
            1: { color: 'dodgerBlue' }
        },
        backgroundColor: 'transparent',
        is3D: true,
        pieSliceTextStyle: {
            color: 'black',
        }
        /*slices: {  4: {offset: 0.2},
            1: {offset: 0.3},
            2: {offset: 0.4}
        }*/
    };

    var chart = new google.visualization.PieChart(document.getElementById('percentage_chart'));
    chart.draw(data, options);
}
</g:javascript>
<script>
    $(document).foundation();
    var doc = document.documentElement;
    doc.setAttribute('data-useragent', navigator.userAgent);
</script>
</body>
</html>
