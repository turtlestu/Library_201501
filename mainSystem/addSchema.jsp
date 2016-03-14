<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">

<script src="../script/jquery-2.1.1.js" type="text/javascript"></script>
<script type="text/javascript">
	function backtomain(){
		var answer = confirm("Are you sure to cancel?")
			if (answer){
					self.location.href='searchSchema.jsp';
			}		
	}
	function confirmSubmit(){
		var answer = confirm("Submit the data?")
			if (answer){
				$('#form1').submit();
			}		
	}
	
</script>
</HEAD>
<body>
<div id="addBook" align="center">
<p class="title">Add a new schema</p>
<form id="form1" action='schema?type=add' method='post'>
<table>
<tr>
	<td align='right'>
	<p class='content'>&nbsp;Schema Name:&nbsp;&nbsp;</p>
	</td>
	<td><p class='content'><input type='text' name='SchName' class='textbox'></p></td>
</tr>
</table>
<p>
<input type='button' class='css_button' value='Register' onClick="confirmSubmit()">&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Cancel" onClick="backtomain()">
</p>
</form>
</div>
</body>
</HTML>