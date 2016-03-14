package mylibrary;
//build database connection
import java.sql.*;

public class loginDAO {
	private String[] userData = new String[6];
	Connection conn;
	PreparedStatement pstmt;
	//Statement pstmt;
	ResultSet rs;
	String sql;
	public loginDAO(){
					
	}
	
	public String[] loginResult(String username ,String password) throws Exception{
		openDB(username,password);
		return userData;
	}
	public void openDB(String username ,String password) throws SQLException{
		try
        {
			//System.out.println("openDB username:"+username);
			//System.out.println("openDB password:"+password);
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");		
			String connectionUrl = "jdbc:sqlserver://localhost:1433;databaseName=library;";
			conn = DriverManager.getConnection(connectionUrl,"sa","henry8290");
			//sql="select Lastname,FirstName,Role,Account,Password from L_user where Account = '"+username+"' and Password = '"+password+"'";
			//pstmt=conn.createStatement();
								sql="select Lastname,FirstName,Role,UID,Email,Telephone,Account,Password from L_user" +
										" where Account = ? and Password = ?";
								pstmt = conn.prepareStatement(sql);
								pstmt.setString(1,username);
								pstmt.setString(2,password);
								rs = pstmt.executeQuery();
				if(rs.next()){		
					System.out.println("login success!!");
					//userData大小為6
					userData[0]=rs.getString("LastName") !=null ? rs.getString("LastName") :"" ;//lastName
					userData[1]=rs.getString("FirstName") !=null ? rs.getString("FirstName") :"" ;//firstname
					userData[2]=rs.getString("Role") !=null ? rs.getString("Role") :"" ;//role
					userData[3]=rs.getString("UID") !=null ? rs.getString("UID") :"" ;//UID	                
	                userData[4]=rs.getString("Email") !=null ? rs.getString("Email") :"" ;//Email       
	                userData[5]=rs.getString("Telephone") != null ? rs.getString("Telephone") : "" ;//Telephone 
				}
				
		} //end try
		catch (Exception e)
        {	
			System.out.println("loginDAO login failed");
			e.printStackTrace();
			System.out.println(e.getMessage());
			userData=null;
        }
		finally{
			rs=null;
			pstmt.close();
			conn.close();
		}
	}
}
