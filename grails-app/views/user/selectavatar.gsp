<%--
  Created by IntelliJ IDEA.
  User: Usuario
  Date: 16/11/2015
  Time: 02:15 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:javascript src="bootstrap/js/bootstrap.min.js"/>
    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="schedule.css"/>
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
            <a class="navbar-brand page-scroll" href="/home">UNCake</a>
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
<div class="container">

    <g:uploadForm action="upload_avatar">
        <div class="jumbotron" style="background-color: #a6e1ec">
            <h2>Subir o Actualizar Foto</h2>
            <input class="btn" type="file" name="avatar" id="avatar" />
            <g:if test="${flash.message!=null}">
                <div class="alert alert-danger">
                    <strong>${flash.message}</strong>
                </div>
            </g:if>

            <input type="submit" class="btn-success" value="Subir" />
        </div>

    </g:uploadForm>

</div>
</body>
</html>