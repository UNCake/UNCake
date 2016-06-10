<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="navbar"/>
    <title>Registrarse</title>

    <asset:stylesheet src="signin.css"/>
</head>

<body>

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
            <input title="La contraseña debe tener entre 7 y 15 caracteres alfanuméricos" type="password"  class="form-control" placeholder="Contraseña" required pattern="[0-9a-zA-Z]{7,15}" name="pwd1" onchange="
                this.setCustomValidity(this.validity.patternMismatch ? this.title : '');
                if(this.checkValidity()) form.pwd2.pattern = this.value;" >

        </div>
        <div class="form-group" >
            <label class="sr-only">Confirma la contraseña</label>
            <input title="Las contraseñas deben coincidir" type="password"  class="form-control" placeholder="Confirma la contraseña" required pattern="[0-9a-zA-Z]{7,15}" name="pwd2" onchange="
                this.setCustomValidity(this.validity.patternMismatch ? this.title : '');" >
        </div>
        <div class="error errorm">${flash.message1}</div>
        <button class="btn btn-lg btn-primary btn-block color-black "    type="submit">Registrarse</button>
        <div>¿Ya estas registrado?
            <a href="/login" title="Entrar" >Click aquí para Entrar</a>
        </div>
    </form>
</g:form>
</div> <!-- /container -->

</body>
</html>