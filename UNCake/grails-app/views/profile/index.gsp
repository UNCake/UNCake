<%--
  Created by IntelliJ IDEA.
  User: Usuario
  Date: 16/11/2015
  Time: 07:44 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
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
    <asset:stylesheet src="profile.css"/>
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
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
                        <a class="page-scroll" href="register"><span class="glyphicon glyphicon-user"></span>Registrarme</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="login"><span class="glyphicon glyphicon-log-in"></span>Ingresar</a>
                    </li>
                </ul>

            </div>

        </g:if>

        <g:if test="${session.user != null}">

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >

                <ul class="nav navbar-nav navbar-right">

                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="profile"><span class="glyphicon glyphicon-user"></span>Hola ${session.user.name.split()[0]}!</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="/logout"><span class="glyphicon glyphicon-log-out"></span>Salir</a>
                    </li>
                </ul>

            </div>
        </g:if>


    </div>
</nav>

<div class="container " >
    <h1 class="row text-center " >
        ${session.user.name}
    </h1>

    <div class="row">
        <div class= "">
        <img class=" img-responsive img-centered " style="text-align: center" src="${createLink(controller:'user', action:'avatar_image', id:session.user.ident())}" />
        </div>
        <div class= "text-center">

            <div class="row">
                <a class="text-center  " href="/changephoto" title="Cambia foto." >Cambiar o subir una foto</a>
            </div>
            <div class="row">
                <a class="text-center  " href="/changepassword" title="Cambia tu contraseña." >Cambiar Contraseña</a>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="list-group">
            <h4>
            Mis historias academicas
            </h4>
            <g:if test="${academicRecords.size() == 0}">
                No tienes ninguna historia academica
            </g:if>
            <g:each  in="${academicRecords}">
                <a href="#" class="list-group-item" style="background-color: burlywood">${it.studyPlan.name}</a>
            </g:each>
        </div>
        <a href="#" class="btn btn-primary btn-xs" >Agregar historia academica</a>
    </div>
    <div class="row">
        <h4>
            Mis horarios
        </h4>
        <div class="list-group">
            <g:if test="${schedules.size() == 0}">
                Aun no tienes horarios creados
            </g:if>

            <g:each in="${schedules}">
                <a href="#" class="list-group-item" style="background-color: burlywood"> ${it.name} </a>
            </g:each>
        </div>
        <a href="#" class="btn btn-primary btn-xs" >Agregar horario</a>
    </div>
    <div class="row ">
        <h4>
            Mis Amigos
        </h4>
        <div class="list-group " >

            <g:if test="${friends.size() == 0}">
                Aun no tienes amigos
            </g:if>

            <g:each  in="${friends}"  >
                <div class="cont" >
                    <a href="#" class="list-group-item small-size size-list" style="background-color: #d8d8d8 ">${it.email}</a>
                    <button  type="submit" class="btn btn-primary btn-xs size-btn">x</button>

                </div>

            </g:each>

        </div>
        <!-- <a href="#" class="btn btn-primary btn-xs" >Agregar amigos</a>-->
    </div>

</div>

</body>
</html>