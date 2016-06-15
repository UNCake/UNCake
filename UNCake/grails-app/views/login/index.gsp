<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="navbar"/>
    <title>Entrar</title>

    <asset:stylesheet src="signin.css"/>
</head>

<body>

<div class="container">

    <g:form class="form-signin" action="doLogin" method="post" useToken="true">

        <form class="form-signin">
            <div class="col s12 z-depth-4 card-panel">
                <h2 class="form-signin-heading font-uncake" align="center">UNCake</h2>

                <div class="form-group">
                    <label>Email</label>

                    <div style="display: flex">
                        <input type="email" id="email" class="form-control" placeholder="Introduce tu email" required
                               autofocus name="email">

                        <div class="error">${flash.message2}</div>
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 0px">
                    <div class="col-6">
                        <label>Contraseña</label>
                    </div>

                    <div style="display: flex">
                        <input type="password" id="password" class="form-control" placeholder="Introduce tu contraseña"
                               required name='password'>

                        <div class="error">${flash.message2}</div>
                    </div>

                    <div class="error errorm">${flash.message1}</div>
                </div>

                <p>
                    <input type="checkbox" id="rem" value="remember-me">
                    <label for="rem">Recordarme</label>
                </p>

                <button class="btn btn-lg btn-primary btn-block color-black" type="submit" value='Login'>Entrar</button>

                <div>¿No tienes una cuenta?
                    <a href="/register" title="Registrate.">Click aquí para Registrate</a>
                </div>

                <div>
                    <a class="text-center" href="/forgotpassword"
                       title="Solicita una contraseña nueva por correo electrónico.">Olvidé mi contraseña</a>
                </div>
            </div>
        </form>
    </g:form>
</div>

</body>
</html>
