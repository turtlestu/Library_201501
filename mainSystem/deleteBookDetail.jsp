﻿<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	String BID = request.getParameter("BID");
	Map<String,String> bookSchema = new HashMap<String,String>();
	Collection<String> schema;
	bookDAO b  = new bookDAO();
	bookSchema = b.getBookSchema();
	schema = bookSchema.values();
	Iterator it = schema.iterator();
	//get <input name="sch"> 
	int valueIndex = 0;
	ArrayList<String> bookDetail = new ArrayList<String>();
	bookDetail = (ArrayList<String>)session.getAttribute("bookDetail");
	
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
<p class="title">Book detail information</p><br>
<form id='form1' action='book?type=delete' method='post'>
<%
out.print("<input type='hidden' id='BID' name='BID' value='"+BID+"'>");
%>
<table class="tftable" border='1' >
<tr>
<th width='40%'>Schema</th>
<th>Content</th>
</tr>
<%
valueIndex = 0;
it = schema.iterator();
String sch = "";
while(it.hasNext() && valueIndex < bookDetail.size()){
sch=(String)it.next();
out.print("<tr>");
	out.print("<td>");
	out.print("<font size='4'>");
	out.print("&nbsp;"+sch+"&nbsp;&nbsp;");
	out.print("</font>");
	out.print("</td>");
	out.print("<td>");
	out.print(bookDetail.get(valueIndex));
	out.print("</td>");
out.print("</td>");
	valueIndex++;
	}%>
</table>
<p>
<input type="button" class='css_button' value="Delete" onclick="delete1()">&nbsp;&nbsp;&nbsp;
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
		var answer = confirm("Are you sure to delete the book?")
		if (answer){
			$('#form1').attr('action','book?type=delete');
			$('#form1').submit();
		}
	}	
</script>
</HTML>