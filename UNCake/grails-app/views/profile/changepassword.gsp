<html>
<head>
    <meta name="layout" content="navbar"/>
    <title>Cambiar contraseña</title>

    <asset:stylesheet src="profile.css"/>
    <asset:stylesheet src="signin.css"/>
</head>

<body style="padding-top: 0">

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

</body>
</html>