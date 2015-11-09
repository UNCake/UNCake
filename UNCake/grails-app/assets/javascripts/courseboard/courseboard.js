/**
 * Created by santiago on 11/8/15.
 */
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
                $('#accordionGroup')
                    .append('<h3 value="'+name+'">' + name + '<a id="deleteCourse" class="ui-icon ui-icon-close"/> </h3>')

                var div = $('<ol>', {class: 'selectableItem', id: name});
                groups[name] = group;
                $.each(group, function (key, value) {
                    div.append($('<li>', {value: name, id: key})
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
        var name = parent.attr('value')
        delete groups[name];
        $("#scheduleTable td").each(function(){
            if ($(this).html() == name) {
                $(this).html("")
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
                var name = $(ui.selected).attr('value')
                var gr = groups[name][$(ui.selected).attr('id')]
                $("#scheduleTable td").each(function(){
                    if ($(this).html() == name) {
                        $(this).html("")
                    }
                });

                var available = true
                for(var i in gr["timeSlots"]){
                    var ts = gr["timeSlots"][i]
                    for (var s = ts.startHour; s <= ts.endHour; s++) {
                        if($("#scheduleTable #r" + ts.startHour + " #" + days.indexOf(ts.day) * s).text().trim()!=""){
                            available = false;
                            break;
                        }
                    }
                    if(!available) break;
                }

                if(!available){
                    alert("Existe cruce de horarios");
                }else {
                    for(var i in gr["timeSlots"]) {
                        for (var i in gr["timeSlots"]) {
                            var ts = gr["timeSlots"][i]
                            if (ts.startHour > 0) {
                                for (var s = ts.startHour; s <= ts.endHour; s++) {
                                    $("#scheduleTable #r" + ts.startHour + " #" + days.indexOf(ts.day) * s).html(name);
                                }

                            }
                        }
                    }
                }

            }
        });
    });

});