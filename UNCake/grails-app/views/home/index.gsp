<!doctype html>
<html>
<head>
    <meta name="layout" content="navbar"/>
    <title>UNCake</title>

    <style>
    body {
        background: url('${resource(dir: "images", file: "home/fotoUN_5.jpg")}');
        background-repeat: no-repeat;
        background-size: 100% 100%;
    }
    </style>
</head>

<body class="index">

<div id="wrapper">

    <header>
        <div class="container">
            <div class="row">
                <div>
                    <img src="${resource(dir: 'images', file: 'logo2.png')}" style="width: 36%">
                    <img src="${resource(dir: 'images', file: 'nombreLogo2.png')}" style="width: 60%">
                    <!--<h3 style="color: #333;">Planea tu horario de clases, haz seguimiento a tu PAPA y busca edificos en el campus.</h3>-->
                </div>

                <div>
                    <div class="col s12 m4">
                        <div class="center-align">
                            <a href="/schedule">
                                <asset:image src="home/services/icono_horarios.png" alt=""/>
                                <h4 class="flow-text white-text">Crear Horario</h4><br>
                            </a>
                        </div>
                    </div>

                    <div class="col s12 m4">
                        <div class="center-align">
                            <a href="/maps">
                                <asset:image src="home/services/icono_edificios.png" alt=""/>
                                <h4 class="flow-text white-text">Buscar edificio</h4><br>
                            </a>
                        </div>
                    </div>

                    <div class="col s12 m4">
                        <div class="center-align">
                            <a href="/grades">
                                <asset:image src="home/services/icono_papa.png" alt=""/>
                                <h4 class="flow-text white-text">Mi avance</h4><br>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
</div>
</body>
</html>