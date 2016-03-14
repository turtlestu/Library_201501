<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head><title>Login-Failed</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<div align="center" style="padding-top:15%;">
<p><font size="5">No such username or password</font></p>
<input type='button' onclick="backtologin()" class='css_button' value='back to login'>
</div>
</body>
<script type="text/javascript">
	function backtologin(){
		window.location='./';
	}
</script>
</html>