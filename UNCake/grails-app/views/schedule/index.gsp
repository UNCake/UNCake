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
                                            .text(value.name));
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
                                .append('<h3 value="'+name+'">' + name + '<a id="deleteCourse" class="ui-icon ui-icon-close"/> </h3>')

                        var div = $('<ol>', {class: 'selectableItem', id: name, value: code});
                        groups[name] = group;
                        $.each(group, function (key, value) {
                            div.append($('<li>', {value: code, id: key})
                                    .text(value.teacher));
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
                delete groups[name];
                $("#scheduleTable td").each(function(){
                    if ($(this).html() == code) {
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
                            if(!(courses[$(ui.selected).attr('value')].name in groups)) {
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
                        $("#scheduleTable td").each(function(){
                            if ($(this).html() == code) {
                                $(this).html("")
                                $(this).css("background-color", "#eee")
                            }
                        });

                        var available = true
                        for(var i in gr["timeSlots"]){
                            var ts = gr["timeSlots"][i]
                            for (var s = ts.startHour; s <= ts.endHour; s++) {
                                if($("#scheduleTable #r" + s + " #" + days.indexOf(ts.day) * s).text().trim()!=""){
                                    available = false;
                                    break;
                                }
                            }
                            if(!available) break;
                        }

                        if(!available){
                            alert("Existe cruce de horarios");
                        }else {
                            var color = '#'+Math.floor(Math.random()*16777215).toString(16);
                                for (var i in gr["timeSlots"]) {
                                    var ts = gr["timeSlots"][i]
                                    if (ts.startHour > 0) {
                                        for (var s = ts.startHour; s <= ts.endHour; s++) {
                                            $("#scheduleTable #r" + s + " #" + days.indexOf(ts.day) * s).html(code);
                                            $("#scheduleTable #r" + s + " #" + days.indexOf(ts.day) * s).css("background-color",
                                                    color);
                                        }

                                    }
                                }
                        }

                    }
                });
            });

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

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

            <ul class="nav navbar-nav navbar-right">

                <li class="hidden">
                    <a href="#page-top"></a>
                </li>

                <li>
                    <a class="page-scroll" href="register"><span class="glyphicon glyphicon-user"></span>Registrarme</a>
                </li>
                <li>
                    <a class="page-scroll" href="login"><span class="glyphicon glyphicon-log-in"></span>Ingresar</a>
                </li>
            </ul>

        </div>
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
                    <th>Hora</th>
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

</div>

<div class="col-sm-3">
    <label for="accordionGroup">Materias seleccionadas</label>

    <div id="accordionGroup">
    </div>

</div>
</div>
</body>
</html>