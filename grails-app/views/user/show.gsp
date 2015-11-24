<%--
  Created by IntelliJ IDEA.
  User: Usuario
  Date: 16/11/2015
  Time: 02:17 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <asset:stylesheet src="profile.css"/>
</head>

<body>
<g:if test="${session.user.avatar}">
    <img class="avatar" src="${createLink(controller:'user', action:'avatar_image', id:session.user.ident())}" />
</g:if>
</body>
</html>