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
            var courses
            var prevSelected = -1

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
                    success: function (groups) {
                        var name = courses[$(ui.selected).attr('value')].name;
                        console.log(groups);
                        $('#accordionGroup')
                                .append('<h3>'+name+'<a id="deleteCourse" class="ui-icon ui-icon-close"/> </h3>')

                        var div = $('<ol>', {class:'selectableItem', id: name})

                        $.each(groups, function (key, value) {
                            div.append($('<li>', {value: key})
                                    .text(value.teacher));
                        });
                        $('#accordionGroup').append(div);

                        $('#accordionGroup').accordion("refresh");
/*
                         <div id="accordionGroup">

                         <h3>The Title - Item 1  </h3>

                         <div>
                         <ol class="selectableItem" id="selectableGroup">
                         <li>s</li>
                         <li>s</li>
                         <li>s</li>
                         </ol>

                         </div>

                         <h3>The Title - Item 2  <button class="deleteCourse"/></h3>

                         <div>The Content - Item 2</div>
                         </div>

                        */
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

            $( "#accordionGroup" ).accordion({
                collapsible: true,
                heightStyle: "content"
            });

            $('#accordionGroup').on('click','a', function(){
                var parent = $(this).closest('h3');
                var head = parent.next('div');
                parent.add(head).fadeOut('slow', function () {
                    $(this).remove();
                });
            });

            $("#selectable").selectable({
                    selected: function (event, ui) {
                        $(ui.selected).addClass("ui-selected").siblings().removeClass("ui-selected");
                        if(prevSelected != $(ui.selected).attr('value')){
                            prevSelected = $(ui.selected).attr('value')
                            updateGroups(event, ui);
                        }
                    }
                }
            );

            $('#accordionGroup').on('click','ol', function() {
                $(this).selectable();
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

<div class="column schedule">
    <p>tabla de horario</p>
</div>

<div class="column selectedC">
    <p>Materias seleccionadas</p>

    <div id="accordionGroup">
    </div>


</div>

</body>
</html>