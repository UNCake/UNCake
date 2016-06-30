<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta name="layout" content="navbar"/>

    <title>Creación de horarios</title>

    <asset:stylesheet src="schedule.css"/>
</head>


<body>

<div class="row">
    <div class="col s12 m3">

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
            <input id="plans" class="dropdown-button" placeholder="Selecciona un plan" data-activates="dropdownPlans">
            <ul id="dropdownPlans" class="dropdown-content"></ul>
            <label class="active" for="plans">Planes</label>
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

        <div id="progressbarCourses" class="hide">
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

    <div class="col s12 m6">

        <div class="fixed-action-btn horizontal click-to-toggle" >
            <a class="btn-floating btn-large red">
                <i class="material-icons">menu</i>
            </a>
            <ul>
                <li><a class="btn-floating red" id="showTable"><i class="material-icons">view_module</i></a></li>
                <li><a class="btn-floating yellow darken-1" id="showList"><i class="material-icons">view_list</i></a></li>
                <li><a class="btn-floating green" id="downloadSchedule" download><i class="material-icons" >get_app</i></a></li>

            </ul>
        </div>
    <div id="schedulePanel">
        <ul class="collection with-header hide" id="scheduleList">
            <li class="collection-header blue-grey lighten-5" id="listMon"><h6>Lunes</h6></li>
            <li class="collection-header blue-grey lighten-5" id="listTue"><h6>Martes</h6></li>
            <li class="collection-header blue-grey lighten-5" id="listWed"><h6>Miércoles</h6></li>
            <li class="collection-header blue-grey lighten-5" id="listThu"><h6>Jueves</h6></li>
            <li class="collection-header blue-grey lighten-5" id="listFri"><h6>Viernes</h6></li>
            <li class="collection-header blue-grey lighten-5" id="listSat"><h6>Sábado</h6></li>
            <li class="collection-header blue-grey lighten-5" id="listSun"><h6>Domingo</h6></li>
        </ul>


        <div class="responsive-table" id="scheduleDiv">
            <table id="scheduleTable">
                <thead>
                <tr>
                    <th>H</th>
                    <th>Lu.</th>
                    <th>Ma.</th>
                    <th>Mi.</th>
                    <th>Ju.</th>
                    <th>Vi.</th>
                    <th>Sa.</th>
                    <th>Do.</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>

            <div id="listSchedule"></div>

        </div>
    </div>

    </div>

    <div class="col s12 m3">

        <div class="card blue-grey darken-1" id="msgCol">
            <div class="card-content white-text">
                <span class="card-title">Bienvenido!</span>

                <p>Utiliza los filtros para crear tu horario.</p>
            </div>

        </div>

        <div id="progressbarGroups" class="hide">
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
<script src="https://parall.ax/parallax/js/jspdf.js"></script>
<g:javascript>

    $(function () {

        $('select').material_select();

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
                    $('#dropdownPlans').empty();
                    $.each(plans, function (key, value) {

                        $('#dropdownPlans')
                                .append($('<li>', {value: value})
                                        .html('<a>' + value + '</a>'));
                    });
                    updateDropdown();
                },

                error: function (request, status, error) {
                    alert(error)
                }
            });
        }

        var updateDropdown = function () {
            $('.dropdown-button').dropdown({
                        inDuration: 300,
                        outDuration: 225,
                        gutter: 0,
                        belowOrigin: true,
                        alignment: 'left'
                    }
            )
        }

        $('#dropdownPlans').on('click', 'li', function () {
            $('#plans').val($(this).text());
            $("#listCourses").empty();
            updateCourses();
        });

        $('#plans').keyup(function () {
            var plan = $(this).val().toLowerCase();
            $('#dropdownPlans li').each(function () {
                var text = $(this).text().toLowerCase();
                (text.indexOf(plan) >= 0) ? $(this).show() : $(this).hide();
            });
        });


        $("#loc").change(function () {
            updatePlans();
            $('#listCourses').empty();
        });

        var updateCourses = function () {
            var url = "${createLink(controller:'Schedule', action:'searchCourses')}";
            $("#progressbarCourses").removeClass("hide");
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

                    $("#progressbarCourses").addClass("hide");
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
            $("#progressbarGroups").removeClass("hide");
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
                        drawGroup(this.id, this.value, $(this).closest('ol').attr('id'))
                    });
                    $("#progressbarGroups").addClass("hide");
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
        });

        var clearSlot = function (slot) {
            $(slot).html("")
            $(slot).val("")
            $(slot).css("background-color", "#eee")
            $(slot).css("border", "1px solid #C0C0C0")
            $(slot).attr("rowspan", 1)
            $(slot).show()
        }


        $('#accordionGroup').on('click', 'a', function () {

            var parent = $(this).closest('li')
            var name = parent.attr('value');
            var code = parent.attr('id');

            delete schedule[name];
            delete groups[name];
            $("#scheduleTable td").each(function () {
                if ($(this).val().indexOf(code) >= 0) {
                    clearSlot(this);
                }
            });

            parent.fadeOut('medium', function () {
                $(this).remove();
            });
        });

        var drawGroup = function (id, code, name) {

            var gr = groups[name][id]

            $("#scheduleTable td").each(function () {
                if ($(this).val().indexOf(code) >= 0) {
                    clearSlot(this);
                }
            });

            var available = true, slot;
            var crCourse = "";
            for (var i in gr["timeSlots"]) {
                var ts = gr["timeSlots"][i]
                for (var s = ts.startHour; s < ts.endHour; s++) {
                    slot = "#scheduleTable #r" + s + " #" + days.indexOf(ts.day) * s;
                    crCourse = $(slot).val();

                    if (crCourse != "") {
                        available = false;
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
                        slot = "#scheduleTable #r" + ts.startHour + " #" + days.indexOf(ts.day) * ts.startHour;
                        name = (name.length > 15) ? name.substr(0, 15) + '...' : name;
                        $(slot).html(name + "<br> Gr." + gr["code"]);
                        $(slot).val(code);
                        $(slot).css("background-color", color);
                        $(slot).css("border", "none");
                        $(slot).css("text-align", "center");
                        $(slot).attr("rowspan", ts.endHour - ts.startHour);

                        for (var s = ts.startHour + 1; s < ts.endHour; s++) {
                            slot = "#scheduleTable #r" + s + " #" + days.indexOf(ts.day) * s;
                            $(slot).val(code);
                            $(slot).hide();
                        }

                    }
                }
            }

        }

        $("#saveSchedule").submit(
                function () {
                    var url = "${createLink(controller:'Schedule', action:'buildSchedule')}";
                    schedule["name"] = $("#nameSc").val();
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: JSON.stringify(schedule),
                        contentType: 'application/json',
                        success: function (r) {
                            $("#modalSave").closeModal();

                            if (r[0] == 1) {
                                Materialize.toast("Horario " + $("#nameSc").val() + " guardardo.", 4000)
                            } else if (r[2] == 3) {
                                Materialize.toast("No se puede guardar el horario.", 4000)
                            } else {
                                Materialize.toast("El horario no puede ser vacio.", 4000)
                            }

                        }, error: function () {
                            Materialize.toast("No se puede guardar el horario.", 4000)
                        }
                    });
                    return false;
                }
        );

        $("#downloadSchedule").click(
                function () {
                    delete schedule["name"]
                    delete schedule["image"]
                    $.each(schedule, function (key, value) {

                        $('#listSchedule').append($('<p>').html(key + "-" + value.teacher));
                        /*
                         for(var i in value["timeSlots"]){
                         slot = value["timeSlots"][i]
                         console.log(slot.day)
                         console.log(slot.building)
                         $('#scheduleDiv').append($('<p>').html( slot.day + ": " + slot.startHour+ "-" + slot.endHour
                         + " " + (slot.building != null)? slot.classroom+"-"+slot.building: "no asignado"));

                         }
                         */
                    })

                    html2canvas($('#schedulePanel'), {
                        onrendered: function (canvas) {

                            var imgData = canvas.toDataURL("image/jpeg", 1.0);
                            var pdf = new jsPDF();

                            pdf.addImage(imgData, 'JPEG', 0, 0);
                            pdf.save("horario.pdf");

                            $("#listSchedule").html("");
                        }
                    })

                }
        );

        $("#showList").click(function() {
          $("#scheduleDiv").hide();
          $("#scheduleList").removeClass("hide");
        });

        $("#showTable").click(function() {
          $("#scheduleDiv").show();
          $("#scheduleList").addClass("hide");
        });

        $('.modal-trigger').leanModal();
    });
</g:javascript>
</body>
</html>