<%--
  Created by IntelliJ IDEA.
  User: alej0
  Date: 02/10/2015
  Time: 21:08
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ defaultCodec="none" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

    <title>UNCake</title>


    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="agency.css"/>

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
</head>
<style>
<%--
.navbar-default{
    background-color: transparent !important;
}
.navbar-default.navbar-shrink{
    background-color: #2c8bc9 !important;
}--%>
.form-control{
    margin-top: 8px;
}

.ui-autocomplete {
    max-height: 100px;
    overflow-y: auto;
    /* prevent horizontal scrollbar */
    overflow-x: hidden;
}
/* IE 6 doesn't support max-height
     * we use height instead, but this forces the menu to always be this tall
     */
* html .ui-autocomplete {
    height: 100px;
}
</style>

<body id="page-top" class="index">
<script>
    $(function () {
        var availableTags = $.parseJSON('${userlist.encodeAsJSON()}');
        $("#selectedName").autocomplete({
            source: availableTags
        });/*
         $("#selectedName").bind("keypress", function(e) {
         if(e.keyCode==13){
         console.log(document.getElementById('selectedName').value)

         }
         });*/
    });
</script>

<div id="wrapper">
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">UNCake</a>
            </div>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <g:form class="form-signin" action="saveFriend" method="post">
                            <input type="input" class="form-control" id="selectedName" name="selectedName" placeholder="Digita Nombre" style="text-align:center">
                        </g:form>
                    </li>

                    <li>
                        <a class="page-scroll" href="#about">Registrarme</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#services">Ingresar</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <header>
        <div class="container">
            <div class="intro-text">
                <div class="row">
                    <div class="portfolio-item">
                        <br>

                        <h3 style="color: #333;">Planea tu horario de clases, haz seguimiento a tu PAPA y busca edificos en el campus.</h3>
                    </div>
                    <br><br>
                </div>
            </div>
        </div>
    </header>
    <section id="portfolio">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <div class="portfolio-caption">
                        <div class="img-centered">
                            <a href="#" class="portfolio-link" data-toggle="modal">
                                <asset:image src="home/services/icono_horarios.png" alt=""/>
                            </a>
                        </div>
                        <h4>Crear Horario</h4><br>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 portfolio-item">
                    <div class="portfolio-caption">
                        <div class="img-centered">
                            <a href="#">
                                <asset:image src="home/services/icono_edificios.png" alt=""/>
                            </a>
                        </div>
                        <h4>Buscar edificio</h4><br>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 portfolio-item">
                    <div class="portfolio-caption">
                        <div class="img-centered">
                            <a href="#" class="portfolio-link" data-toggle="modal">
                                <asset:image src="home/services/icono_papa.png" alt=""/>
                            </a>
                        </div>
                        <h4>Mi avance</h4><br>
                    </div>
                </div>
            </div>
        </div>
        <br><br>
    </section>
    <footer>
        <div class="container">
            <div class="row">
                <div>
                    <h4>Universidad Nacional de Colombia 2015</h4>
                </div>
            </div>
        </div>
    </footer>
</div>

</body>
</html>