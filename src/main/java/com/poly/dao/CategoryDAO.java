package com.poly.dao;

import com.poly.model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories";

        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(rs.getString("Id"), rs.getString("Name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Category findById(String id) {
        String sql = "SELECT * FROM Categories WHERE Id = ?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Category(rs.getString("Id"), rs.getString("Name"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insert(Category c) {
        String sql = "INSERT INTO Categories (Id, Name) VALUES (?, ?)";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getId());
            ps.setString(2, c.getName());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(Category c) {
        String sql = "UPDATE Categories SET Name = ? WHERE Id = ?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getName());
            ps.setString(2, c.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(String id) {
        String sql = "DELETE FROM Categories WHERE Id = ?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
