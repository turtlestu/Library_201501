<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
String UID = (String)session.getAttribute("UID_login");
String username = (String)session.getAttribute("username_login");
String password = (String)session.getAttribute("password_login");
String role = (String)session.getAttribute("role_login");
String email = (String)session.getAttribute("email_login");
String lastName = (String)session.getAttribute("lastName_login");
String firstName = (String)session.getAttribute("firstName_login");
String telephone = (String)session.getAttribute("telephone_login");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript">
	function backtomain(){
		self.location.href='searchBook.jsp';
		//history.go(-2);
		
	}
</script>
</HEAD>
<body>
modifySelf.jsp
<div id="modifyUser" align="center">
<p class="title">Update personal information</p>
<form action='modifySelfCheck.jsp' method='post'>
<%
out.print("<input type='hidden' name='UID' value='"+UID+"'>");
%>
<table>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;UID:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><%=UID%></p>
	</td>
</tr>

<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;Username:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><%=username%></p>
	<input type='hidden' name='username' class='textbox' value="<%=username%>">
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;Password:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='password' name='password' class='textbox' value="<%=password%>"></p>
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;Role:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'>
	<label style="font:20px;">
	<select name='role' Style="font-size:18px; width:240px">
<%
	if(role.equals("3")){
		out.print("<option value='3' selected>Administrator</option>");
	}else if(role.equals("2")){
		out.print("<option value='2' selected>Manager</option>");
	}else if(role.equals("1")){
		out.print("<option value='1' selected>User</option>");
	}
%>
	</select>
	</label>
	</p>
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;E-mail:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='text' name='email' class='textbox' value="<%=email%>"></p>
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;Last Name:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='text' name='lastName' class='textbox' value="<%=lastName%>"></p>
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;First Name:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='text' name='firstName' class='textbox' value="<%=firstName%>"></p>
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;Telephone:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='text' name='telephone' class='textbox' value="<%=telephone%>"></p>
	</td>
</tr>
</table>
<p>
<input type='submit' class='css_button' value='Update'>&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Cancel" onClick="backtomain()">
</p>
</form>
</div>
</body>
</HTML>