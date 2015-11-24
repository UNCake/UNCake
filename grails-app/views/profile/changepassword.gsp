<%--
  Created by IntelliJ IDEA.
  User: Usuario
  Date: 22/11/2015
  Time: 09:16 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>

    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:javascript src="bootstrap/js/bootstrap.min.js"/>
    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="profile.css"/>
    <asset:stylesheet src="signin.css"/>
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
</head>

<body style="padding-top: 0">
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

<div class="container center-contatiner-r">
    <g:form class="form-signin" action="changePass" method="post">
        <form class="form-signin">
            <h2 class="form-signin-heading " align="center">Cambiar Contraseña</h2>
            <div class="form-group" >
                <label class="sr-only">Contraseña actual</label>
                <input type="password" class="form-control" placeholder="Contraseña actual" required name="actPass"  >
            </div>
            <!--   Confirmacion de email eliminada, no es necesario      <div class="form-group" >
            <label class="sr-only">Confirma el email</label>
            <input type="email"  class="form-control" placeholder="Confirma el email" required >
        </div>-->
            <div class="form-group" >
                <label class="sr-only">Contraseña nueva</label>
                <input title="La contraseña debe tener minimo 7 caracteres e incluir números y letras" type="password"  class="form-control" placeholder="Contraseña" required pattern="(?=.*\d)(?=.*[a-z]).{6,}" name="pass" onchange="
                    this.setCustomValidity(this.validity.patternMismatch ? this.title : '');
                    if(this.checkValidity()) form.pwd2.pattern = this.value;" >

            </div>
            <div class="form-group" >
                <label class="sr-only">Confirma la contraseña</label>
                <input title="Las contraseñas deben coincidir" type="password"  class="form-control" placeholder="Confirma la contraseña" required pattern="(?=.*\d)(?=.*[a-z]).{6,}" name="pass2" onchange="
                    this.setCustomValidity(this.validity.patternMismatch ? this.title : '');" >
            </div>
            <div class="error errorm">${flash.message1}</div>
            <button class="btn btn-lg btn-primary btn-block color-black "    type="submit">Cambiar contraseña</button>

        </form>
    </g:form>
</div> <!-- /container -->


<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>