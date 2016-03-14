<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<head>
<title>Library Login</title>
<link rel="stylesheet" href="css/style.css">
<style>
div {
padding-top:15%;
}
</style>
</head>
<body>

<div align="center" style="padding-top:15%;">
<p><font size="5">Library System Login</font></p>
<form action="login" method="post">
<table>
<tr>
<td align="right"><p class='content'>Username:</p></td>
<td><input type="text" name="username" class="textbox"></td>
</tr>
<tr>
<td align="right"><p class='content'>Passowrd:</p></td>
<td><input type="password" name="password" class="textbox"></td>
</tr>
</table>
<p><input type="submit" name="login" class='css_button' value="Login"></p>
</form>
</div>
</body>

</html>