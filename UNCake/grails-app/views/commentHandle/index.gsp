<%--
  Created by IntelliJ IDEA.
  User: Alejandro
  Date: 11/11/2015
  Time: 10:05 PM
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
    <asset:stylesheet src="commentsIndex.css"/>
    <title>UNCake</title>

    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="dialogueStyle.css"/>

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
</head>
<body id="page-top" class="index">
<label id="lblid"></label>
<script>
    $(function () {
        document.getElementById('selectedName').style.visibility = "hidden";
        document.getElementById('lblid').style.visibility = "hidden";
        document.getElementById('codetxt').style.visibility = "hidden";
        document.getElementById('lbllogin').style.visibility = "hidden";
        document.getElementById('lblregister').style.visibility = "hidden";
        var availableTags = $.parseJSON('${coursesNameList.encodeAsJSON()}');
        $("#searchCourse").autocomplete({
            source: availableTags
        });
        $("#searchCourse").bind("keypress", function(e) {
            if(e.keyCode==13){
                //console.log(session.user)
                var selected = document.getElementById('searchCourse').value;
                console.log(selected)
                if (selected != "") {
                    //document.getElementById("diagNombre").value = document.getElementById("selectedName").value;
                    var url = "${createLink(controller:'CommentHandle', action:'getCourseByName')}";
                    var response = $.ajax({
                        url: url,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: {
                            selectedName: selected
                        },
                        success: function (courseValues) {
                            //userValues ya tiene todos los datos del usuario. Hasta la foto :O
                            if(courseValues.name != "null") {
                                document.getElementById('courseNameTittle').innerHTML = courseValues.name;
                                document.getElementById('courseNumCommentTittle').innerHTML = courseValues.comments.length;
                                document.getElementById('lblid').value = courseValues.id;
                                document.getElementById('codetxt').value = courseValues.id;
                                el = document.getElementById("overlay");
                                //console.log(document.getElementById("diagNombre").innerHTML);
                                el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
                            }
                        }
                    });
                }
            }
        });
    });
</script>
<script>
    function overlay(a) {
        var selected = a;
        var url = "${createLink(controller:'CommentHandle', action:'getCourseById')}";
        var response = $.ajax({
            url: url,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: {
                selectedName: selected
            },
            success: function (courseValues) {
                //console.log(courseValues.comments[courseValues.comments.length-1].id)
                document.getElementById('courseNameTittle').innerHTML = courseValues.name;
                document.getElementById('courseNumCommentTittle').innerHTML = courseValues.comments.length;
            }
        });
        document.getElementById('lblid').value = a;
        document.getElementById('codetxt').value = a;
        el = document.getElementById("overlay");
        //console.log(document.getElementById("diagNombre").innerHTML);
        el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
    }
</script>
<div id="overlay">
    <div class="container">
        <g:form method="GET" action="comments" target="_blank">
            <p class="text-warning">Click aqui para [<a href='#' onclick='overlay()'>cerrar</a>]</p>
            <h1 id="courseNameTittle"></h1>
            <br>
            <g:textField name="code" id="codetxt"></g:textField>
            <h5>Numero de comentarios:</h5>
            <h6 id="courseNumCommentTittle"></h6>
            <br>
            <button class="btn btn-lg btn-primary btn-block color-black" type="submit" value='Login'>Ver Todos  o  Comentar</button>
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
            <div class="header">
                <div class="row box well">
                    <div class="portfolio-item">
                        <br>
                        <h3>Busca materias y los comentarios que la comunidad tiene acerca de ellas.</h3>
                        <input class="form-control" id="searchCourse" name="searchCourse" placeholder="Busca materias" style="text-align:center;border-color: transparent; background-color: #1ab394;font-weight: 700; color: #fff;">
                    </div>
                    <br><br>
                </div>
            </div>
        </div>
    </header>
    <section id="portfolio">
        <div class="container" id="" style="overflow-y: scroll; height:400px;">
            <div class="row">
                <g:each in="${coursesList}" var="p">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading" style="background-color: #222">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-comments fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">Código ${p.code}</div>
                                        <div>${p.name}</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer" onclick="overlay(${p.id})">
                                    <span class="pull-left">Ver Detalles</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </g:each>
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