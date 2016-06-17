<!doctype html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <title>
        <g:layoutTitle default="UNCake"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="materialize/css/materialize.css"/>

    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <g:layoutHead/>
</head>

<body>

<div class="navbar-fixed">
    <nav class="navbar-default">
        <div class="nav-wrapper">
            <a href="/home" class="brand-logo navbar-brand">UNCake</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>

            <g:if test="${session.user != null}">
                <ul class="right hide-on-med-and-down">
                    <li class="valign-wrapper">
                        <g:if test="${session.user.avatar == null}">
                            <i class="material-icons left">account_circle</i>
                        </g:if>
                        <g:if test="${session.user.avatar != null}">
                            <img class="circle" style="height: 30px; width: 30px"
                                 src="${createLink(controller: 'user', action: 'avatar_image', id: session.user.ident())}"/>
                        </g:if>
                        <a href="/profile" class="valign">
                            Hola ${session.user.name.split()[0]}!</a></li>
                    <li><a href="/logout"><i class="material-icons left">exit_to_app</i>
                        Salir</a></li>
                </ul>
                <ul class="side-nav" id="mobile-demo">
                    <li class="valign-wrapper">
                        <g:if test="${session.user.avatar == null}">
                            <i class="material-icons left">account_circle</i>
                        </g:if>
                        <g:if test="${session.user.avatar != null}">
                            <img class="circle" style="height: 30px; width: 30px"
                                 src="${createLink(controller: 'user', action: 'avatar_image', id: session.user.ident())}"/>
                        </g:if>
                        <a href="/profile" class="valign">
                        Hola ${session.user.name.split()[0]}!</a></li>
                    <li><a href="/logout"><i class="material-icons left">exit_to_app</i>
                        Salir</a></li>
                </ul>
            </g:if>

            <g:if test="${session.user == null}">
            <ul class="right hide-on-med-and-down">
                <li><a href="/register"> <i class="material-icons left">account_circle</i>
                    Registrarme</a></li>
                <li><a href="/login"><i class="material-icons left">exit_to_app</i>
                    Ingresar</a></li>
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <li><a href="/register"> <i class="material-icons left">account_circle</i>
                    Registrarme</a></li>
                <li><a href="/login"><i class="material-icons left">exit_to_app</i>
                    Ingresar</a></li>
            </ul>
            </g:if>
        </div>
    </nav>
</div>

<asset:javascript src="jquery-2.2.0.min.js"/>
<asset:javascript src="materialize/js/materialize.js"/>
<script>
    $().ready(function(){
        $(".button-collapse").sideNav();
    })
</script>

<g:layoutBody/>
<div class="footer"><p style="color: black; text-align: center">UNCake &copy; 2016</p></div>

</body>
</html>
