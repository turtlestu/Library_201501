<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">
<style> 

</style> 
<script type="text/javascript">
	function backtomain(){
		var answer = confirm("Are you sure to cancel?")
			if (answer){
					self.location.href='searchUser.jsp';
			}		
	}
</script>

</HEAD>
<body>
<div id="addBook" align="center">
<p class="title">Add a User information</p>
<form action='addUserCheck.jsp' method='post'>
<table>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;Username:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='text' name='username' class='textbox'></p>
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;Password:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='text' name='password' class='textbox'></p>
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
		<option value='3'>Administrator</option>
		<option value='2'>Manager</option>
		<option value='1' selected>User</option>
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
	<p class='content'><input type='text' name='email' class='textbox'></p>
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;Last Name:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='text' name='lastName' class='textbox'></p>
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;First Name:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='text' name='firstName' class='textbox'></p>
	</td>
</tr>
<tr>
	<td align='right'>
	<p class='content'>
	&nbsp;Telephone:&nbsp;&nbsp;
	</p>
	</td>
	<td>
	<p class='content'><input type='text' name='telephone' class='textbox'></p>
	</td>
</tr>

</table>
<p>
<input type='submit' class='css_button' value='Register'>&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Cancel" onClick="backtomain()">
</p>
</form>
</div>

</body>
</HTML>