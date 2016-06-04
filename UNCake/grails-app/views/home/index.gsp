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
            <div class="row" style="padding-top: 80px;">
                <div>
                    <img src="${resource(dir: 'images', file: 'logo2.png')}" style="width: 36%">
                    <img src="${resource(dir: 'images', file: 'nombreLogo2.png')}" style="width: 60%">
                    <!--<h3 style="color: #333;">Planea tu horario de clases, haz seguimiento a tu PAPA y busca edificos en el campus.</h3>-->
                </div>

                <div>
                    <div class="col-md-4 col-sm-6 portfolio-item">
                        <div class="portfolio-caption">
                            <div class="img-centered">
                                <a href="schedule">
                                    <asset:image src="home/services/icono_horarios.png" alt=""/>
                                </a>
                            </div>
                            <h4>Crear Horario</h4><br>
                        </div>
                    </div>

                    <div class="col-md-4 col-sm-6 portfolio-item">
                        <div class="portfolio-caption">
                            <div class="img-centered">
                                <a href="maps">
                                    <asset:image src="home/services/icono_edificios.png" alt=""/>
                                </a>
                            </div>
                            <h4>Buscar edificio</h4><br>
                        </div>
                    </div>

                    <div class="col-md-4 col-sm-6 portfolio-item">
                        <div class="portfolio-caption">
                            <div class="img-centered">
                                <a href="grades">
                                    <asset:image src="home/services/icono_papa.png" alt=""/>
                                </a>
                            </div>
                            <h4>Mi avance</h4><br>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
</div>
</body>
</html>