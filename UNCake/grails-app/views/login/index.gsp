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

    <title>Entrar</title>

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
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand font-uncaket" href="#">UNCake</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">

        </div><!--/.nav-collapse -->
    </div>
</nav>


<div class="container center-contatiner">


<g:form class="form-signin" action="doLogin" method="post">
    <form class="form-signin">
        <h2 class="form-signin-heading font-uncake" align="center">UNCake</h2>
        <div class="form-group">
            <label >Email</label>
            <div style="display: flex">
                <input type="email" id="email" class="form-control"  placeholder="Introduce tu email" required autofocus name="email">
                <div class="error">${flash.message2}</div>
            </div>
        </div>
        <div class="form-group" >
            <div style="display: flex">
                <div class="col-6">
                    <label >Contraseña</label>
                </div>

                <div class="col-6">
                    <a class="text-center" href="/forgotpassword" title="Solicita una contraseña nueva por correo electrónico." >Olvidé mi contraseña</a>
                </div>
            </div>
            <div style="display: flex">
                <input type="password" id="password" class="form-control" placeholder="Introduce tu contraseña" required name='password'>
                <div class="error">${flash.message2}</div>
            </div>
            <div class="error errorm">${flash.message1}</div>

        </div>

        <label>
            <input type="checkbox" value="remember-me"> Recordarme
        </label>

        <button class="btn btn-lg btn-primary btn-block color-black"    type="submit"  value='Login'>Entrar</button>
        <div>¿No tienes una cuenta?
            <a href="/register/index" title="Registrate." >Click aquí para Registrate</a>
        </div>


    </form>
</g:form>
</div> <!-- /container -->


<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
