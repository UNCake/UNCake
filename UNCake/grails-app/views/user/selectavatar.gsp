<%--
  Created by IntelliJ IDEA.
  User: Usuario
  Date: 16/11/2015
  Time: 02:15 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>
<fieldset>
    <legend>Avatar Upload</legend>
    <g:uploadForm action="upload_avatar">
        <label for="avatar">Avatar (16K)</label>
        <input type="file" name="avatar" id="avatar" />
        <div style="font-size:0.8em; margin: 1.0em;">
            For best results, your avatar should have a width-to-height ratio of 4:5.
            For example, if your image is 80 pixels wide, it should be 100 pixels high.
        </div>
        <input type="submit" class="buttons" value="Upload" />
    </g:uploadForm>
</fieldset>
</body>
</html>