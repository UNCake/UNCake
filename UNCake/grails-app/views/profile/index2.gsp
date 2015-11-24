<%--
  Created by IntelliJ IDEA.
  User: Usuario
  Date: 23/11/2015
  Time: 07:09 PM
--%>

<%@ page import="uncake.ProgressController" contentType="text/html;charset=UTF-8" %>
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

    <script>

    </script>
</head>

<body style=" background-color:rgba(0, 0, 0, 0.2); ">

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
                        <a class="page-scroll" href="/profile"><span class="glyphicon glyphicon-user"></span>Hola ${session.user.name.split()[0]}!</a>
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

    <br>
    <div class="row">
        <div class= "col-md-4 col-sm-4">
            <g:if test="${ftg.avatar == null}">
                <img src="${resource(dir: 'images', file: 'avatar.png')}" class="img-responsive">

            </g:if>
            <g:if test="${ftg.avatar != null}">
                <img class=" img-responsive  " style="text-align: center" src="${createLink(controller:'user', action:'avatar_image', id:ftg.ident())}" />
            </g:if>

        </div>
        <div class= " col-md-8 col-sm-8">
            <div class="row">
                <p class="row font-usuario " style="margin-right: 0px ; margin-left: 0px" >
                    <g:if test="${ftg != null}">
                        ${ftg.name}

                    </g:if>
                </p>
            </div>
            <div class="row">
                <a href="/profile" class=" btn btn-default btn-lg" style="margin-top: 10%">Volver</a>
            </div>


        </div>
    </div>
    <br>
    <br>
    <div class="row">
        <div class="col-md-9 col-sm-9">
            <img src="${resource(dir: 'images', file: 'horario.png')}" class="img-responsive">

        </div>

    </div>






    <!-- <a href="#" class="btn btn-primary btn-xs" >Agregar amigos</a>-->


</div>

</body>
</html>