<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");
String role = request.getParameter("role");
String email = request.getParameter("email");
String lastName = request.getParameter("lastName");
String firstName = request.getParameter("firstName");
String telephone = request.getParameter("telephone");
String roleName = "";
if(role.equals("3")){
		roleName = "Administrator";
	}else if(role.equals("2")){
		roleName = "Manager";
	}else if(role.equals("1")){
		roleName = "User";
	}

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>

<SCRIPT TYPE='text/javascript'>
function backtoadd(){
		history.go(-1);
	}
</SCRIPT>
<link rel="stylesheet" href="../css/style.css">
</HEAD>
<BODY>
<div align='center'>
<p class="title">Add a User information</p><br>
<form action='user?type=add' method='post'>
<table class="tftable" border='1' >
<tr><th width='40%'>Data Type</th><th>Information</th></tr>
<tr>
<td><font size='4'>&nbsp;Username&nbsp;&nbsp;</font></td>
<td><%=username%></td>
<input type='hidden' name="username" value=<%=username%>>
</tr>
<tr>
<td><font size='4'>&nbsp;Password&nbsp;&nbsp;</font></td>
<td><%=password%></td>
<input type='hidden' name="password" value=<%=password%>>
</tr>
<tr>
<td><font size='4'>&nbsp;Role&nbsp;&nbsp;</font></td>
<td><%=roleName%></td>
<input type='hidden' name="role" value=<%=role%>>
</tr>
<tr>
<tr>
<td><font size='4'>&nbsp;E-mail&nbsp;&nbsp;</font></td>
<td><%=email%></td>
<input type='hidden' name="email" value=<%=email%>>
</tr>
<tr>
<td><font size='4'>&nbsp;Last Name&nbsp;&nbsp;</font></td>
<td><%=lastName%></td>
<input type='hidden' name="lastName" value=<%=lastName%>>
</tr>
<tr>
<td><font size='4'>&nbsp; First Name&nbsp;&nbsp;</font></td>
<td><%=firstName%></td>
<input type='hidden' name="firstName" value=<%=firstName%>>
</tr>
<tr>
<td><font size='4'>&nbsp; Telephone&nbsp;&nbsp;</font></td>
<td><%=telephone%></td>
<input type='hidden' name="telephone" value=<%=telephone%>>
</tr>
</table>

<p>
<input type='submit' class='css_button' value='Confirm and add'>&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Revise" onclick="backtoadd()">
</p>
</form>
</div>
</BODY>
</HTML>