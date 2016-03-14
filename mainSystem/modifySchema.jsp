<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	String checkSch[] = request.getParameter("checkSch").split(",");
	String SID = checkSch[0];
	String SchName = checkSch[1];
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">

<script src="../script/jquery-2.1.1.js" type="text/javascript"></script>
<script type="text/javascript">
	function backtomain(){
		history.go(-1);
	}
	function confirmUpdate(){
		var answer = confirm("Update the schema?")
			if (answer){
					$('#form1').submit();
			};
	}
	
	
</script>
</HEAD>
<body>
<div id="modifySchema" align="center">
<p class="title">Update a schema information</p>
<form id = "form1" action='schema?type=modify' method='post'>
<input type='hidden' name="SID" value="<%=SID%>">
<table>
<tr>
	<td align='right'><p class='content'>&nbsp;SID:&nbsp;&nbsp;</p>
	</td>
	<td><p class='content'><%=SID%></p>
	</td>
</tr>
<tr>
	<td align='right'><p class='content'>&nbsp;Schema Name:&nbsp;&nbsp;</p>
	</td>
	<td><p class='content'>
	<input type='text' name="SchName" class='textbox' value="<%=SchName%>"></p>
	</td>
</tr>
</table>
<p>
<input type='button' class='css_button' value='Update' onClick="confirmUpdate()">&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Cancel" onClick="backtomain()">
</p>
</form>
</div>
</body>
</HTML>