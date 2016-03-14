package mylibrary;
import java.io.IOException;  
import java.io.PrintWriter;
import javax.servlet.http.*;
import java.util.*;


public class userServlet extends HttpServlet {
	String result = "";
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException{
				request.setCharacterEncoding("UTF-8");
				HttpSession session = request.getSession(); 
				String type = request.getParameter("type");
				String userValue[] = new String[7];
				userDAO u = new userDAO();
				if(type.equals("add")){
					String username = (String)request.getParameter("username");
					String password = (String)request.getParameter("password");
					String role = (String)request.getParameter("role");
					String email = (String)request.getParameter("email");
					String lastName = (String)request.getParameter("lastName");
					String firstName = (String)request.getParameter("firstName");
					String telephone = (String)request.getParameter("telephone");
					try{
						System.out.println("addUser");
						//讀取值
						userValue[0] = username;
						userValue[1] = password;
						userValue[2] = role;
						userValue[3] = email;
						userValue[4] = lastName;
						userValue[5] = firstName;
						userValue[6] = telephone;
						u.addUser(userValue);	
						response.sendRedirect("addUserResult.jsp");
					}catch(Exception e){
						System.out.println("userServlet type=add failed");
						e.printStackTrace();
					}
				}else if(type.equals("search")){//search a book
					try{
						ArrayList<ArrayList<String>> userList = new ArrayList<ArrayList<String>>();
						String dataType = request.getParameter("dataType"); //SID
						String value = request.getParameter("value");	

						userList=u.searchUser(dataType, value);												
						session.setAttribute("userList", userList);
						String function = 
								request.getParameter("function")!=null 
								? request.getParameter("function") 
								: "none" ;
						if(function.equals("modify")){
							response.sendRedirect("modifySearchUser.jsp");
						}else if(function.equals("delete")){
							response.sendRedirect("deleteSearchUser.jsp");
						}else{
							response.sendRedirect("searchUser.jsp");
						}
					}catch(Exception e){
						System.out.println("bookServlet type=search failed");
						e.printStackTrace();
					}
				}else if(type.equals("detail")){
					ArrayList<String> userDetail = new ArrayList<String>();
					String UID = request.getParameter("UID");
					userDetail = u.getUserDetail(UID);
					session.setAttribute("userDetail", userDetail);
					session.setAttribute("UID", UID);
					
					String function = request.getParameter("function")!=null 
							? request.getParameter("function") 
							: "none" ;
					if(function.equals("modify")){
						response.sendRedirect("modifyUserDetail.jsp?UID="+UID);
					}else if(function.equals("delete")){
						response.sendRedirect("deleteUserDetail.jsp?UID="+UID);
					}else{
						response.sendRedirect("searchUserDetail.jsp?UID="+UID);
					}
				}else if(type.equals("modify")){ 
					boolean result = true;
					String username = (String)request.getParameter("username");
					String password = (String)request.getParameter("password");
					String role = (String)request.getParameter("role");
					String email = (String)request.getParameter("email");
					String lastName = (String)request.getParameter("lastName");
					String firstName = (String)request.getParameter("firstName");
					String telephone = (String)request.getParameter("telephone");
					String UID = (String)request.getParameter("UID");							
					try{
						System.out.println("UID:" + UID);
						System.out.println("modifyUser");
						//讀取值
						userValue[0] = username;
						userValue[1] = password;
						userValue[2] = role;
						userValue[3] = email;
						userValue[4] = lastName;
						userValue[5] = firstName;
						userValue[6] = telephone;
						u.modifyUser(userValue, UID);
				
						//session 更新
						session.setAttribute("password", userValue[1]);
						session.setAttribute("role", userValue[2]);
						session.setAttribute("email", userValue[3]);
						session.setAttribute("lastName", userValue[4]);
						session.setAttribute("firstName", userValue[5]);
						session.setAttribute("telephone", userValue[6]);
						response.sendRedirect("modifyUserResult.jsp");
						
					}catch(Exception e){
						System.out.println("userServlet type=modify failed");
						e.printStackTrace();
					}	
				}else if(type.equals("modifySelf")){
					//複製modify部分 為了好Debug
				
					String username = (String)request.getParameter("username");
					String password = (String)request.getParameter("password");
					String role = (String)request.getParameter("role");
					String email = (String)request.getParameter("email");
					String lastName = (String)request.getParameter("lastName");
					String firstName = (String)request.getParameter("firstName");
					String telephone = (String)request.getParameter("telephone");
					String UID = (String)request.getParameter("UID");							
					try{
						System.out.println("UID:" + UID);
						System.out.println("modifySelf");
						//讀取值
						userValue[0] = username;
						userValue[1] = password;
						userValue[2] = role;
						userValue[3] = email;
						userValue[4] = lastName;
						userValue[5] = firstName;
						userValue[6] = telephone;
						u.modifyUser(userValue, UID);
					
						//session 更新
						session.setAttribute("password", userValue[1]);
						session.setAttribute("role", userValue[2]);
						session.setAttribute("email", userValue[3]);
						session.setAttribute("lastName", userValue[4]);
						session.setAttribute("firstName", userValue[5]);
						session.setAttribute("telephone", userValue[6]);
						response.sendRedirect("modifySelfResult.jsp");
						
					}catch(Exception e){
						System.out.println("userServlet type=modifySelf failed");
						e.printStackTrace();	
					}	
				}else if(type.equals("delete")){
					String role = request.getParameter("role");
					String UID = request.getParameter("UID");							
					try{
						u.deleteUser(UID,role);	
						response.sendRedirect("deleteUserResult.jsp");
					}catch(Exception e){
						System.out.println("userServlet type=delete failed");
						e.printStackTrace();
					}
				}//end if
	}
}
