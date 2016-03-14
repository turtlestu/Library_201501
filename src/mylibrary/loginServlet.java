package mylibrary;
import java.io.IOException;   
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.*;

public class loginServlet extends HttpServlet {
	String userData[];
	String result = "";
	String username="";
	String password="";
	String role="";
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException{
			request.setCharacterEncoding("UTF-8");		
			System.out.println("loginServlet-login");
				username=request.getParameter("username");
				password=request.getParameter("password");
				HttpSession session = request.getSession();
				loginDAO login = new loginDAO();
				try {
					userData = login.loginResult(username, password);
					//if(userData!=null){
					if(userData[0]!=null && userData[1]!=null && userData[2]!=null){
						System.out.println("FirstName:"+userData[0]); //firstName
						System.out.println("LastName:"+userData[1]); //lastName
						System.out.println("role:"+userData[2]); //role 3:admin 2:manager 1:user
						System.out.println("UID:"+userData[3]);
						session.setAttribute("username_login", username);
						session.setAttribute("password_login", password);
						session.setAttribute("firstName_login", userData[0]);
						session.setAttribute("lastName_login", userData[1]);
						session.setAttribute("role_login", userData[2]);
						session.setAttribute("UID_login", userData[3]);
						session.setAttribute("email_login", userData[4]);
						session.setAttribute("telephone_login", userData[5]);
						response.sendRedirect("mainSystem/welcome.jsp");
					}else{
						System.out.println("userServlet login failed!!");
						throw new Exception();
					}				
				}catch (Exception e) {
					//login failed
					session.invalidate();
					response.sendRedirect("login-failed.jsp");
					e.printStackTrace();
					System.out.println("e.getMessage():"+e.getMessage());
					//e.printStackTrace();
				}
			}
}
