<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%
	Map<String,String> bookSchema = new HashMap<String,String>();
	bookDAO b = new bookDAO();
	bookSchema = b.getBookSchema();
	Collection<String> schema = bookSchema.values();
	Set<String> keySet = bookSchema.keySet();
	Iterator it = schema.iterator();
	Iterator SIDit = keySet.iterator();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">

<script src="../script/jquery-2.1.1.js" type="text/javascript"></script>
<script type="text/javascript">
	function deleteSchema(){
		var answer = confirm("Delete the schema?")
			if (answer){
					$('#form1').attr('action','schema?type=delete');
					$('#form1').submit();
			}		
	}
	
	function updateSchema(){
		$('#form1').attr('action','modifySchema.jsp');
		$('#form1').submit();
	}
	
	
</script>
</HEAD>
<body>
<div id="schemaList" align="center">
<p class="title">Schema List</p>
<form id ="form1" action='' method='post'>
<table class= 'tftable'>
<tr>
<th></th>
<th>SID</th>
<th>Schema Name</th>
</tr>
<%
String sch = "";
String SID = "";
while(it.hasNext()){
SID=(String)SIDit.next();
sch=(String)it.next();
out.print("<tr>");
	if(SID.equals("S01")){
		out.print("<td><input type='radio' name='checkSch' value='"+SID+","+sch+"' checked></td>");
	}else{
		out.print("<td><input type='radio' name='checkSch' value='"+SID+","+sch+"'></td>");
	}
	out.print("<td>");
	out.print("&nbsp;"+SID+"&nbsp;&nbsp;");
	out.print("</td>");
	out.print("<td>");
	out.print(sch);
	out.print("</td>");
	out.print("</tr>");
	}%>
</table>
<p>
<input type="button" class='css_button' value="Update" onClick="updateSchema()">&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Delete" onClick="deleteSchema()">&nbsp;&nbsp;&nbsp;
</p>
</form>
</div>
</body>
</HTML>