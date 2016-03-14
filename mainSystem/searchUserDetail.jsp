<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	String UID = request.getParameter("UID");
	
	int valueIndex = 0;
	ArrayList<String> userDetail = new ArrayList<String>();
	userDetail = (ArrayList<String>)session.getAttribute("userDetail");
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<script src="../script/jquery-2.1.1.js" type="text/javascript"></script>

<link rel="stylesheet" href="../css/style.css">
</HEAD>
<BODY>
<div align='center'>
<p class="title">User detail information</p><br>
<form id='form1' action='modifyUser.jsp' method='post'>
<%
out.print("<input type='hidden' id='UID' name='UID' value='"+UID+"'>");
%>
<table class="tftable" border='1' >
<tr>
<th width='40%'>Data Type</th>
<th>Information</th>
</tr>
<tr>
	<td><font size='4'>UID</font></td>
	<td><%=userDetail.get(0)%></td>
</tr>
<tr>
	<td><font size='4'>Username</font></td>
	<td><%=userDetail.get(1)%></td>
	<input type='hidden' name="username" value=<%=userDetail.get(1)%>>
</tr>
<tr>
	<td><font size='4'>Password</font></td>
	<td>********</td>
	<input type='hidden' name="password" value=<%=userDetail.get(2)%>>
</tr>
<tr>
<%
String roleName = "";
if(userDetail.get(3).equals("3")){
		roleName = "Administrator";
	}else if(userDetail.get(3).equals("2")){
		roleName = "Manager";
	}else if(userDetail.get(3).equals("1")){
		roleName = "User";
	}
%>	
	<td><font size='4'>Role</font></td>
	<td><%=roleName%></td>
	<input type='hidden' name="role" value=<%=userDetail.get(3)%>>
</tr>
<tr>
	<td><font size='4'>Email</font></td>
	<td><%=userDetail.get(4)%></td>
	<input type='hidden' name="email" value=<%=userDetail.get(4)%>>
</tr>
<tr>
	<td><font size='4'>Last Name</font></td>
	<td><%=userDetail.get(5)%></td>
	<input type='hidden' name="lastName" value=<%=userDetail.get(5)%>>
</tr>
<tr>
	<td><font size='4'>First Name</font></td>
	<td><%=userDetail.get(6)%></td>
	<input type='hidden' name="firstName" value=<%=userDetail.get(6)%>>
</tr>
<tr>
	<td><font size='4'>Telephone</font></td>
	<td><%=userDetail.get(7)%></td>
	<input type='hidden' name="telephone" value=<%=userDetail.get(7)%>>
</tr>
</table>
<p>
<input type="submit" class='css_button' value="Update">&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Delete" onClick="delete1()">&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Back to search" onClick="backtosearch1()">


</p>
</form>
</div>
</BODY>
<script type='text/javascript'>	
function backtosearch1(){
		history.go(-1);
	}
function delete1(){
		var answer = confirm("Are you sure to delete the user?")
		if (answer){
			$('#form1').attr('action','user?type=delete');
			$('#form1').submit();
		}
		//alert($('#form1').action);
		
	}		
</script>
</HTML>