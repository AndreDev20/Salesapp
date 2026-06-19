package com.salesapp.dao;

import com.salesapp.model.Customer;
import com.salesapp.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    public void insert(Customer c) throws SQLException {
        String sql = "INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, c.getCustomerId());
            ps.setString(2, c.getCustName());
            ps.setString(3, c.getCity());
            ps.setInt(4, c.getGrade());
            ps.setInt(5, c.getSalesmanId());
            ps.executeUpdate();
        }
    }

    public void update(Customer c) throws SQLException {
        String sql = "UPDATE customer SET cust_name=?, city=?, grade=?, salesman_id=? WHERE customer_id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getCustName());
            ps.setString(2, c.getCity());
            ps.setInt(3, c.getGrade());
            ps.setInt(4, c.getSalesmanId());
            ps.setInt(5, c.getCustomerId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM customer WHERE customer_id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Customer findById(int id) throws SQLException {
        String sql = "SELECT c.*, s.name AS salesman_name FROM customer c " +
                     "LEFT JOIN salesman s ON c.salesman_id = s.salesman_id WHERE c.customer_id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public List<Customer> findAll() throws SQLException {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT c.*, s.name AS salesman_name FROM customer c " +
                     "LEFT JOIN salesman s ON c.salesman_id = s.salesman_id ORDER BY c.customer_id";
        try (Connection con = DatabaseConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    private Customer mapRow(ResultSet rs) throws SQLException {
        Customer c = new Customer(
            rs.getInt("customer_id"),
            rs.getString("cust_name"),
            rs.getString("city"),
            rs.getInt("grade"),
            rs.getInt("salesman_id")
        );
        try { c.setSalesmanName(rs.getString("salesman_name")); } catch (SQLException ignored) {}
        return c;
    }
}
