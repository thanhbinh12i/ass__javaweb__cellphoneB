/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import utils.JDBCUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Invoice;
import model.Order;
import model.User;

/**
 *
 * @author PC
 */
public class InvoiceDAO {
    private static final String INSERT = "INSERT INTO tbl_Invoice VALUES(?,?,?,?,?,?,?,?,?,?)";
    private static final String SELECT ="SELECT * FROM tbl_Invoice where userId = ?";
    private static final String SELECTALL ="SELECT * FROM tbl_Invoice";
    public boolean insert(String invoiceId,User user, Order order, String method) throws ClassNotFoundException, SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, invoiceId);
                ptm.setString(2, user.getUserId());
                ptm.setInt(3, order.getOrderId());
                ptm.setString(4, user.getFullName());
                ptm.setString(5, user.getEmail());
                ptm.setString(6, user.getPhoneNumber());
                ptm.setString(7, user.getAddress());
                ptm.setString(8, order.getOrderDate());
                ptm.setDouble(9, order.getTotalPrice());
                ptm.setString(10, method);
                checkInsert = ptm.executeUpdate() > 0 ? true : false;
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkInsert;
    }
    public List<Invoice> getListInvoice(String search) throws SQLException {
        List<Invoice> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT);
                ptm.setString(1, search);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String invoiceId = rs.getString("invoiceId");
                    String userId = rs.getString("userId");
                    int orderId = rs.getInt("orderId");
                    String fullName = rs.getString("fullName");
                    String phoneNumber = rs.getString("phone");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String date = rs.getString("date");
                    double totalPrice = rs.getDouble("totalPrice");
                    String method = rs.getString("methodPayment");
                    Invoice invoice = new Invoice(invoiceId, userId, orderId, fullName, phoneNumber, address, email, date, totalPrice, method);
                    list.add(invoice);        
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
    public List<Invoice> getListInvoice() throws SQLException {
        List<Invoice> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECTALL);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String invoiceId = rs.getString("invoiceId");
                    String userId = rs.getString("userId");
                    int orderId = rs.getInt("orderId");
                    String fullName = rs.getString("fullName");
                    String phoneNumber = rs.getString("phone");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String date = rs.getString("date");
                    double totalPrice = rs.getDouble("totalPrice");
                    String method = rs.getString("methodPayment");
                    Invoice invoice = new Invoice(invoiceId, userId, orderId, fullName, phoneNumber, address, email, date, totalPrice, method);
                    list.add(invoice);        
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
}
