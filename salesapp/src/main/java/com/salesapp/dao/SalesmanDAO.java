package com.salesapp.dao;

import com.salesapp.model.Salesman;
import com.salesapp.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalesmanDAO {

    public void insert(Salesman s) throws SQLException {
        String sql = "INSERT INTO salesman (salesman_id, name, city, commission) VALUES (?, ?, ?, ?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, s.getSalesmanId());
            ps.setString(2, s.getName());
            ps.setString(3, s.getCity());
            ps.setBigDecimal(4, s.getCommission());
            ps.executeUpdate();
        }
    }

    public void update(Salesman s) throws SQLException {
        String sql = "UPDATE salesman SET name=?, city=?, commission=? WHERE salesman_id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getName());
            ps.setString(2, s.getCity());
            ps.setBigDecimal(3, s.getCommission());
            ps.setInt(4, s.getSalesmanId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM salesman WHERE salesman_id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Salesman findById(int id) throws SQLException {
        String sql = "SELECT * FROM salesman WHERE salesman_id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public List<Salesman> findAll() throws SQLException {
        List<Salesman> list = new ArrayList<>();
        String sql = "SELECT * FROM salesman ORDER BY salesman_id";
        try (Connection con = DatabaseConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    private Salesman mapRow(ResultSet rs) throws SQLException {
        return new Salesman(
            rs.getInt("salesman_id"),
            rs.getString("name"),
            rs.getString("city"),
            rs.getBigDecimal("commission")
        );
    }
}
