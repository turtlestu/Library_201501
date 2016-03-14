<%@ page import="java.util.*,mylibrary.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	bookDAO b = new bookDAO();
	Map<String,String> bookSchema = new HashMap<String,String>();
	bookSchema = b.getBookSchema();
	Collection<String> schema = bookSchema.values();
	Set<String> keySet = bookSchema.keySet();
	Iterator it = schema.iterator();
	Iterator kit = keySet.iterator();
%>	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<HTML>
<HEAD>
<TITLE>Library management system</TITLE>
<link rel="stylesheet" href="../css/style.css">
<script src="../script/jquery-2.1.1.js"></script>
<script type="text/javascript">
	function goBack(){
			self.location.href='searchBook.jsp';
	}		
</script>
</HEAD>
<body>
<br>
<div id="searchBook" align="center">
<div id="condition">
<p class="title">Find a book to update</p>
<form action='book?type=search&function=modify' method='POST'>
<table ALIGN='center' >
<tr>
<td width='32%'>
<label>
<select name='schema'>
<%
String sch = "";
String key = "";
while(it.hasNext()){
	sch=(String)it.next();
	key = (String)kit.next();
	out.print("<option value='"+key+"'>"+sch+"</option>");	
	}
%>
</select></label></td>
<td><p class='content'>
<input type='text' name="value" class='textbox'>
</p></td>
</tr>
</table>
<p><input type='submit' class='css_button' value='Find'>&nbsp;&nbsp;&nbsp;
<input type="button" class='css_button' value="Cancel" onclick="goBack()"></p>
</form>
</div>
<!------------------------------------------->
	<div id="result"> 
<%
	ArrayList<ArrayList<String>> bookList = new ArrayList<ArrayList<String>>();
	ArrayList<String> book = new ArrayList<String>();
	bookList = (ArrayList)session.getAttribute("bookList");	
	int index = 0;
	String BID;
	if(bookList!=null){
		Iterator bookIt = bookList.iterator();	
		out.print("<table border='1' class='tftable' style='width:80%'>");
		out.print("<tr>");	
		out.print("<th>Title</th>");	
		out.print("<th>Author</th>");
		out.print("<th>Publisher</th>");	
		out.print("<th>Detail</th>");
		out.print("</tr>");
		while(bookIt.hasNext()){
		out.print("<form action='book?type=detail&function=modify' method='POST' >");
			out.print("<tr>");
			book = (ArrayList<String>)bookIt.next(); //one book									
			Iterator bit = book.iterator();						
			BID = (String)bit.next();
			out.print("<input type='hidden' name='BID' value="+BID+">");
			out.print("<td>");
			out.print(bit.next());
			out.print("</td>");	
			out.print("<td>");
			out.print(bit.next());
			out.print("</td>");	
			out.print("<td>");
			out.print(bit.next());
			out.print("</td>");	
			out.print("<td>");
			out.print("<input type='submit' value='Detail' class='css_button'>");
			out.print("</td>");	
			out.print("</tr>");
			out.print("</form>");
		}
		out.print("</table>");	
	}
	session.setAttribute("bookList",null);
%>
	</div>
</div>
</body>
</HTML>