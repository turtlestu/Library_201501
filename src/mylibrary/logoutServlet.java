package mylibrary;
import java.io.IOException;   
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.*;

public class logoutServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException{
			request.setCharacterEncoding("UTF-8");		
			System.out.println("logoutServlet-logout");
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect("../logout.jsp");
	}
}
