<html>
<head>
    <meta name="layout" content="navbar"/>
    <title>Seleccionar imagen</title>

    <asset:stylesheet src="profile.css"/>
</head>

<body>
<div class="container">
    <br>
    <g:uploadForm action="upload_avatar">
        <div class="jumbotron" style="background-color: #a6e1ec">
            <h2>Subir o Actualizar Foto</h2>
            <input class="btn" type="file" name="avatar" id="avatar" />
            <g:if test="${flash.message!=null}">
                <div class="alert alert-danger">
                    <strong>${flash.message}</strong>
                </div>
            </g:if>

            <input type="submit" class="btn-success" value="Subir" />
        </div>

    </g:uploadForm>

</div>
</body>
</html>