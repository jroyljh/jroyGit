package com.kakaopay.db;

import java.sql.DriverManager;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.io.UnsupportedEncodingException;

import java.sql.Connection;


// DAO
public class DaoShortURL {

	 private static String dbURL = "jdbc:derby://localhost:1527/MyDb;create=true"; //해당 DB없으면 생성!
	    private static String tableName = "URL_MAPPING";
	    // jdbc Connection
	    private static Connection conn = null;
	    private static Statement stmt = null;
	
    public static void createConnection()
    {
        try
        {
            Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
            //Get a connection
            conn = DriverManager.getConnection(dbURL); 
        }
        catch (Exception except)
        {
            except.printStackTrace();
        }
    }
    
    public static void createTable()
    {
        try
        {
        	 

        	
	            stmt = conn.createStatement();
	            stmt.execute("CREATE TABLE " + tableName +"(ID INT NOT NULL,  RAW_URL VARCHAR(4000), SHORT_URL VARCHAR(8))");
	            //stmt.close();
	      	
        }
        catch (SQLException sqlExcept)
        {
            sqlExcept.printStackTrace();
        }
    }
    
    public static void createSequence()
    {
        try
        {
            stmt = conn.createStatement();
            stmt.execute("CREATE sequence seq AS int start with 1");
        }
        catch (SQLException sqlExcept)
        {
            sqlExcept.printStackTrace();
        }
    }
    
   
    
    public void insertUrlMapping(int id, String LoAddress, String Short_Url_Make) throws UnsupportedEncodingException
    {
        try
        {
            stmt = conn.createStatement();
            stmt.execute("insert into " + tableName + " values (" +
                    id + ",'" + LoAddress + "','" + Short_Url_Make +"')");
            //stmt.close();
        }
        catch (SQLException sqlExcept)
        {
            sqlExcept.printStackTrace();
        }
    }
    public int selectSequence() {
    	int seq=0;
    	try {
    		stmt = conn.createStatement();
    		ResultSet results = stmt.executeQuery("values NEXT VALUE FOR seq");
    		results.next();
    		seq=results.getInt(1);
    		System.out.println(seq);
    	}catch (SQLException sqlExcept)
        {
    		sqlExcept.printStackTrace();
    		
        }
		return seq;
    }
    
    public String selectUrlCheck(String raw_url) {
    	String Return_Url="";
    	try {

    		stmt = conn.createStatement();
    		//PreparedStatement prmt = conn.prepareStatement("select short_url from "+tableName+ " where raw_url = "+ "'"+raw_url+"'", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    		//ResultSet results = prmt.executeQuery();
    		ResultSet results = stmt.executeQuery("select short_url from "+tableName+ " where raw_url = "+ "'"+raw_url+"'");
    		results.next();
    		if(results.getRow() > 0)
    		{
    		
    		Return_Url= results.getString(1);
    		
    		}
    	}catch (SQLException sqlExcept)
        {
    		sqlExcept.printStackTrace();
    		
      
		}
		return Return_Url;
    }
    
    public String selectShortUrlCheck(String short_url) throws UnsupportedEncodingException {
    	String Return_Url="";
    	try {

    		stmt = conn.createStatement();
    		//PreparedStatement prmt = conn.prepareStatement("select short_url from "+tableName+ " where raw_url = "+ "'"+raw_url+"'", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    		//ResultSet results = prmt.executeQuery();
    		ResultSet results = stmt.executeQuery("select raw_url from "+tableName+ " where short_url = "+ "'"+short_url+"'");
    		results.next();
    		if(results.getRow() > 0)
    		{

    		Return_Url= results.getString(1);
    		//byte[] chbyte = Return_Url.getBytes("EUC-KR");
    		//System.out.println("######chbyt1e###########"+Return_Url.getBytes("EUC-KR"));
    		}
    	}catch (SQLException sqlExcept)
        {
    		sqlExcept.printStackTrace();
    		
        } 
		return Return_Url;
    }
    
    
    public void selectUrlMapping()
    {
        try
        {  
            stmt = conn.createStatement();
            ResultSet results = stmt.executeQuery("select * from " + tableName);
            ResultSetMetaData rsmd = results.getMetaData();
            int numberCols = rsmd.getColumnCount();
            for (int i=1; i<=numberCols; i++)
            {
                //print Column Names
                System.out.print(rsmd.getColumnLabel(i)+"\t\t");  
            }
            
            System.out.println("\n-------------------------------------------------");

            while(results.next())
            {
                int id = results.getInt(1);
                String restName = results.getString(2);
                String cityName = results.getString(3);
                System.out.println(id + "\t\t" + restName + "\t\t" + cityName);
            }
            results.close();

        }
        catch (SQLException sqlExcept)
        {
            sqlExcept.printStackTrace();
        }
    }
    
    public static void shutdown()
    {
        try
        {
            if (stmt != null)
            {
                stmt.close();
            }
            if (conn != null)
            {
                DriverManager.getConnection(dbURL + ";shutdown=true");
                conn.close();
            }           
        }
        catch (SQLException sqlExcept)
        {
            
        }

    } 

}
