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
            var urlSIA = ""
            var updatePlans = function (event, ui) {
                var url = "${createLink(controller:'Schedule', action:'searchByLoc')}";
                var selLoc = $("#loc").val();
                var response = $.ajax({
                    url: url,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: {
                        selectedLoc: selLoc,
                        type: $("#menuTypePlan").val()
                    },
                    success: function (plans) {
                        $("#plans").autocomplete("option", "source", plans);
                    },

                    error: function (request, status, error) {
                        alert(error)
                    }
                });
            }

            var updateUrlSIA = function(){
                var url = "${createLink(controller:'Schedule', action:'geturlSIA')}";
                var response = $.ajax({
                    url: url,
                    contentType: "application/text; charset=utf-8",
                    dataType: "text",
                    data: { selectedLoc: $("#loc").val()},
                    success: function (sia) { urlSIA = sia },
                    error: function (request, status, error) {
                        alert(error)
                    }
                });
            }

            var updateCourses = function (event, ui) {
                var url = "${createLink(controller:'Schedule', action:'searchCourses')}";

                var response = $.ajax({
                    url: url,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    crossDomain: true,
                    data: {
                        selectedLoc: $("#loc").val(),
                        studyplan: $("#plans").val(),
                        name: $("#course").val(),
                        type: $("#menuTypePlan").val()
                    },
                    success: function (courses) {
                        var resList = courses
                        var html = ''
                        for (item in resList) {
                            html += '<li class="ui-widget-content">' + resList[item] + '</li>';
                        }
                        $('#selectable').append(html);
                    },
                    error: function (request, status, error) {
                        alert(error)
                    }
                });
            }

            $("#plans").autocomplete({
                source: [],
                select: function (event, ui) {
                    $("#plans").val(ui.item.label);
                    updateCourses();
                }

            });


            $("#loc").autocomplete({
                source: $.parseJSON('${locs.encodeAsJSON()}'),
                select: function(event, ui) {
                    $("#loc").val(ui.item.label);
                    updatePlans();
                }
            });

            $("#menuType").selectmenu();

            $("#menuTypePlan").selectmenu({
                change: updatePlans
            });

            $("#selectable").selectable();


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

    <label for="menuTypePlan">Tipo:</label>

    <div class="ui-menu-item">
        <select name="menuTypePlan" id="menuTypePlan">
            <option value="PRE" selected="selected">Pregrado</option>
            <option value="POS">Posgrado</option>
        </select>
    </div>

    <label for="plans">Planes:</label>

    <div class="ui-widget">
        <input id="plans">
    </div>


    <label for="menuType">Tipología:</label>

    <div class="ui-menu-item">
        <select name="menuType" id="menuType">
            <option>Fundamentación</option>
            <option>Libre elección</option>
            <option selected="selected">Disciplinar</option>
        </select>
    </div>

    <label for="course">Materia:</label>

    <div class="ui-widget">
        <input id="course">
    </div>

    <div class="selectablemenu">
        <ol id="selectable">
        </ol>
    </div>

</div>

<div class="column schedule">
    <p>tabla de horario</p>
</div>

<div class="column selectedC">
    <p>Materias seleccionadas</p>
</div>

</body>
</html>