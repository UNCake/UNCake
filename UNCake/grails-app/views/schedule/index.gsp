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

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <asset:javascript src="html2canvas.js"/>
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:javascript src="bootstrap/js/bootstrap.min.js"/>
    <asset:stylesheet src="agency.css"/>
    <asset:javascript src="foundation/jquery-ui/jquery-ui.js"/>
    <asset:stylesheet src="schedule.css"/>
    <asset:stylesheet src="foundation/jquery-ui/jquery-ui.css"/>
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>

    <script>
        $(function () {
            var courses
            var groups = {}
            var schedule = {}
            var days = $.parseJSON('${days.encodeAsJSON()}')

            for (var i = 6; i <= 21; i++) {
                $("#scheduleTable").append('<tr id="r' + i + '"><th>' + i + '</th></tr>')
                for (var j = 0; j < 7; j++) {
                    $("#scheduleTable #r" + i).append($('<td>', {id: i * j}))
                }
            }

            var updatePlans = function () {
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

            var updateCourses = function () {
                var url = "${createLink(controller:'Schedule', action:'searchCourses')}";

                var response = $.ajax({
                    url: url,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    crossDomain: true,
                    data: {
                        selectedLoc: $("#loc").val(),
                        studyplan: $("#plans").val(),
                        type: $("#menuTypePlan").val()
                    },
                    success: function (resCourses) {
                        courses = resCourses
                        $('#selectable').empty();
                        $.each(courses, function (key, value) {
                            $('#selectable')
                                    .append($('<li>', {value: key})
                                            .text(value.code + " " + value.name));
                        });
                    },
                    error: function (request, status, error) {
                        alert(error)
                    }
                });
            }

            var updateGroups = function (event, ui) {
                var url = "${createLink(controller:'Schedule', action:'searchGroups')}";

                var response = $.ajax({
                    url: url,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    crossDomain: true,
                    data: {
                        selectedLoc: $("#loc").val(),
                        code: courses[$(ui.selected).attr('value')].code
                    },
                    success: function (group) {
                        var name = courses[$(ui.selected).attr('value')].name;
                        var code = courses[$(ui.selected).attr('value')].code;
                        $('#accordionGroup')
                                .append('<h3 value="' + name + '">' + code + ' ' + name + '<a id="deleteCourse" class="ui-icon ui-icon-close"/> </h3>')

                        var div = $('<ol>', {class: 'selectableItem', id: name, value: code});
                        groups[name] = group;
                        $.each(group, function (key, value) {
                            var minSch = ""
                            for (var i in value["timeSlots"]) {
                                var ts = value["timeSlots"][i]
                                if (ts.startHour > 0)
                                    minSch += ts.day.substring(0, 2) + ': ' + ts.startHour + ' - ' + ts.endHour + '\n';
                            }
                            div.append($('<li>', {value: code, id: key})
                                    .html(value.code + ' - ' + value.teacher + '<p style="background-color: #999999">' + minSch + '</p>'));
                        });
                        $('#accordionGroup').append(div);

                        $('#accordionGroup').accordion("refresh");
                    },
                    error: function (request, status, error) {
                        alert(error)
                    }
                });
            }


            var updateTypeCourse = function () {
                var courseType = $.parseJSON('${courseType.encodeAsJSON()}')
                $('#menuType').empty();
                if ($("#menuTypePlan").val() == 'PRE') {
                    $.each(courseType["PRE"], function (key, value) {
                        $('#menuType')
                                .append($('<option>', {value: value})
                                        .text(key));
                    });

                } else {
                    $.each(courseType["POS"], function (key, value) {
                        $('#menuType')
                                .append($('<option>', {value: value})
                                        .text(key));
                    });
                }
                $('#menuType').selectmenu("refresh", true);
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
                select: function (event, ui) {
                    $("#loc").val(ui.item.label);
                    updatePlans();
                }
            });

            $("#menuType").selectmenu({
                select: function () {
                    if ($("#menuType").val() == "") {
                        $('#selectable li').show();
                    } else {
                        $('#selectable li').each(function () {
                            (courses[$(this).val()].typology == $("#menuType").val()) ? $(this).show() : $(this).hide();
                        });
                    }
                }
            });

            $("#menuTypePlan").selectmenu({
                create: updateTypeCourse(),
                select: function () {
                    updateTypeCourse()
                    $("#plans").val("")
                    updatePlans()
                    $("#selectable").empty()
                }
            });

            $("#course").keyup(function () {
                var course = $(this).val().toLowerCase();
                if (course == "") {
                    $('#selectable li').show();
                } else {
                    $('#selectable li').each(function () {
                        var text = $(this).text().toLowerCase();
                        (text.indexOf(course) >= 0) ? $(this).show() : $(this).hide();
                    });
                }
                ;
            });

            $("#accordionGroup").accordion({
                collapsible: true,
                active: false,
                heightStyle: "content"
            });

            $('#accordionGroup').on('click', 'a', function () {
                $("#accordionGroup").accordion("option", "active", false);
                var parent = $(this).closest('h3');
                var name = parent.attr('value');
                var code = parent.next('ol').attr('value');
                delete schedule[name];
                delete groups[name];
                $("#scheduleTable td").each(function () {
                    if ($(this).html().indexOf(code) >= 0) {
                        $(this).html("")
                        $(this).css("background-color", "#eee")
                    }
                });
                var head = parent.next('ol');

                parent.add(head).fadeOut('slow', function () {
                    $(this).remove();
                });
            });

            $("#selectable").selectable({
                        selected: function (event, ui) {
                            $(ui.selected).addClass("ui-selected").siblings().removeClass("ui-selected");
                            $("#selectedCoursesCol").removeClass('hidden');
                            $("#msgCol").addClass('hidden');
                            if (!(courses[$(ui.selected).attr('value')].name in groups)) {
                                updateGroups(event, ui);
                            }
                        }
                    }
            );

            $('#accordionGroup').on('click', 'ol', function () {
                $(this).selectable({
                    selected: function (event, ui) {
                        $(ui.selected).addClass("ui-selected").siblings().removeClass("ui-selected");
                        var code = $(ui.selected).attr('value')
                        var parent = $(this).prev('h3');
                        var name = parent.attr('value')
                        var gr = groups[name][$(ui.selected).attr('id')]
                        $("#scheduleTable td").each(function () {
                            if ($(this).html().indexOf(code) >= 0) {
                                $(this).html("")
                                $(this).css("background-color", "#eee")
                            }
                        });

                        var available = true;
                        var crCourse = "";
                        for (var i in gr["timeSlots"]) {
                            var ts = gr["timeSlots"][i]
                            for (var s = ts.startHour; s < ts.endHour; s++) {
                                if ($("#scheduleTable #r" + s + " #" + days.indexOf(ts.day) * s).text().trim() != "") {
                                    available = false;
                                    crCourse = $("#scheduleTable #r" + s + " #" + days.indexOf(ts.day) * s).text().trim();
                                    crCourse = crCourse.substr(0, crCourse.indexOf("-"));
                                    $(courses).each(function (key, value) {
                                        if (value["code"] == crCourse) {
                                            crCourse = value["name"];
                                        }
                                    });
                                    break;
                                }
                            }
                            if (!available) break;
                        }

                        if (!available) {
                            $("#modal-message").html("Existe un cruce entre la materia " + crCourse + " y la materia " + name + ".");
                            $("#modalCr").modal("show");
                        } else {
                            schedule[name] = gr;
                            var colors = ["#f49595", "#f9eb97", "#c6f9ac", "#a8d9f6", "#e2bbfd", "#84d8b8",
                                "#b4e7cf", "#eed7cb", "#eeeba1", "#f8bbf9"]
                            var color = colors[Math.random() * 10 | 0]
                            for (var i in gr["timeSlots"]) {
                                var ts = gr["timeSlots"][i]
                                if (ts.startHour > 0) {
                                    for (var s = ts.startHour; s < ts.endHour; s++) {
                                        $("#scheduleTable #r" + s + " #" + days.indexOf(ts.day) * s).html(code + '-' + gr["code"]);
                                        $("#scheduleTable #r" + s + " #" + days.indexOf(ts.day) * s).css("background-color",
                                                color);
                                    }

                                }
                            }
                        }

                    }
                });
            });

            $("#saveSchedule").button().click(
                    function() {
                        html2canvas($('#scheduleTable'), {
                            onrendered: function (canvas) {
                                var img = canvas.toDataURL()
                                window.open(img);
                            }
                        });
                    }
            );

        });
    </script>


    <title>Creación de horarios</title>
