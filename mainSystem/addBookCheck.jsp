﻿<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%
	Map<String,String> bookSchema = new HashMap<String,String>();
	bookDAO b ;
	Collection<String> schema;
	Iterator it;
	b = new bookDAO();
	bookSchema = b.getBookSchema();
	schema = bookSchema.values();
	it = schema.iterator();
	
	//get <input name="sch"> 
	int valueIndex = 0;
	String bookValue[] = new String[15];
	while(it.hasNext()){
	
		bookValue[valueIndex] = new String(request.getParameter((String)it.next()).getBytes("ISO-8859-1"),"UTF-8"); //getParameter("name")
		valueIndex++;
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
<style type="text/css">

</style>
</HEAD>
<BODY>

<div align='center'>
<p class="title">Add a book information</p><br>
<form action='book?type=add' method='post'>
<table class="tftable" border='1' >
<tr>
<th width='40%'>Schema</th>
<th>Content</th>
</tr>
<%
valueIndex = 0;
it = schema.iterator();
String sch = "";
while(it.hasNext() && valueIndex < bookValue.length){
sch=(String)it.next();
out.print("<tr>");
	out.print("<td>");
	out.print("<font size='4'>");
	out.print("&nbsp;"+sch+"&nbsp;&nbsp;");
	out.print("</font>");
	out.print("</td>");
	out.print("<td>");
	out.print(bookValue[valueIndex]);
	out.print("<input type='hidden' name="+sch+" value='"+bookValue[valueIndex]+"'>");
	out.print("</td>");
out.print("</td>");
	valueIndex++;
	}%>

</table>

<p>
<input type='submit' class='css_button' value='Confirm and add'>&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Revise" onclick="backtoadd()">
</p>
</form>
</div>
</BODY>
</HTML>