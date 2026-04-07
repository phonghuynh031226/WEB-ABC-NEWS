package com.poly.dao;

import com.poly.model.News;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO {
    public List<News> findAll() {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM News ORDER BY PostedDate DESC";

        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                News n = new News(
                    rs.getString("Id"),
                    rs.getString("Title"),
                    rs.getString("Content"),
                    rs.getString("Image"),
                    rs.getDate("PostedDate"),
                    rs.getString("Author"),
                    rs.getString("CategoryId"),
                    rs.getInt("ViewCount"),
                    rs.getBoolean("Home")
                );
                list.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
    public List<News> findByAuthor(String author) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM News WHERE Author = ? ORDER BY PostedDate DESC";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, author);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new News(
                        rs.getString("Id"),
                        rs.getString("Title"),
                        rs.getString("Content"),
                        rs.getString("Image"),
                        rs.getDate("PostedDate"),
                        rs.getString("Author"),
                        rs.getString("CategoryId"),
                        rs.getInt("ViewCount"),
                        rs.getBoolean("Home")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    public void insert(News n) {
        String sql = "INSERT INTO News (Id, Title, Content, Image, PostedDate, Author, CategoryId, ViewCount, Home) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, n.getId());
            ps.setString(2, n.getTitle());
            ps.setString(3, n.getContent());
            ps.setString(4, n.getImage());
            ps.setDate(5, n.getPostedDate());
            ps.setString(6, n.getAuthor());
            ps.setString(7, n.getCategoryId());
            ps.setInt(8, n.getViewCount());
            ps.setBoolean(9, n.isHome());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(News n) {
        String sql = "UPDATE News SET Title=?, Content=?, Image=?, Author=?, CategoryId=?, Home=? WHERE Id=?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getContent());
            ps.setString(3, n.getImage());
            ps.setString(4, n.getAuthor());
            ps.setString(5, n.getCategoryId());
            ps.setBoolean(6, n.isHome());
            ps.setString(7, n.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(String id) {
        String sql = "DELETE FROM News WHERE Id=?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public News findById(String id) {
        String sql = "SELECT * FROM News WHERE Id = ?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new News(
                        rs.getString("Id"),
                        rs.getString("Title"),
                        rs.getString("Content"),
                        rs.getString("Image"),
                        rs.getDate("PostedDate"),
                        rs.getString("Author"),
                        rs.getString("CategoryId"),
                        rs.getInt("ViewCount"),
                        rs.getBoolean("Home")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<News> findHomeNews() {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM News WHERE Home = 1 ORDER BY PostedDate DESC";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new News(
                    rs.getString("Id"),
                    rs.getString("Title"),
                    rs.getString("Content"),
                    rs.getString("Image"),
                    rs.getDate("PostedDate"),
                    rs.getString("Author"),
                    rs.getString("CategoryId"),
                    rs.getInt("ViewCount"),
                    rs.getBoolean("Home")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


}
