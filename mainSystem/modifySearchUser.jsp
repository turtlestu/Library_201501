<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">
<script src="../script/jquery-2.1.1.js"></script>
<script type="text/javascript">
	function goBack(){
			self.location.href='searchUser.jsp';
	}		
	function check1(){
	var select = $('#dataType').val();
		var textValue = $('#value').val();

		if (select == 'Role' & textValue != ''){
			if(textValue == '1' || textValue == '2' || textValue=='3'){
				$('#formSearch').submit();
			}else{
				alert('please type Role in 1:User 2:Manager 3:Administarotr');
			}
		}else{
			$('#formSearch').submit();
		}
	}
	
</script>

</HEAD>
<body>
<br>
<div id="searchUser" align="center">
<div id="condition">
<p class="title">Find a user to update</p>
<form id='formSearch' action='user?type=search&function=modify' method='POST'>
<table ALIGN='center' >
<tr>
<td width='40%'>
<label>
<select id = 'dataType' name='dataType' id='dataType' style="width:140px;">
<option value='UID'>UID</option>
<option value='Account'>Username</option>
<option value='Role'>Role</option>
<option value='LastName'>LastName</option>
<option value='FirstName'>FirstName</option>
</select>
</label>
</td>
<td><p class='content'>
<input type='text' name="value" class='textbox'>
</p></td>
</tr>
</table>
<p><input type='button' class='css_button' value='Find' onclick="check1()">&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Cancel" onclick="goBack()"></p>
</form>
</div>
<!------------------------------------------->
	<div id="result"> 
<%
	ArrayList<ArrayList<String>> userList = new ArrayList<ArrayList<String>>();
	ArrayList<String> user = new ArrayList<String>();
	userList = (ArrayList)session.getAttribute("userList");	
	int index = 0;
	String UID;
	if(userList!=null){
		Iterator userIt = userList.iterator();	
		out.print("<table border='1' class='tftable' style='width:80%'>");
		out.print("<tr>");	
		out.print("<th>UID</th>");	
		out.print("<th>Username</th>");
		out.print("<th>Role</th>");	
		out.print("<th>LastName</th>");	
		out.print("<th>FirstName</th>");	
		out.print("<th>Detail</th>");
		out.print("</tr>");
		while(userIt.hasNext()){
			out.print("<form action='user?type=detail&function=modify' method='POST'>");
			out.print("<tr>");
			user = (ArrayList<String>)userIt.next(); //one user									
			Iterator uit = user.iterator();						
			UID = (String)uit.next();
			out.print("<input type='hidden' name='UID' value="+UID+">");
			out.print("<td>");
			out.print(UID);
			out.print("</td>");	
			out.print("<td>");
			out.print(uit.next()); //username
			out.print("</td>");	
			out.print("<td>");
						String role=(String)uit.next();
			if(role.equals("3")){
		role = "Administrator";
	}else if(role.equals("2")){
		role = "Manager";
	}else if(role.equals("1")){
		role = "User";
	}
			out.print(role); //role
			
			//out.print(uit.next()); //role
			
			
			out.print("</td>");	
			out.print("<td>");
			out.print(uit.next()); //Lastname
			out.print("</td>");	
			out.print("<td>");
			out.print(uit.next()); //firstname
			out.print("</td>");	
			out.print("<td>");
			out.print("<input type='submit' value='Detail' class='css_button'>");
			out.print("</td>");	
			out.print("</tr>");
			out.print("</form>");
		}
		out.print("</table>");	
	}
	session.setAttribute("userList",null);
%>
	</div>
</div>
</body>
</HTML>