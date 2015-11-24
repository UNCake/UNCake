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
    <asset:javascript src="commentHandle/commentHandle.js"/>

    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:stylesheet src="agency.css"/>
    <asset:stylesheet src="dialogueStyle.css"/>
</head>

<body>
<h1> ${name}:</h1>
<br>

<h4>Comentarios:</h4>
<br>
<%  def limit=5
    def top = comments.size()-1
%>
<div class="container-fluid">
    <ul class="list-group" id="commentList">
        <g:each in="${top-4..top}" var="t">
                <% if(t < 0)
                    t = 0 %>
            <g:if test="${t > 0}">
                <li class="list-group-item col-md-8 well well-sm">
                <h3>Comentario: ${t}<br></h3>
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
        <button onclick="ajaxTest('${link}', '${code}')" id="subbutton" type="button" class="btn btn-default">Enviar</button>
    </form>
</div>
</body>
</html>















