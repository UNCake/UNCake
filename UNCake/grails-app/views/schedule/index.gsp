<%--
  Created by IntelliJ IDEA.
  User: anmrdz
  Date: 10/18/15
  Time: 6:42 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ defaultCodec="none" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="schedule.css"/>

    <style>
    .ui-autocomplete {

        max-height: 100px;
        overflow-y: auto;
        /* prevent horizontal scrollbar */
        overflow-x: hidden;
    }

    /* IE 6 doesn't support max-height
     * we use height instead, but this forces the menu to always be this tall
     */
    * html .ui-autocomplete {
        height: 100px;
    }
    </style>

    <script>
        $(function () {
            var availableTags = $.parseJSON('${lista.encodeAsJSON()}');

            $("#plans").autocomplete({
                source: availableTags
            });
        });
    </script>




    <title>Creación de horarios</title>
</head>


<body>

<nav class="navbar navbar-default navbar-fixed-top">
    <div class="navbar-header page-scroll">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand page-scroll" href="#page-top">UNCake</a>
    </div>
</nav>


<div class="column filter">
    <div class="ui-widget">
        <label for="plans">Planes:</label>
        <input id="plans">
    </div>
</div>
<div class="column schedule">
    <p>tabla de horario</p>
</div>
<div class="column selectedC">
    <p> Materias seleccionadas</p>
</div>

</body>
</html>