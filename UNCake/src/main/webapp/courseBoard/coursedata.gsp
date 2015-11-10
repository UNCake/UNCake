<!DOCTYPE html>
<html>
<head>
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="foundation/jquery-ui/jquery-ui.js"/>
    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="schedule.css"/>
    <asset:stylesheet src="foundation/jquery-ui/jquery-ui.css"/>
    <asset:javascript src="courseboard/courseboard.js"/>
    <asset:stylesheet src="courseboard.css"/>
</head>
<body>
<div class="container-fluid">
    <g:form name="myForm" url="[controller:'courseBoard',action:'saveComment']">
        <div class="form-group">
            <label for="comment">Anadir comentario:</label>
            <g:textArea id="comment" name="myField" placeholder="Inserte su comentario" class="form-control"/>
            <g:actionSubmit value="Enviar" class="btn btn-default"/>
        </div>
    </g:form>
</div>
</body>
</html>