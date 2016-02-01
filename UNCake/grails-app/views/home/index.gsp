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
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="bootstrap/js/bootstrap.min.js"/>
    <asset:javascript src="foundation/jquery-ui/jquery-ui.js"/>
    <asset:stylesheet src="foundation/jquery-ui/jquery-ui.css"/>

    <title>UNCake</title>

    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="dialogueStyle.css"/>

    <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
</head>

<style>
    h4{
        color: #E9E9E9;
    }

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

<body class="index" style="background: url('${resource(dir: "images", file: "home/fotoUN_5.jpg")}'); background-repeat: no-repeat; background-size: 100% 100%;" > <!--id="page-top"-->
    <script>
        $(function () {
            var availableTags = $.parseJSON('${userlist.encodeAsJSON()}');
            $("#selectedName").autocomplete({
                source: availableTags
            });
             $("#selectedName").bind("keypress", function(e) {
                 if(e.keyCode==13){
                     //console.log(session.user)
                     var selected = document.getElementById('selectedName').value;
                     console.log(selected)
                     if (selected != "") {
                         //document.getElementById("diagNombre").value = document.getElementById("selectedName").value;
                         var url = "${createLink(controller:'Home', action:'getUserByName')}";
                         var response = $.ajax({
                             url: url,
                             contentType: "application/json; charset=utf-8",
                             dataType: "json",
                             data: {
                                 selectedName: selected
                             },
                             success: function (userValues) {
                                 //userValues ya tiene todos los datos del usuario. Hasta la foto :O
                                 if(userValues.name != "null") {
                                     document.getElementById("diagNombre").value = userValues.name;
                                     document.getElementById("diagMail").value = userValues.email;
                                     overlay()
                                 }
                             }
                         });
                     }
                 }
             });
        });
    </script>
    <script>
        function overlay() {
            el = document.getElementById("overlay");
            //console.log(document.getElementById("diagNombre").innerHTML);
            el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
        }
    </script>
    <div id="overlay">
        <div class="container">
            <asset:image src="home/services/icono_horarios.png" alt=""/>
            <p class="text-warning">Click aqui para [<a href='#' onclick='overlay()'>cerrar</a>]</p>
            <g:form class="form-signin" action="saveFriend" method="post">
                <input type="input" class="form-control has-success text-warning" id="diagNombre" name="diagNombre" placeholder="Nombre" style="text-align:center; 	background: #1AB394;">
                <input type="input" class="form-control has-success text-warning" id="diagMail" name="diagMail" placeholder="Mail" style="text-align:center; 	background: #1AB394;">
                <%--<p class="text-success" id="diagMail" name="diagMail">alejando@unal.edu.co</p>--%>
                <button class="btn btn-lg btn-primary btn-block color-black" type="submit" value='Login'>Agregar</button>
            </g:form>
        </div>
    </div>
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
                    <a class="navbar-brand page-scroll" href="home">UNCake</a>
                </div>
                <g:if test="${session.user != null}">
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
                        <ul class="nav navbar-nav navbar-right">
                            <li class="hidden">
                                <a href="#page-top"></a>
                            </li>
                            <li>
                                <input type="input" class="form-control" id="selectedName" name="selectedName" placeholder="Digita Nombre" style="text-align:center">
                            </li>

                            <li>
                                <a class="page-scroll" href="profile"><span class="glyphicon glyphicon-user"></span>Hola ${session.user.name.split()[0]}!</a>
                            </li>
                            <li>
                                <a class="page-scroll" href="logout"><span class="glyphicon glyphicon-log-out"></span>Salir</a>
                            </li>
                        </ul>
                    </div>
                </g:if>
                <g:if test="${session.user == null}"   >
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
                        <ul class="nav navbar-nav navbar-right">
                            <li class="hidden">
                                <a href="#page-top"></a>
                            </li>
                             <li>
                                <a class="page-scroll" href="register"><span class="glyphicon glyphicon-user"></span>Registrarme</a>
                            </li>
                            <li>
                                <a class="page-scroll" href="login"><span class="glyphicon glyphicon-log-in"></span>Ingresar</a>
                            </li>
                        </ul>
                    </div>
                </g:if>
            </div>
        </nav>
        <header>
            <div class="container">
                <div class="row" style="padding-top: 80px;">
                    <div>
                        <img src="${resource(dir: 'images', file: 'logo2.png')}" style="background-color: transparent; width: 36%;">
                        <img src="${resource(dir: 'images', file: 'nombreLogo2.png')}" style="background-color: transparent; width: 60%;">
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
                                    <a href="grades" >
                                        <asset:image src="home/services/icono_papa.png" alt=""/>
                                    </a>
                                </div>
                                <h4>Mi avance</h4><br>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <br/><h3 style="color: black;">UNCake 2015</h3><br/>
                </div>
            </div>
        </header>
    </div>
</body>
</html>