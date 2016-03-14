package mylibrary;
import java.io.IOException;  
import java.io.PrintWriter;
import javax.servlet.http.*;
import java.util.*;


public class bookServlet extends HttpServlet {
	String result = "";
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException{
				request.setCharacterEncoding("UTF-8");
				HttpSession session = request.getSession(); 
				String type = request.getParameter("type");
				bookDAO b = new bookDAO();
				if(type.equals("add")){
					String bookValue[] = new String[15];
					Map<String,String> bookSchema = new HashMap<String,String>();
					int valueIndex = 0;
					try{
						bookSchema = b.getBookSchema();
						Collection<String> schema = bookSchema.values();
						Iterator it = schema.iterator();
						System.out.println("addBook");
						//讀取值
						while(it.hasNext()){
							String sch=(String)it.next();
							bookValue[valueIndex] = request.getParameter(sch);
							valueIndex++;
						}
						b.addBook(bookValue);	
						response.sendRedirect("addBookResult.jsp");
					}catch(Exception e){
						System.out.println("bookServlet type=add failed");
						e.printStackTrace();
					}
				}else if(type.equals("search")){//search a book
					try{
						ArrayList<ArrayList<String>> bookList = new ArrayList<ArrayList<String>>();
						String schema = request.getParameter("schema"); //SID
						String value = request.getParameter("value");	
						bookList=b.searchBook(schema, value);												
						session.setAttribute("bookList", bookList);
							
						String function = 
								request.getParameter("function")!=null 
								? request.getParameter("function") 
								: "none" ;
						if(function.equals("modify")){
							response.sendRedirect("modifySearchBook.jsp");
						}else if(function.equals("delete")){
							response.sendRedirect("deleteSearchBook.jsp");
						}else{
							response.sendRedirect("searchBook.jsp");
						}
					}catch(Exception e){
						System.out.println("bookServlet type=search failed");
						e.printStackTrace();
					} 
				}else if(type.equals("detail")){
					ArrayList<String> bookDetail = new ArrayList<String>();
					String BID = request.getParameter("BID");				
					bookDetail = b.getBookDetail(BID);
					session.setAttribute("bookDetail", bookDetail);
					session.setAttribute("BID", BID);
System.out.println("bookDetail : " + bookDetail);					
					String function = request.getParameter("function")!=null 
							? request.getParameter("function") 
							: "none" ;
					if(function.equals("modify")){
						response.sendRedirect("modifyBookDetail.jsp?BID="+BID);
					}else if(function.equals("delete")){
						response.sendRedirect("deleteBookDetail.jsp?BID="+BID);
					}else{
						response.sendRedirect("searchBookDetail.jsp?BID="+BID);
					}
					
				}else if(type.equals("modify")){
					String bookValue[] = new String[15];
					Map<String,String> bookSchema = new HashMap<String,String>();
					int valueIndex = 0;
					String BID = (String)request.getParameter("BID");							
					try{
						bookSchema = b.getBookSchema();
						Collection<String> schema = bookSchema.values();
						Iterator it = schema.iterator();
						System.out.println("modifyBook");
						//讀取值 使用input name='SchName'
						while(it.hasNext()){
							String sch=(String)it.next();
							bookValue[valueIndex] = request.getParameter(sch);
							valueIndex++;
						}
						b.modifyBook(bookValue, BID);	
						response.sendRedirect("modifyBookResult.jsp");
					}catch(Exception e){
						System.out.println("bookServlet type=modify failed");
						e.printStackTrace();
					}	
				}else if(type.equals("delete")){
					String BID = (String)request.getParameter("BID");							
					try{
						b.deleteBook(BID);	
						response.sendRedirect("deleteBookResult.jsp");
					}catch(Exception e){
						System.out.println("bookServlet type=delete failed");
						e.printStackTrace();
					}
				}//end if
	}
}
