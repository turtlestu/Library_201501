package mylibrary;
import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.*;

//build database connection
public class userDAO {
	private Map<String,String>bookSchema = new HashMap<String,String>();
	//private String bookSchema[];
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;
	public userDAO(){
		
	}
	public Map<String,String> getBookSchema() throws Exception{
		getSchema();
		return bookSchema;
	}
	public void openDB() throws Exception{
		try
        {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");		
			String connectionUrl = "jdbc:sqlserver://localhost:1433;databaseName=library;"; 
			conn = DriverManager.getConnection(connectionUrl,"sa","turtlestu");
        }
		catch (Exception e)
        {	
			System.out.println(e.getMessage());
			System.out.println("userDAO openDB failed");
        }	
	}//end openDB()

	public void closeDB(){
		try {
			rs=null;
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("bookDAO closeDB failed");
			//e.printStackTrace();
		}
	}//closeDB
	
	public ArrayList<String> getUserDetail(String UID){
		ArrayList<String> userDetail = new ArrayList<String>();
		try {
			
			openDB();
			//設定UID
			sql = "select * from L_user where UID= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, UID);
			rs=pstmt.executeQuery();
			while(rs.next()){
				userDetail.add(rs.getString(1)!=null ?rs.getString(1):"");
				userDetail.add(rs.getString(2)!=null ?rs.getString(2):"" );
				userDetail.add(rs.getString(3)!=null ?rs.getString(3):"" );
				userDetail.add(rs.getString(4)!=null ?rs.getString(4):"" );
				userDetail.add(rs.getString(5)!=null ?rs.getString(5):"" );
				userDetail.add(rs.getString(6)!=null ?rs.getString(6):"" );
				userDetail.add(rs.getString(7)!=null ?rs.getString(7):"" );
				userDetail.add(rs.getString(8)!=null ?rs.getString(8):"" );
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("userDetail userDetail() failed");
			
		}finally{
			closeDB();
		}
		return userDetail;	
	}
	
	public ArrayList<ArrayList<String>> searchUser(String dataType,String value){
		ArrayList<ArrayList<String>> userList = new ArrayList<ArrayList<String>>();
		try{
			openDB();
			
			if(value.equals("")){ //全查 總攬
				sql="select UID,Account,Role,LastName,FirstName from L_user " +
						"order by " + dataType;
				pstmt = conn.prepareStatement(sql);
				//pstmt.setString(1, dataType);
			}else{
				//部分查
				sql= "select UID,Account,Role,LastName,FirstName from L_user" +
					" where "+ dataType + " like ? "; //不可條件跟值都是 '?'
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "'%"+value+"%'");
				}
			rs=pstmt.executeQuery();
			//int index=0;
			while(rs.next()){			
				ArrayList<String> user = new ArrayList<String>();
				user.add(rs.getString(1)!=null ?rs.getString(1):"");//UID
				user.add(rs.getString(2)!=null ?rs.getString(2):"");//Account
				user.add(rs.getString(3)!=null ?rs.getString(3):"");//Role
				user.add(rs.getString(4)!=null ?rs.getString(4):"");//LastName
				user.add(rs.getString(5)!=null ?rs.getString(5):"");//FirstName
				userList.add(user);
				//index++;
			}
			System.out.println("userDAO searchUser() Success");
		}catch(Exception e){
			System.out.println("userDAO searchUser() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return userList;
	}
	public void addUser(String[] userValue) throws Exception{
		DecimalFormat formatter = new DecimalFormat("U00"); //轉換為5碼
		//formatter.applyPattern("B00000");//套用格式
		String lastUID = "";
		String UID = "";
		int index = 0;	
		try {
			openDB();
			//設定BID
			String sqlLast="select top(1) * from L_user order by UID desc";
			pstmt = conn.prepareStatement(sqlLast);
			rs=pstmt.executeQuery();
			while(rs.next()){
				lastUID = rs.getString(1).substring(1);
				UID=formatter.format((Integer.parseInt(lastUID)+1)); 
			}
			//getRoleID
			String RoleID = userValue[2];
			String AID = "";
			String MID = "";
			if(RoleID.equals("3")){//administrator
				DecimalFormat formatRoleID = new DecimalFormat("A00"); //轉換為5碼
				String lastRoleID="";
				String sqlRoleID="select top(1)AdminID from Administrator order by AdminID desc";
				pstmt = conn.prepareStatement(sqlRoleID);
				rs=pstmt.executeQuery();
				while(rs.next()){
					lastRoleID = rs.getString(1).substring(1);
					AID=formatRoleID.format((Integer.parseInt(lastRoleID)+1)); 
				}			
			}else if(RoleID.equals("2")){ //manager
				DecimalFormat formatRoleID = new DecimalFormat("M00"); //轉換為5碼
				String lastRoleID="";
				String sqlRoleID="select top(1)MID from Manager order by MID desc";
				pstmt = conn.prepareStatement(sqlRoleID);
				rs=pstmt.executeQuery();
				while(rs.next()){
					lastRoleID = rs.getString(1).substring(1);
					MID=formatRoleID.format((Integer.parseInt(lastRoleID)+1)); 
				}
			}
			
			//insert User
			sql = "insert into L_user values ( ?,?,?,?,?,?,?,? ) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, UID);
			pstmt.setString(2, userValue[0]);
			pstmt.setString(3, userValue[1]);
			pstmt.setString(4, userValue[2]);
			pstmt.setString(5, userValue[3]);
			pstmt.setString(6, userValue[4]);
			pstmt.setString(7, userValue[5]);
			pstmt.setString(8, userValue[6]);
			pstmt.execute();
			
			//insert manager/admin table
			if(RoleID.equals("3")){
				sql = "insert into Administrator values ( ?,?  ) ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, AID);
				pstmt.setString(2, UID);
				pstmt.execute();
			}else if(RoleID.equals("2")){
				sql = "insert into Manager values ( ?,?  ) ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, MID);
				pstmt.setString(2, UID);
				pstmt.execute();
			}
			System.out.println("userDAO addUser() success");
		} catch (SQLException e) {
			System.out.println("userDAO addUser() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}	
	}
	public void modifyUser(String[] userValue,String UID) throws Exception{
		int index = 0;	
		boolean result = true;
		try {
			openDB();
			//getRoleID
			String RoleID = userValue[2];
			String AID = "";
			String MID = "";
			//Upadte User
			sql = "Update L_user set Account = ?,password = ? ,role = ?," +
					" email = ? , LastName = ?, FirstName = ? , Telephone = ? " +
					" where UID = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userValue[0]);
			pstmt.setString(2, userValue[1]);
			pstmt.setString(3, userValue[2]);
			pstmt.setString(4, userValue[3]);
			pstmt.setString(5, userValue[4]);
			pstmt.setString(6, userValue[5]);
			pstmt.setString(7, userValue[6]);
			pstmt.setString(8, UID);
			pstmt.execute();
			
			//Update manager/admin table 本次不會用到 暫時不改
			
			System.out.println("userDAO modifyUser() success");
		} catch (SQLException e) {
			System.out.println("userDAO modifyUser() failed");
			e.printStackTrace();
		}finally{
			closeDB();
			
		}	
		
	}
	public void deleteUser(String UID,String role) throws Exception{
		try {
			openDB();
			//delete data in manager/Administrator 先做這個 因為有FK
			if(role.equals("3")){
				sql = "delete Administrator where UID = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, UID);
				pstmt.execute();
				
			}else if(role.equals("2")){
				sql = "delete Manager where UID = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, UID);
				pstmt.execute();
			}
			
			//delete data in BookContent
			sql = "delete L_User where UID = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, UID);
			pstmt.execute();	
			
			
			
			System.out.println("userDAO deleteUser() success");
		} catch (SQLException e) {
			System.out.println("userDAO deleteUser() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}	
	}
	//addBook用
	public void getSchema() throws Exception{
		sql="select SID,SchName from L_Schema" ;
		try {
			openDB();
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next() && rs.getString(2)!=null ){			
				bookSchema.put(rs.getString(1), rs.getString(2));//SID,SchName			
			}
		} catch (SQLException e) {
			System.out.println("bookDAO getSchema() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}		
	}//end getSchema

}//end class
