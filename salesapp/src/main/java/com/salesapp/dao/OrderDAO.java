package com.salesapp.dao;

import com.salesapp.model.Order;
import com.salesapp.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public void insert(Order o) throws SQLException {
        String sql = "INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, o.getOrdNo());
            ps.setBigDecimal(2, o.getPurchAmt());
            ps.setDate(3, Date.valueOf(o.getOrdDate()));
            ps.setInt(4, o.getCustomerId());
            ps.setInt(5, o.getSalesmanId());
            ps.executeUpdate();
        }
    }

    public void update(Order o) throws SQLException {
        String sql = "UPDATE orders SET purch_amt=?, ord_date=?, customer_id=?, salesman_id=? WHERE ord_no=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBigDecimal(1, o.getPurchAmt());
            ps.setDate(2, Date.valueOf(o.getOrdDate()));
            ps.setInt(3, o.getCustomerId());
            ps.setInt(4, o.getSalesmanId());
            ps.setInt(5, o.getOrdNo());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM orders WHERE ord_no=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Order findById(int id) throws SQLException {
        String sql = "SELECT o.*, c.cust_name AS customer_name, s.name AS salesman_name " +
                     "FROM orders o " +
                     "LEFT JOIN customer c ON o.customer_id = c.customer_id " +
                     "LEFT JOIN salesman s ON o.salesman_id = s.salesman_id " +
                     "WHERE o.ord_no=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public List<Order> findAll() throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, c.cust_name AS customer_name, s.name AS salesman_name " +
                     "FROM orders o " +
                     "LEFT JOIN customer c ON o.customer_id = c.customer_id " +
                     "LEFT JOIN salesman s ON o.salesman_id = s.salesman_id " +
                     "ORDER BY o.ord_no";
        try (Connection con = DatabaseConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    private Order mapRow(ResultSet rs) throws SQLException {
        Order o = new Order(
            rs.getInt("ord_no"),
            rs.getBigDecimal("purch_amt"),
            rs.getDate("ord_date").toLocalDate(),
            rs.getInt("customer_id"),
            rs.getInt("salesman_id")
        );
        try { o.setCustomerName(rs.getString("customer_name")); } catch (SQLException ignored) {}
        try { o.setSalesmanName(rs.getString("salesman_name")); } catch (SQLException ignored) {}
        return o;
    }
}
