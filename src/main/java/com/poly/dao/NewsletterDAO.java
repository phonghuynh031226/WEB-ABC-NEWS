package com.poly.dao;

import com.poly.model.Newsletter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsletterDAO {
    public List<Newsletter> findAll() {
        List<Newsletter> list = new ArrayList<>();
        String sql = "SELECT * FROM Newsletters";

        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Newsletter(rs.getString("Email"), rs.getBoolean("Enabled")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public void delete(String email) {
        String sql = "DELETE FROM Newsletters WHERE Email = ?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void toggle(String email) {
        String sql = "UPDATE Newsletters SET Enabled = CASE WHEN Enabled = 1 THEN 0 ELSE 1 END WHERE Email = ?";
        try (Connection con = DatabaseHelper.openConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