</head>


<body>

<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand page-scroll" href="home">UNCake</a>
        </div>
        <g:if test="${session.user == null}">
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                <ul class="nav navbar-nav navbar-right">

                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>

                    <li>
                        <a class="page-scroll" href="register"><span class="glyphicon glyphicon-user"></span>Registrarme
                        </a>
                    </li>
                    <li>
                        <a class="page-scroll" href="login"><span class="glyphicon glyphicon-log-in"></span>Ingresar</a>
                    </li>
                </ul>

            </div>

        </g:if>

        <g:if test="${session.user != null}">

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                <ul class="nav navbar-nav navbar-right">

                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="profile"><span
                                class="glyphicon glyphicon-user"></span>Hola ${session.user.name}!</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="logout"><span class="glyphicon glyphicon-log-out"></span>Salir</a>
                    </li>
                </ul>

            </div>
        </g:if>

    </div>
</nav>

<div class="row">
    <div class="col-sm-3">

        <label for="loc">Sede:</label>

        <div class="ui-widget">
            <input id="loc">
        </div>

        <label for="menuTypePlan">Tipo:</label>

        <div>
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

        <div>
            <select name="menuType" id="menuType">
            </select>
        </div>

        <label for="course">Materia:</label>

        <div class="ui-widget">
            <input id="course">
        </div>

        <div class="selectablemenu">
            <ol class="selectableItem" id="selectable">
            </ol>
        </div>

    </div>

    <div class="col-sm-6">
        <div class="table-responsive">
            <table id="scheduleTable" class="table-condensed">
                <div id="head_nav">
                    <tr>
                        <th>H</th>
                        <th>Lunes</th>
                        <th>Martes</th>
                        <th>Miercoles</th>
                        <th>Jueves</th>
                        <th>Viernes</th>
                        <th>Sabado</th>
                        <th>Domingo</th>
                    </tr>
                </div>
            </table>
        </div>


        <g:if test="${session.user != null}">
            <div>
                <button id="saveSchedule">
                    Guardar
                </button>
            </div>
        </g:if>

    </div>

    <div class="col-sm-3">

        <div class="panel panel-default" id="msgCol">
            <div class="panel-body">
                <h3>Bienvenido!</h3>
                Utiliza los filtros para empezar a crear tu horario.
            </div>
        </div>

        <div id="selectedCoursesCol" class="hidden">
            <label for="accordionGroup">Materias seleccionadas</label>

            <div id="accordionGroup">
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="modalCr" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Cruce de horarios</h4>
                    </div>

                    <div class="modal-body">
                        <p id="modal-message">Selecciona otro grupo.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>