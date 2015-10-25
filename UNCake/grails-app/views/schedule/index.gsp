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

    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="foundation/jquery-ui/jquery-ui.js"/>
    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="schedule.css"/>
    <asset:stylesheet src="foundation/jquery-ui/jquery-ui.css"/>

    <script>
    $(function () {

        $("#plans").autocomplete({
            source: $.parseJSON('${plans.encodeAsJSON()}')
        });

        $("#loc").autocomplete({
            source: $.parseJSON('${locs.encodeAsJSON()}')
        });

        $( "#menuTipologia" ).menu();

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

    <label for="loc">Sede:</label>
    <div class="ui-widget">
        <input id="loc">
    </div>

    <label>Tipo:</label>
    <div id="typePlan">
        <input type="checkbox" id="pre"><label for="pre">Pregrado</label>
        <input type="checkbox" id="pos"><label for="pos">Posgrado</label>
    </div>

    <label for="plans">Planes:</label>
    <div class="ui-widget">
        <input id="plans">
    </div>

    <label>Tipologia:</label>
    <ul id="menuTipologia">
        <li>Fundamentacion</li>
        <li>Libre eleccion</li>
        <li>Disciplinar</li>
    </ul>

</div>

<div class="column schedule">
    <p>tabla de horario</p>
</div>

<div class="column selectedC">
    <p>Materias seleccionadas</p>
</div>

</body>
</html>