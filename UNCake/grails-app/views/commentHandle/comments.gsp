<%--
  Created by IntelliJ IDEA.
  User: santiago
  Date: 11/11/15
  Time: 11:46 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="bootstrap/js/bootstrap.min.js"/>
    <asset:javascript src="foundation/jquery-ui/jquery-ui.js"/>
    <asset:stylesheet src="foundation/jquery-ui/jquery-ui.css"/>
    <asset:javascript src="commentHandle/commentHandle.js"/>

    <title>Comentarios</title>

    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="dialogueStyle.css"/>

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
</head>

<body>
<g:if test="${session.user != null}">
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
            <a class="navbar-brand page-scroll" href="../home">UNCake</a>
        </div>
    </div>
</nav>


<br><br><br><br>
<h1 class="text-center"> ${name}:</h1>
<br>

<h4 class="text-center">Comentarios:</h4>
<br>
<%
    def top = comments.size()-1
%>
<div class="container-fluid">
    <ul class="list-group" id="commentList">
        <g:each in="${0..top}" var="t">
            <g:if test="${t >= 0}">
                <li class="list-group-item col-md-8 well well-sm">
                <!-- <h3>Comentario: ${t+1}<br></h3> -->
                    <g:if test="${comments[t].date != null}">
                        <small>Fecha: ${comments[t].date.format('MM/dd/yyyy - h:m:s a')}</small>
                    </g:if>
                    <g:if test="${comments[t].user != null}">
                        <h3>${comments[t].user.name} escribio:</h3>
                    </g:if>
                    <g:else>
                        <h3>Anon escribio:</h3>
                    </g:else>
                    <p>${comments[t].comment}<br></p>
                </li>
            </g:if>
        </g:each>
    </ul>
</div>
<br>
<div class="container-fluid">
    <% def link = "${createLink(controller: 'commentHandle', action: 'saveComment')}" %>
    <form name="submitComment" class="col-md-8" method="POST">
        <div class="form-group">
        <textArea id="text" placeholder="Escribir un comentario" class="form-control"></textArea>
        </div>
        <button onclick="saveComment('${link}', '${code}', '${session.user.id}', '${session.user.name}')" id="subbutton" type="button" class="btn btn-default">Enviar</button>
    </form>
</div>
</g:if>
</body>
</html>















