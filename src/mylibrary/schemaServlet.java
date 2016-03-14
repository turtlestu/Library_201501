package mylibrary;
import java.io.IOException;  
import java.io.PrintWriter;
import javax.servlet.http.*;
import java.util.*;


public class schemaServlet extends HttpServlet {
	String result = "";
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException{
				request.setCharacterEncoding("UTF-8");
				HttpSession session = request.getSession(); 
				String type = request.getParameter("type");
				String SchName = "";
				schemaDAO s = new schemaDAO();
				if(type.equals("add")){
					SchName = (String)request.getParameter("SchName");
					try{
						//System.out.println("addSchema");
						//讀取值
						s.addSchema(SchName);	
						response.sendRedirect("addSchemaResult.jsp");
					}catch(Exception e){
						System.out.println("schemaServlet type=add failed");
						e.printStackTrace();
					}
				}else if(type.equals("search")){//search all schema
					Map<String,String>bookSchema = new HashMap<String,String>();
					try{
						bookSchema = s.getBookSchema();
						session.setAttribute("bookSchema", bookSchema);
						response.sendRedirect("searchSchema.jsp");
						}
					catch(Exception e){
						System.out.println("schemaServlet type=search failed");
						e.printStackTrace();
					}
				}else if(type.equals("modify")){
					String SID = (String)request.getParameter("SID");
					SchName = (String)request.getParameter("SchName");
					try{
						System.out.println("SID:" + SID);
						System.out.println("modifySchema");
						s.modifySchema(SID, SchName);
						response.sendRedirect("modifySchemaResult.jsp");
					}catch(Exception e){
						System.out.println("userServlet type=modify failed");
						e.printStackTrace();
					}	
				}else if(type.equals("delete")){
					String[] checkSch = request.getParameter("checkSch").split(",");
					String SID = checkSch[0];							
					try{
						s.deleteSchema(SID);	
						response.sendRedirect("deleteSchemaResult.jsp");
					}catch(Exception e){
						System.out.println("schemaServlet type=delete failed");
						e.printStackTrace();
					}
				}//end if
	}
}
