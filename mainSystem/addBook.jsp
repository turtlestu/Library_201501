<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%
	Map<String,String> bookSchema = new HashMap<String,String>();
	bookDAO b = new bookDAO();
	bookSchema = b.getBookSchema();
	Collection<String> schema = bookSchema.values();
	Iterator it = schema.iterator();
	

%>
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
					self.location.href='main.jsp';
			}		
	}
</script>

</HEAD>
<body>
<div id="addBook" align="center">
<p class="title">Add a book information</p>
<form action='addBookCheck.jsp' method='post'>
<table>
<%
String sch = "";
while(it.hasNext()){
sch=(String)it.next();
out.print("<tr>");
	out.print("<td align='right'>");
	out.print("<p class='content'>");
	out.print("&nbsp;"+sch+":&nbsp;&nbsp;");
	out.print("</p>");
	out.print("</td>");
	out.print("<td>");
	out.print("<p class='content'><input type='text' name="+sch+" class='textbox'></p>");
	out.print("</td>");
out.print("</tr>");
	}%>

</table>
<p>
<input type='submit' class='css_button' value='Register'>&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Cancel" onClick="backtomain()">
</p>
</form>
<!--<button id="canBtn" onClick="backtomain()">Cancel</button> button放表單外才有作用<br>-->
</div>

</body>
</HTML>