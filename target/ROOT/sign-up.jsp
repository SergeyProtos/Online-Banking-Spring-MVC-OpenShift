<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>TopBank Online Banking</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <style>
        <%@include file="sign-up.css"%>
    </style>
</head>
<body>
<h3 class="title" align="center">Welcome in TopBank Online Banking registration form</h3>
<h4 class="message" align="center">${message}</h4>
<div id="form" align="center">
    <form action="/sign_up" method="POST">
        <fieldset>
            <p align="center"><b>Please sign up below</b></p>
            Login*: <br>
            <input type="text" name="login" value="john"><br>
            Password*: <br>
            <input type="text" name="password" value="john"><br>
            Repeat password*: <br>
            <input type="text" name="passwordRepeat" value="john"><br>
            First Name*: <br>
            <input type="text" name="firstName" value="John"><br>
            Last Name*: <br>
            <input type="text" name="lastName" value="Johnson"><br>
            E-mail: <br>
            <input type="text" name="email" value=""><br>
            Phone: <br>
            <input type="text" name="phone" value=""><br>
            *Mandatory data<br>
            <input class="btn btn-primary" type="submit" value="Sign up"/><br>
            <p align="center"><b>Back to sign in form</b></p>
            <button type="button" class="btn btn-primary" onclick="window.location.href='index.jsp'">Sign in</button>
        </fieldset>
    </form>
</div>
</body>
</html>
