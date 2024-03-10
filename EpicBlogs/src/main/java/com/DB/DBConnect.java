package com.DB;

import java.sql.*;

public class DBConnect {
	private static Connection conn;

	public static Connection getConnection() throws SQLException,ClassNotFoundException{
		try {
			if (conn == null) {
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				//String ip="152.57.200.235";
				String Url = "jdbc:mysql://localhost:3306/blog";
				String username = "user";
				//String password = "kanishkd7";
				String password = "mayur@123";
				conn = DriverManager.getConnection(Url,username,password);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

}
/*
 DataBase connection check
	public static void function1() {
	 String sqlQuery = "SELECT * FROM user";
     try {
         PreparedStatement preparedStatement = conn.prepareStatement(sqlQuery);
         ResultSet resultSet = preparedStatement.executeQuery();
         while (resultSet.next()) {
        	 String name  = resultSet.getString("username");
        	 System.out.println(name);
         }
     } catch (SQLException e) {
         e.printStackTrace();
     }
	}
*/	
	
	
	
	
	/*	
	
	public static void main(String arg[]) throws SQLException,ClassNotFoundException
	{
		Connection temp = DBConnect.getConnection();
		if(temp!=null)
		{
			System.out.println("Success");
			DBConnect.function1();
		}else {
			System.out.println("Failed");
		}
		
	}
	
}*/
