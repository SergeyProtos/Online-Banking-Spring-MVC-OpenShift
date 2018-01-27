<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>TopBank Online Banking</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <style>
        <%@include file="index.css"%>
    </style>
</head>
<body>
<h3 class="title" align="center">Welcome in TopBank Online Banking</h3>
<h4 class="message" align="center">${message}</h4>
<div id="form" align="center">
    <form action="/login" method="POST">
        <fieldset>
            <p align="center"><b>If you're registered user sign in below</b></p>
            <p align="center"><b>or use default user credentials</b></p>
            Login: <br>
            <input type="text" name="login" value="user"><br>
            Password: <br>
            <input type="text" name="password" value="user"><br>
            <input class="btn btn-primary" type="submit" value="Sign in"/><br>
            <p align="center"><b>If you're new user sign up below</b></p>
            <%--<button class="btn btn-primary" type="button" id="sign-up">Sign up</button><br>--%>
            <button type="button" class="btn btn-primary" onclick="window.location.href='sign-up.jsp'">Sign up</button>
        </fieldset>
    </form>
</div>
<%--<script type="text/javascript">--%>
<%--$('#sign-up').click(function () {--%>
<%--window.location.href = 'sign-up.jsp'--%>
<%--})--%>
<%--</script>--%>
</body>
</html>
