<%--
  Created by IntelliJ IDEA.
  User: anmrdz
  Date: 10/18/15
  Time: 6:42 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ defaultCodec="none" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <asset:stylesheet src="bootstrap/css/bootstrap.css"/>
    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="schedule.css"/>
    <asset:stylesheet src="materialize/css/materialize.css"/>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>


    <asset:javascript src="jquery-2.1.3.js"/>
    <script>

        $(function () {

            $('select').material_select();
            $('.caret').html('');

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
                        $('#plans').empty();
                        $.each(plans, function (key, value) {

                            $('#plans')
                                    .append($('<option>', {value: value})
                                            .text(value));
                        });
                        $("#plans").material_select();
                        $('.caret').html('');
                    },

                    error: function (request, status, error) {
                        alert(error)
                    }
                });
            }

            $("#loc").change(function () {
                updatePlans();
                $('#listCourses').empty();
            });

            var updateCourses = function () {
                var url = "${createLink(controller:'Schedule', action:'searchCourses')}";
                $("#progressbarCourses").show();
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
                        $('#listCourses').empty();
                        $.each(courses, function (key, value) {
                            $('#listCourses')
                                    .append($('<li>', {value: key, class: "collection-item"})
                                            .text(value.code + " " + value.name));
                        });
                        $("#progressbarCourses").hide();
                        $("#listCourses li").click(function () {
                            $("#selectedCoursesCol").removeClass('hidden');
                            $("#msgCol").addClass('hidden');
                            if (!(courses[this.value].name in groups)) {
                                updateGroups(this.value);
                            }
                        });

                    },
                    error: function (request, status, error) {
                        alert(error)
                    }
                });
            }

            var updateGroups = function (code) {

                var url = "${createLink(controller:'Schedule', action:'searchGroups')}";
                var name = courses[code].name;
                var code = courses[code].code;
                $("#progressbarGroups").show();
                groups[name] = {};
                var response = $.ajax({
                    url: url,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    crossDomain: true,
                    data: {
                        selectedLoc: $("#loc").val(),
                        code: code
                    },
                    success: function (group) {

                        var content = $('<li>', {value: name, id: code});
                        content.append('<div class="collapsible-header"> <a id="deleteCourse" > <i class="tiny material-icons">not_interested</i></a>' + code + ' ' + name + '</div>')
                        var item = $('<div>', {class: "collapsible-body"});

                        var div = $('<ol>', {class: 'selectableItem', id: name, value: code});
                        groups[name] = group;
                        $.each(group, function (key, value) {
                            var minSch = ""
                            for (var i in value["timeSlots"]) {
                                var ts = value["timeSlots"][i]
                                if (ts.startHour > 0)
                                    minSch += ts.day.substring(0, 2) + ': ' + ts.startHour + ' - ' + ts.endHour + '  ';
                            }

                            div.append($('<li>', {value: code, id: key})
                                    .html(value.code + ' - ' + value.teacher + '<p>' + minSch + '</p>' +
                                    'Cupos disp. ' + value["availableSpots"] + '/' + value["totalSpots"] +
                                    '<progress value="' + value["availableSpots"] + '" max="' + value["totalSpots"] + '"/>'));
                        });
                        item.append(div);
                        content.append(item);

                        $('#accordionGroup').append(content);
                        $('.collapsible').collapsible({
                            accordion: true
                        });

                        $('#accordionGroup ol li').off("click")

                        $('#accordionGroup ol li').click(function () {
                            drawGroup(this.id, this.value, name)
                        });
                        $("#progressbarGroups").hide();
                    },
                    error: function (request, status, error) {
                        delete groups[name];
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
                $('#menuType').material_select();
                $('.caret').html('');
            }

            $("#plans").change(function () {
                $("#listCourses").empty();
                updateCourses();
            });


            $("#menuType").change(function () {
                if ($("#menuType").val() == "") {
                    $('#listCourses li').show();
                } else {
                    $('#listCourses li').each(function () {
                        (courses[$(this).val()].typology == $("#menuType").val()) ? $(this).show() : $(this).hide();
                    });
                }
            });

            $("#menuTypePlan").change(function () {
                updateTypeCourse()
                updatePlans()
                $("#listCourses").empty()
            });

            $("#course").keyup(function () {
                var course = $(this).val().toLowerCase();
                if (course == "") {
                    $('#listCourses li').show();
                } else {
                    $('#listCourses li').each(function () {
                        var text = $(this).text().toLowerCase();
                        (text.indexOf(course) >= 0) ? $(this).show() : $(this).hide();
                    });
                }
                ;
            });


            $('#accordionGroup').on('click', 'a', function () {

                var parent = $(this).closest('li')
                var name = parent.attr('value');
                var code = parent.attr('id');

                delete schedule[name];
                delete groups[name];
                $("#scheduleTable td").each(function () {
                    if ($(this).html().indexOf(code) >= 0) {
                        $(this).html("")
                        $(this).css("background-color", "#eee")
                    }
                });

                parent.fadeOut('medium', function () {
                    $(this).remove();
                });
            });

            var drawGroup = function (id, code, name) {

                var gr = groups[name][id]

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

                    Materialize.toast("Existe un cruce entre la materia " + crCourse + " y la materia " + name + ".", 4000)

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

            $("#saveSchedule").submit(
                    function () {
                        var url = "${createLink(controller:'Schedule', action:'buildSchedule')}";
                        schedule["name"] = $("#nameSc").val();
                        schedule["image"] = $("#scheduleDiv").html();
                        $.ajax({
                            type: "POST",
                            url: url,
                            data: JSON.stringify(schedule),
                            contentType: 'application/json',
                            success: function (r) {
                                $("#modalSave").closeModal();

                                if (r != "") {
                                    Materialize.toast("Horario "+$("#nameSc").val()+" guardardo.", 4000)
                                }else{
                                    Materialize.toast("No se puede guardar el horario.", 4000)
                                }
                            },error: function(){
                                Materialize.toast("No se puede guardar el horario.", 4000)
                            }
                        });
                        return false;
                    }
            );
            /*
             $("#printSchedule").button().click(
             function () {

             /*
             html2canvas($('#scheduleTable'), {
             onrendered: function (canvas) {
             var img = canvas.toDataURL();
             //window.open(img);

             return false;

             }
             });*
             var mywindow = window.open('', 'my div', 'height=400,width=600');
             mywindow.document.write('<html><head><title>Mi Horario</title>');
             mywindow.document.write('<link rel="stylesheet" href="/assets/schedule.css" type="text/css" media="screen"/>');
             mywindow.document.write('<link rel="stylesheet" href="/assets/schedule.css" type="text/css" media="print"/>');
             mywindow.document.write("<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>");
             mywindow.document.write('</head><body>');
             mywindow.document.write($("#scheduleDiv").html());
             mywindow.document.write('</body></html>');
             mywindow.onload = mywindow.print();
             mywindow.close();
             }
             );
             */
            $("#progressbarCourses").hide();
            $("#progressbarGroups").hide();

            $('.modal-trigger').leanModal();
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
                                class="glyphicon glyphicon-user"></span>Hola ${session.user.name.split()[0]}!</a>
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

        <div class="input-field">
            <select class="icons" id="loc">
                <option value="" disabled selected>Selecciona tu sede</option>
                <option value="AMAZONIA" data-icon="${resource(dir: 'images', file: 'amazonia.jpg')}"
                        class="circle">Amazonia</option>
                <option value="BOGOTA" data-icon="${resource(dir: 'images', file: 'bogota.jpg')}"
                        class="circle">Bogotá</option>
                <option value="CARIBE" data-icon="${resource(dir: 'images', file: 'caribe.jpg')}"
                        class="circle">Caribe</option>
                <option value="MANIZALES" data-icon="${resource(dir: 'images', file: 'manizales.jpg')}"
                        class="circle">Manizales</option>
                <option value="MEDELLIN" data-icon="${resource(dir: 'images', file: 'medellin.jpg')}"
                        class="circle">Medellín</option>
                <option value="PALMIRA" data-icon="${resource(dir: 'images', file: 'palmira.jpg')}"
                        class="circle">Palmira</option>
                <option value="ORINOQUIA" data-icon="${resource(dir: 'images', file: 'orinoquia.jpg')}"
                        class="circle">Orinoquia</option>
                <option value="TUMACO" data-icon="${resource(dir: 'images', file: 'tumaco.jpg')}"
                        class="circle">Tumaco</option>
            </select>
            <label>Sede</label>
        </div>


        <div class="input-field">
            <select id="menuTypePlan">
                <option value="PRE" selected="selected">Pregrado</option>
                <option value="POS">Posgrado</option>
            </select>
            <label for="menuTypePlan">Tipo</label>
        </div>


        <div class="input-field">
            <select id="plans">
                <option value="" disabled selected>Selecciona una sede</option>
            </select>
            <label for="plans">Planes</label>
        </div>

        <div class="input-field">
            <select name="menuType" id="menuType">
                <option value="">Todas</option>
                <option value="B">Fundamentación</option>
                <option value="C">Disciplinar</option>
                <option value="L">Libre elección</option>
                <option value="P">Nivelación</option>
            </select>
            <label for="menuType">Tipología</label>
        </div>


        <div class="input-field">
            <i class="material-icons prefix">search</i>
            <input id="course" type="text" class="validate">
            <label for="course">Materia</label>
        </div>

        <div id="progressbarCourses">
            <div class="preloader-wrapper big active">
                <div class="spinner-layer spinner-green-only">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>

                    <div class="gap-patch">
                        <div class="circle"></div>
                    </div>

                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="selectablemenu">
            <div class="collection selectableItem" id="listCourses">
            </div>
        </div>
    </div>

    <div class="col-sm-6">
        <div class="table-responsive" id="scheduleDiv">
            <table id="scheduleTable">
                <div>
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
                <!-- Modal Trigger -->
                <a id="showSaveSchedule" class="waves-effect waves-light btn modal-trigger" href="#modalSave">Guardar</a>
            </div>
        </g:if>

        <div>
            <a class="waves-effect waves-light btn" id="printSchedule">Imprimir</a>
        </div>

    </div>

    <div class="col-sm-3">

        <div class="card blue-grey darken-1" id="msgCol">
            <div class="card-content white-text">
                <span class="card-title">Bienvenido!</span>

                <p>Utiliza los filtros para crear tu horario.</p>
            </div>

        </div>

        <div id="progressbarGroups">
            <div class="preloader-wrapper small active">
                <div class="spinner-layer spinner-blue-only">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>

                    <div class="gap-patch">
                        <div class="circle"></div>
                    </div>

                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
            </div>
        </div>

        <div id="selectedCoursesCol" class="hidden">
            <ul class="collapsible" data-collapsible="accordion" id="accordionGroup">
            </ul>
        </div>

        <!-- Modal Structure -->
        <div id="modalSave" class="modal bottom-sheet">
            <div class="modal-content">
                <h4>Guardar horario</h4>
                <form id="saveSchedule">
                    <div class="form-group">
                        <label>Nombre</label>

                        <div style="display: flex">
                            <input type="text" id="nameSc" class="form-control"
                                   placeholder="Introduce un nombre"
                                   required autofocus>
                        </div>
                    </div>
                    <button class="btn btn-lg btn-primary btn-block color-black" type="submit"
                            value='guardar'>Guardar</button>
                </form>
            </div>
        </div>

    </div>

</div>

<asset:javascript src="html2canvas.js"/>
<asset:javascript src="jquery-2.1.3.js"/>
<asset:javascript src="bootstrap/js/bootstrap.min.js"/>
<asset:javascript src="materialize/js/materialize.js"/>
</body>
</html>