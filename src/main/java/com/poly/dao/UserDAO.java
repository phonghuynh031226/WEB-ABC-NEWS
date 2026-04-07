package com.poly.dao;

import com.poly.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";

        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User(
                    rs.getString("Id"),
                    rs.getString("Password"),
                    rs.getString("Fullname"),
                    rs.getDate("Birthday"),
                    rs.getBoolean("Gender"),
                    rs.getString("Mobile"),
                    rs.getString("Email"),
                    rs.getBoolean("Role")
                );
                list.add(u);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public User findById(String id) {
        String sql = "SELECT * FROM Users WHERE Id = ?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getString("Id"),
                    rs.getString("Password"),
                    rs.getString("Fullname"),
                    rs.getDate("Birthday"),
                    rs.getBoolean("Gender"),
                    rs.getString("Mobile"),
                    rs.getString("Email"),
                    rs.getBoolean("Role")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void insert(User u) {
        String sql = "INSERT INTO Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getId());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getFullname());
            ps.setDate(4, u.getBirthday());
            ps.setBoolean(5, u.isGender());
            ps.setString(6, u.getMobile());
            ps.setString(7, u.getEmail());
            ps.setBoolean(8, u.isRole());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(User u) {
        String sql = "UPDATE Users SET Password=?, Fullname=?, Birthday=?, Gender=?, Mobile=?, Email=?, Role=? WHERE Id=?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getPassword());
            ps.setString(2, u.getFullname());
            ps.setDate(3, u.getBirthday());
            ps.setBoolean(4, u.isGender());
            ps.setString(5, u.getMobile());
            ps.setString(6, u.getEmail());
            ps.setBoolean(7, u.isRole());
            ps.setString(8, u.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(String id) {
        String sql = "DELETE FROM Users WHERE Id=?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
