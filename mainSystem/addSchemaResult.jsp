<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript">
	function backtomain(){
	parent.frames['main'].location.reload();
					self.location.href='searchSchema.jsp';
	}
</script>
</head>
<body>
<div align="center" style="padding-top:15%;">
Add a schema Success.<br><br>
<input type="button" class='css_button' value="Back to Seaech Schema Page" onClick="backtomain()"> 
</div>
</body>
</html>