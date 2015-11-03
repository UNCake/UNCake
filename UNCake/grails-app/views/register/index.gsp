<%--
  Created by IntelliJ IDEA.
  User: Usuario
  Date: 06/10/2015
  Time: 07:28 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Registrarse</title>

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <asset:stylesheet src="signin.css"/>

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container ">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand font-uncaket" href="home">UNCake</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">

        </div><!--/.nav-collapse -->
    </div>
</nav>
<div class="container center-contatiner-r">
    <g:form class="form-signin" action="doRegister" method="post">
    <form class="form-signin">
        <h2 class="form-signin-heading " align="center">Registrate ya!</h2>
        <div class="form-group">
            <label class="sr-only">Nombre</label>
            <input type="text" id="inputText" class="form-control" placeholder="Nombre" required name="nombre">
        </div>
        <div class="form-group" >
            <label class="sr-only">Correo electrónico</label>
            <input type="email" class="form-control" placeholder="Correo electrónico" required name="email"  >
        </div>
        <!--   Confirmacion de email eliminada, no es necesario      <div class="form-group" >
            <label class="sr-only">Confirma el email</label>
            <input type="email"  class="form-control" placeholder="Confirma el email" required >
        </div>-->
        <div class="form-group" >
            <label class="sr-only">Contraseña</label>
            <input title="La contraseña debe tener minimo 7 caracteres e incluir números y letras" type="password"  class="form-control" placeholder="Contraseña" required pattern="(?=.*\d)(?=.*[a-z]).{6,}" name="pwd1" onchange="
                this.setCustomValidity(this.validity.patternMismatch ? this.title : '');
                if(this.checkValidity()) form.pwd2.pattern = this.value;" >

        </div>
        <div class="form-group" >
            <label class="sr-only">Confirma la contraseña</label>
            <input title="Las contraseñas deben coincidir" type="password"  class="form-control" placeholder="Confirma la contraseña" required pattern="(?=.*\d)(?=.*[a-z]).{6,}" name="pwd2" onchange="
                this.setCustomValidity(this.validity.patternMismatch ? this.title : '');" >
        </div>
        <div class="error errorm">${flash.message1}</div>
        <button class="btn btn-lg btn-primary btn-block color-black "    type="submit">Registrarse</button>
        <div>¿Ya estas registrado?
            <a href="/login/index" title="Entrar" >Click aquí para Entrar</a>
        </div>
    </form>
</g:form>
</div> <!-- /container -->


<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>