<%--
  Created by IntelliJ IDEA.
  User: alej0
  Date: 02/10/2015
  Time: 21:08
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>UNCake</title>


    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="agency.css"/>

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
</head>

<body id="page-top" class="index">

<div id="wrapper">

<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
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

                <g:textField name="selectedName" id="selectedName" placeholder="Digita nombre" value="" ></g:textField>


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
                <h4>Universidad Nacional de Colombia 2015</span>
            </div>
        </div>
    </div>
</footer>

<asset:javascript src="jquery.js"/>
<asset:javascript src="bootstrap.min.js"/>

<asset:javascript src="classie.js"/>
<asset:javascript src="cbpAnimatedHeader.js"/>

<asset:javascript src="agency.js"/>
<asset:javascript src="foundation/vendor/jquery.js"/>
<asset:javascript src="foundation/foundation.min.js"/>

<asset:javascript src="foundation/vendor/jquery.js"/>
<asset:javascript src="foundation/jquery-ui/jquery-ui.js"/>
<asset:javascript src="foundation/foundation/foundation.js"/>
<g:javascript>
$(function() {
    $( "#selectedName" ).autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "${createLink(controller: 'Home', action: 'getAllNames')}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: {
                    maxRows: 12,
                    name_startsWith: request.term
                },
                success: function( data ) {
                    response( $.map( data, function( item ) {
                        return {
                            label: item,
                            value: item
                        }
                    }));
                }
            });
        }
    });
});
</g:javascript>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

</div>

</body>
</html>