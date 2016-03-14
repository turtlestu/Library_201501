<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	String BID = request.getParameter("BID");
	ArrayList<String> bookDetail = new ArrayList<String>();
	bookDetail = (ArrayList<String>)session.getAttribute("bookDetail");
	bookDAO b = new bookDAO();
	Map<String,String> bookSchema = new HashMap<String,String>();
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
<script type="text/javascript">
	function backtomain(){
		history.go(-2);
		
	}
</script>
</HEAD>
<body>
<div id="modifyBook" align="center">
<p class="title">Update a book information</p>
<form action='modifyBookCheck.jsp' method='post'>
<%
out.print("<input type='hidden' name='BID' value='"+BID+"'>");
%>
<table>
<%
int valueIndex = 0;
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
	out.print("<p class='content'><input type='text' name="+sch+" class='textbox' value="+bookDetail.get(valueIndex)+"></p>");
	out.print("</td>");
out.print("</td>");
valueIndex ++;
	}%>

</table>
<p>
<input type='submit' class='css_button' value='Update'>&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Cancel" onClick="backtomain()">
</p>
</form>
</div>
</body>
</HTML>