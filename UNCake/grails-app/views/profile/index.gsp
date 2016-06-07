<%@ page import="uncake.GradesController" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="navbar"/>
    <title>Perfil</title>

    <asset:stylesheet src="schedule.css"/>
    <asset:stylesheet src="profile.css"/>
    <!-- TODO Change view schedule
    <script>
        $(function () {
            $(".showSchedule").click(function () {
                var url = "${createLink(controller:'Schedule', action:'showSchedule')}";
                console.log($(this).html())
                var response = $.ajax({
                    url: url,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: {
                        name: $(this).html().trim()
                    },
                    success: function (schedule) {
                        console.log(schedule);
                        if (schedule != "[]") {
                            $("#divSch").html(schedule[0]);
                        }
                    },

                    error: function (request, status, error) {
                        alert(error)
                    }
                });
                $("#modalCr").modal("show");
            });
        });

    </script>
    -->
</head>

<body style="  background-color:rgba(0, 0, 0, 0.2); ">

<div class="container ">

    <br>

    <div class="row">
        <div class="col-md-4 col-sm-4">
            <g:if test="${session.user.avatar == null}">
                <img src="${resource(dir: 'images', file: 'avatar.png')}" class="img-responsive">
            </g:if>
            <g:if test="${session.user.avatar != null}">
                <img class=" img-responsive  " style="text-align: center"
                     src="${createLink(controller: 'user', action: 'avatar_image', id: session.user.ident())}"/>
            </g:if>

        </div>

        <div class=" col-md-8 col-sm-8">
            <p class="row font-usuario ">
                ${session.user.name}

            </p>

            <div class="row">
                <a class="  " href="/changephoto" title="Cambia foto.">Cambiar o subir una foto</a>
            </div>

            <div class="row">
                <a class="  " href="/changepassword" title="Cambia tu contraseña.">Cambiar Contraseña</a>
            </div>

        </div>
    </div>
    <br>
    <br>

    <div class="row">
        <div class="list-group">
            <h4>
                Mis historias academicas
            </h4>
            <g:if test="${academicRecords.size() == 0}">
                No tienes ninguna historia academica
            </g:if>
            <g:form action="delAcademicRecord">
                <g:each in="${academicRecords}" status="k" var="it">
                    <div class="cont">
                        <g:link class="list-group-item small-size size-list" style="background-color: burlywood"
                                controller="grades" action="index"
                                params="${[plan: it.studyPlan.code + " & " + it.studyPlan.name]}">${it.studyPlan.name}</g:link>
                        <button name="ind2" value="${k}" type="submit"
                                class="btn btn-primary btn-xs size-btn">x</button>

                        <div hidden><g:textArea name="dacademicrecord" value="${it.id}"/></div>
                    </div>

                </g:each>
            </g:form>
        </div>
        <a href="progress" class="btn btn-primary btn-xs">Agregar historia academica</a>
    </div>

    <div class="row">
        <h4>
            Mis horarios
        </h4>

        <div class="list-group">
            <g:if test="${schedules.size() == 0}">
                Aun no tienes horarios creados
            </g:if>

            <g:form action="delSchedule">
                <g:each in="${schedules}" status="i" var="schedule">
                    <div class="cont">
                        <a val="${schedule.name}" class="showSchedule list-group-item small-size size-list"
                           style="background-color: rgb(135, 190, 222)">${schedule.name}</a>
                        <button name="ind1" value="${i}" type="submit"
                                class="btn btn-primary btn-xs size-btn">x</button>

                        <div hidden><g:textArea name="dschedule" value="${schedule.id}"/></div>
                    </div>
                </g:each>
            </g:form>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="modalCr" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" id="modal-title">Horario</h4>
                    </div>

                    <div class="modal-body" id="divSch">
                        <p id="modal-message">Tu horario.</p>
                    </div>
                </div>
            </div>
        </div>

        <a href="schedule" class="btn btn-primary btn-xs">Agregar horario</a>

    </div>

    <div class="row ">
        <h4>
            Mis Amigos
        </h4>
        <g class="list-group ">
            <g:if test="${friends.size() == 0}">
                Aun no tienes amigos
            </g:if>

            <g:form action="delFriend">
                <g:each in="${friends}" status="j" var="ff">
                    <div class="cont">
                        <button name="indexf" value="${j}" class="list-group-item small-size size-list"
                                style="background-color: #d8d8d8 ">${ff.name}   -    ${ff.email}</button>

                        <button name="ind" value="${j}" type="submit" class="btn btn-primary btn-xs size-btn">x</button>

                        <div hidden><g:textArea name="dfriend" value="${ff.email}"/></div>

                    </div>
                </g:each>
            </g:form>

    </div>
    <!-- <a href="#" class="btn btn-primary btn-xs" >Agregar amigos</a>-->
</div>

</div>

</body>
</html>