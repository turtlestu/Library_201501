<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<% String role = (String)session.getAttribute("role_login"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">
<style type="text/css">
</style>
</HEAD>
<body>
<div id="menu" align="center">
<table class='tftable' border = '1' style="width:190px;">
<tr><th style="font-size:18px">Book Management</th></tr>
<tr><td><a href='searchBook.jsp' target="main">Search for book</a></td></tr>
<tr><td><a href='addBook.jsp' target="main">Add a book</a></td></tr>
<tr><td><a href='modifySearchBook.jsp' target="main">Update book</a></td></tr>
<tr><td><a href='deleteSearchBook.jsp' target="main">Delete book</a></td></tr>
</table>
<%
	if(role.equals("2") | role.equals("3")){
%>
<table class='tftable' style="width:190px;">
<tr><th style="font-size:18px">Schema Management</th></tr>
<tr><td><a href='searchSchema.jsp' target="main">Search/Update/Delete Schema</a></td></tr>
<tr><td><a href='addSchema.jsp' target="main">Add schema</a></td></tr>
</table>
<% 
	}
	if(role.equals("3")){
%>
<table class='tftable' style="width:190px;">
<tr><th style="font-size:18px">User Management</th></tr>
<tr><td><a href='searchUser.jsp' target="main">Search for user</a></td></tr>
<tr><td><a href='addUser.jsp' target="main">Add user</a></td></tr>
<tr><td><a href='modifySearchUser.jsp' target="main">Update user</a></td></tr>
<tr><td><a href='deleteSearchUser.jsp' target="main">Delete user</a></td></tr>

<% 
	}
%>

</div>
</body>
</HTML>