package mylibrary;
import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.*;

//build database connection
//用這個查總表
public class schemaDAO { 
	private Map<String,String>bookSchema = new HashMap<String,String>();
	//private String bookSchema[];
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;
	public schemaDAO(){
		
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
			System.out.println("schemaDAO openDB failed");
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
	
	public void addSchema(String schemaValue) throws Exception{
		DecimalFormat formatter = new DecimalFormat("S00"); //轉換為5碼
		//formatter.applyPattern("B00000");//套用格式
		String lastSID = "";
		String SID = "";
		int index = 0;	
		try {
			openDB();
			//設定SID
			String sqlLast="select top(1) * from L_schema order by SID desc";
			pstmt = conn.prepareStatement(sqlLast);
			rs=pstmt.executeQuery();
			while(rs.next()){
				lastSID = rs.getString(1).substring(1);
				SID=formatter.format((Integer.parseInt(lastSID)+1)); 
			}		
			//insert Schema
			sql = "insert into L_schema values ( ?,? ) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, SID);
			pstmt.setString(2, schemaValue);
			pstmt.execute();
			
			//insert to bookContents for every book
			sql = "select distinct BID from BookContents ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				sql = "insert into BookContents values ( ? ,? , ?) ";	
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, rs.getString(1));//BID
				pstmt.setString(2, SID);
				pstmt.setString(3, "");
				pstmt.execute();
			}
			
			System.out.println("schemaDAO addSchema() success");
		} catch (SQLException e) {
			System.out.println("schemaDAO addSchema() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}	
	}
	public void modifySchema(String SID,String SchName) throws Exception{
		int index = 0;	
		try {
			openDB();
			//getRoleID
			sql = "Update L_schema set SchName = ? " +
					" where SID = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, SchName);
			pstmt.setString(2, SID);
			pstmt.execute();
			
			System.out.println("schemaDAO modifySchema() success");
		} catch (SQLException e) {
			System.out.println("schemaDAO modifySchema() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}	
	}
	public void deleteSchema(String SID) throws Exception{
		try {
			openDB();
			
			//delete data in L_schema
			sql = "delete L_Schema where SID = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, SID);
			pstmt.execute();	
			
			//delete data in BookContents
			sql = "delete BookContents where SID = ? " ;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, SID);
			pstmt.execute();	
			
			System.out.println("schemaDAO deleteSchema() success");
		} catch (SQLException e) {
			System.out.println("schemaDAO deleteSchema() failed");
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
			System.out.println("schemaDAO getSchema() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}		
	}//end getSchema

}//end class
