package mylibrary;
import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.*;

//build database connection
public class bookDAO {
	private Map<String,String>bookSchema = new HashMap<String,String>();
	//private String bookSchema[];
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;
	public bookDAO(){
		
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
			System.out.println("bookDAO openDB failed");
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
	
	public ArrayList<String> getBookDetail(String BID){
		ArrayList<String> bookDetail = new ArrayList<String>();
		Collection<String> schema;
		try {
			getSchema(); //get bookSchema
			openDB();
			schema = bookSchema.values();
			//設定BID
			sql = "select Contents from BookContents where BID= ? order by BID,SID ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, BID);
			rs=pstmt.executeQuery();
			int index = 0 ;
			while(rs.next() && index < schema.size()){
				bookDetail.add(rs.getString(1)!=null ? rs.getString(1): "");
				index++;
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("bookDAO bookDetail() failed");
			
		}finally{
			closeDB();
		}
		return bookDetail;	
	}
	
	public ArrayList<ArrayList<String>> searchBook(String schema,String value){
		ArrayList<ArrayList<String>> bookList = new ArrayList<ArrayList<String>>();
		
		try{
			openDB();
			if(value.equals("")){ //全查 總攬
				sql = " select R1.BID, R1.Contents Title,R2.Contents Author,R3.Contents from "
						+ " (select BID, Contents from BookContents where SID = ? ) R1, "
						+ " (select BID, Contents from BookContents where SID = ? ) R2, "
						+ " (select BID, Contents from BookContents where SID = ? ) R3 "
						+ " where R1.BID = R2.BID and R1.BID = R3.BID order by R1.BID";				
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, "S01");
						pstmt.setString(2, "S02");
						pstmt.setString(3, "S03");
			}else{
				//部分查
			sql= "  Select allData.BID,allData.Title,allData.Author,allData.Publisher from "
				+" (select R1.BID,R1.Contents Title ,R2.Contents Author,R3.Contents Publisher from "
				+" (select BID,Contents from BookContents where SID = 'S01') R1, "
				+" (select BID, Contents from BookContents where SID = 'S02' ) R2, "
				+" (select BID,Contents from BookContents where SID = 'S03') R3 "
				+" where R1.BID = R2.BID and R1.BID = R3.BID) allData ,(select * from BookContents "
				+" where  SID = ? and Contents like ? ) C "
				+" where allData.BID = C.BID order by allData.BID";
		
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, schema);
				pstmt.setString(2, "%"+value+"%");
				}
			rs=pstmt.executeQuery();
			int index=0;
			while(rs.next()){				
				ArrayList<String> book = new ArrayList<String>();
				book.add(rs.getString(1));//BID
				book.add(rs.getString(2));//Title
				book.add(rs.getString(3));//Author
				book.add(rs.getString(4));//Publisher
				bookList.add(book);
				//index++;
			}
			
		}catch(Exception e){
			System.out.println("bookDAO searchBook() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return bookList;
	}
	public void addBook(String[] bookValue) throws Exception{
		
		
		DecimalFormat formatter = new DecimalFormat("B00000"); //轉換為5碼
		//formatter.applyPattern("B00000");//套用格式
		String lastBID = "";
		String BID = "";
		int index = 0;	
		try {
			openDB();
			//設定BID
			String sqlLast="select top(1) * from book order by BID desc";
			pstmt = conn.prepareStatement(sqlLast);
			rs=pstmt.executeQuery();
			while(rs.next()){
				lastBID = rs.getString(1).substring(1);
				BID=formatter.format((Integer.parseInt(lastBID)+1)); 
			}
			//getSID
			String sqlSID="select SID from L_schema";
			ArrayList<String> SID= new ArrayList<String>();
			pstmt = conn.prepareStatement(sqlSID);
			rs=pstmt.executeQuery();
			while(rs.next()){
				SID.add(rs.getString(1));
				//index++;
			}
			index=0;
			//insert Book
			sql = "insert into book values ( ? ) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, BID);
			pstmt.execute();
			//insert BookContent
			sql = "insert into BookContents values ( ?,?,?  ) ";
			pstmt = conn.prepareStatement(sql);
			while(index < SID.size()){		
				pstmt.setString(1, BID);
				pstmt.setString(2, SID.get(index));
				pstmt.setString(3, bookValue[index]);
				pstmt.execute();
				index++;
			}
			index=0;
			System.out.println("bookDAO addBook success");
		} catch (SQLException e) {
			System.out.println("bookDAO addBook() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}	
	}
	public void modifyBook(String[] bookValue,String BID) throws Exception{
		int index = 0;	
		try {
			openDB();
			
			//getSID
			String sqlSID="select SID from L_schema";
			ArrayList<String> SID= new ArrayList<String>();
			pstmt = conn.prepareStatement(sqlSID);
			rs=pstmt.executeQuery();
			while(rs.next()){
				SID.add(rs.getString(1));
				//index++;
			}
			index=0;
			//update BookContent
			sql = "Update BookContents set Contents = ? " +
					" where BID = ? and SID = ? ";
			pstmt = conn.prepareStatement(sql);
			while(index < SID.size()){		
				pstmt.setString(1, bookValue[index]);
				pstmt.setString(2, BID);
				pstmt.setString(3, SID.get(index));
				pstmt.execute();
				index++;
			}
			index=0;
			System.out.println("bookDAO modifyBook() success");
		} catch (SQLException e) {
			System.out.println("bookDAO modifyBook() failed");
			e.printStackTrace();
		}finally{
			closeDB();
		}	
	}
	public void deleteBook(String BID) throws Exception{
		try {
			openDB();
			//delete data in BookContent
			sql = "delete Bookcontents where BID = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, BID);
			pstmt.execute();	
			
			//delete data in book
			sql = "delete book where BID = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, BID);
			pstmt.execute();	
			
			System.out.println("bookDAO deleteBook() success");
		} catch (SQLException e) {
			System.out.println("bookDAO deleteBook() failed");
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
