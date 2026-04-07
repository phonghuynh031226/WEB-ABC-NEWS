package com.poly.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseHelper {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=ABCNews;encrypt=false";
    private static final String USER = "sa";
    private static final String PASSWORD = "phong123"; 

    public static Connection openConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
