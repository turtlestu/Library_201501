<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%session.invalidate();%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head><title>Logout</title>
<link rel="stylesheet" href="css/style.css">

</head>
<body>
<div align="center" style="padding-top:15%;">
<p><font size="5">You have logged out Library Management System.</font></p>
<button onclick="backtologin()" class='css_button'>back to login</button>
</div>
</body>
<script type="text/javascript">
function backtologin(){
		window.location='./';
	}
</script>
</html>