package com.poly.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseHelper {
	private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=ABCNews;encrypt=false";
	private static final String USER = "sa";
	private static final String PASSWORD = "phong123";

	public static Connection openConnection() {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
			System.out.println("✅ Kết nối cơ sở dữ liệu thành công!");
			return conn;
		} catch (ClassNotFoundException e) {
			System.out.println("❌ Không tìm thấy driver JDBC!");
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			System.out.println("❌ Kết nối cơ sở dữ liệu thất bại!");
			e.printStackTrace();
			return null;
		}
	}

	public static void main(String[] args) {
		Connection conn = openConnection();
		if (conn != null) {
			System.out.println("🎯 Đã sẵn sàng sử dụng kết nối!");
			try {
				conn.close();
				System.out.println("🔒 Đã đóng kết nối thành công.");
			} catch (SQLException e) {
				System.out.println("⚠️ Lỗi khi đóng kết nối!");
				e.printStackTrace();
			}
		} else {
			System.out.println("⚠️ Không thể kết nối tới cơ sở dữ liệu.");
		}
	}
}
