<%@ page import="uncake.GradesController" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="navbar"/>
    <title>Perfil</title>

    <asset:stylesheet src="schedule.css"/>
    <asset:stylesheet src="profile.css"/>

</head>

<body>

<div class="container">

    <div class="row">
        <div class="card blue-grey darken-1">
            <div class="card-content white-text">
                <g:if test="${session.user.avatar == null}">
                    <img src="${resource(dir: 'images', file: 'avatar.png')}" id="avatar-img" class="circle">
                </g:if>
                <g:if test="${session.user.avatar != null}">
                    <img id="avatar-img" class="circle"
                         src="${createLink(controller: 'user', action: 'avatar_image', id: session.user.ident())}"/>
                </g:if>

                <h4>${session.user.name}</h4>
            </div>

            <div class="card-action">
                <a class="modal-trigger" href="#changephoto">Cambiar foto de perfil</a>
                <a class="modal-trigger" href="#changepassword">Cambiar Contraseña</a>
            </div>
        </div>
    </div>

    <g:if test="${flash.message != null}">
        <div id="message" class="alert alert-danger">
            <strong>${flash.message}</strong>
        </div>
    </g:if>

    <div id="changephoto" class="modal">
        <div class="modal-content">
            <h4>Cambiar foto de perfil</h4>
            <g:uploadForm controller="User" action="upload_avatar">
                <div class="file-field input-field">
                    <div class="btn">
                        <span>Archivo</span>
                        <input type="file" name="avatar" id="avatar" accept="image/*">
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text">
                    </div>
                </div>
                <button type="submit" class="btn waves-effect waves-green">Subir</button>
            </g:uploadForm>
        </div>
    </div>

    <div id="changepassword" class="modal">
        <div class="modal-content">
            <h4>Cambiar Contraseña</h4>

            <g:form class="form-signin" action="changePass" method="post">

                <div class="input-field col s6">
                    <input id="actPass" type="password" class="validate" required name="actPass">
                    <label for="actPass">Contraseña actual</label>
                </div>

                <div class="input-field col s6">
                    <input title="La contraseña debe tener entre 7 y 15 caracteres" id="pass" type="password"
                           class="validate" required pattern="[0-9a-zA-Z]{7,15}" name="pass"
                           onchange="this.setCustomValidity(this.validity.patternMismatch ? this.title : '');
                           if (this.checkValidity()) form.pwd2.pattern = this.value;">
                    <label for="pass">Contraseña nueva</label>
                </div>

                <div class="input-field col s6">
                    <input title="Las contraseñas deben coincidir" id="pass2" type="password"
                           class="validate" required pattern="[0-9a-zA-Z]{7,15}" name="pass2"
                           onchange="this.setCustomValidity(this.validity.patternMismatch ? this.title : '');">
                    <label for="pass2">Confirma la contraseña</label>
                </div>
                <button type="submit" class="btn waves-effect waves-green">Cambiar contraseña</button>
            </g:form>
        </div>
    </div>


    <div class="row">

        <div class="col s12">
            <ul class="tabs">
                <li class="tab col s5"><a href="#horarios">Horarios</a></li>
                <li class="tab col s7"><a class="active" href="#HA">Historias académicas</a></li>
            </ul>
        </div>

        <div id="HA" class="col s12">
            <div class="card-panel">
                <h4>
                    Mis historias académicas
                </h4>

                <div class="collection">
                    <g:if test="${academicRecords.size() == 0}">
                        No tienes ninguna historia académica
                    </g:if>
                    <g:form action="delAcademicRecord">
                        <g:each in="${academicRecords}" status="k" var="it">
                            <div class="cont">
                                <g:link class="collection-item small-size"
                                        controller="grades" action="index"
                                        params="${[plan: it.studyPlan.code + " & " + it.studyPlan.name]}">${it.studyPlan.name}</g:link>
                                <button name="ind2" value="${k}" type="submit"
                                        class="btn-large secondary-content"><i class="material-icons">delete</i>
                                </button>

                                <div hidden><g:textArea name="dacademicrecord" value="${it.id}"/></div>
                            </div>

                        </g:each>
                    </g:form>
                </div>

                <p>
                    <a href="grades" class="btn-floating waves-effect waves-light red"><i class="material-icons">add</i>
                    </a>
                    Agregar historia académica
                </p>

            </div>
        </div>

        <div id="horarios" class="col s12">
            <div class="card-panel">
                <h4>
                    Mis horarios
                </h4>

                <div class="collection">
                    <g:if test="${schedules.size() == 0}">
                        Aún no tienes horarios creados
                    </g:if>

                    <g:form action="delSchedule">
                        <g:each in="${schedules}" status="i" var="schedule">
                            <div class="cont">
                                <g:link class="collection-item small-size"
                                        controller="schedule" action="index"
                                        params="${[name: schedule.name]}">${schedule.name}</g:link>
                                <button name="ind1" value="${i}" type="submit"
                                        class="btn-large secondary-content"><i class="material-icons">delete</i>
                                </button>

                                <div hidden><g:textArea name="dschedule" value="${schedule.id}"/></div>
                            </div>
                        </g:each>
                    </g:form>
                </div>


                <p>
                    <a href="schedule" class="btn-floating waves-effect waves-light red"><i
                            class="material-icons">add</i></a>
                    Agregar horario
                </p>

            </div>
        </div>
    </div>


    <!--
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

<script>
    $(document).ready(function () {
        $('#message').delay(5000).fadeOut('slow');
    });
</script>

</body>
</html>