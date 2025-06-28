/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tokoatk;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
    public static Connection connect() {
        String DBDRIVER = "com.mysql.cj.jdbc.Driver";
        String DBCONNECTION = "jdbc:mysql://localhost:3306/tokoatk";
        String DBUSER = "root";
        String DBPASS = "";

        try {
            Class.forName(DBDRIVER);
            System.out.println("Driver loaded successfully."); 
            Connection conn = DriverManager.getConnection(DBCONNECTION, DBUSER, DBPASS);
            System.out.println("Database connection established!");
            return conn;
        } catch(Exception e) {
            System.err.println("Database connection failed!");
            e.printStackTrace();
            return null;
        }
    }
}