<%--
  Created by IntelliJ IDEA.
  User: santiago
  Date: 11/11/15
  Time: 11:46 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Comentarios</title>
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="foundation/jquery-ui/jquery-ui.js"/>
    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="foundation/jquery-ui/jquery-ui.css"/>
</head>

<body>
<h1> ${name}:</h1>
<br>

<h4>Comentarios:</h4>
<br>
<% def limit=5 %>
<div class="container-fluid">
<g:each in="${0..limit}" var="t">

    <g:if test="${t < comments.size()}">
        <div class="container col-md-8 well well-sm">
        <h3>Comentario: ${t}<br></h3>
        <p>${comments[t].comment}<br></p>
        </div>
    </g:if>

</g:each>
</div>

<div class="container-fluid">
<g:form class="col-md-8" action="saveComment">
    <div class="form-group">
    <g:textArea name="comment" placeholder="Escribir un comentario" class="form-control"></g:textArea>
    </div>
    <g:submitButton name="submit" value="Enviar" class="btn btn-default"></g:submitButton>
</g:form>
</div>
</body>
</html>