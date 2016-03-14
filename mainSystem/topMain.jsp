<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<% String firstName = (String)session.getAttribute("firstName_login"); 
	String lastName = (String)session.getAttribute("lastName_login"); 
	String role =(String)session.getAttribute("role_login"); 
	String UID =(String)session.getAttribute("UID_login");
	if(role.equals("3")){
		role = "Administrator";
	}else if(role.equals("2")){
		role = "Manager";
	}else if(role.equals("1")){
		role = "User";
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">

<script type='javascript'>


</script>
</HEAD>

<Body>
	<p style="font-size:20px">Welcome!&nbsp;<%=lastName%>,<%=firstName%>&nbsp;(<%=role%>)
	&nbsp;<a href="modifySelf.jsp" target="main">Update Personal Information</a></p>
	<a href="../logout.jsp" target="_top">Logout</a>
	<br>
		<input type='button' class='css_button' value='Logout' 
		onclick="self.parent.location='../logout.jsp'>
	
</body>
</HTML>