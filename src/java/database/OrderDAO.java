/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import utils.JDBCUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.Product;

/**
 *
 * @author PC
 */
public class OrderDAO {

    private static final String INSERT = "INSERT INTO tbl_Order VALUES(?,?,?,?,0)";
    private static final String INSERT_OD = "INSERT INTO tbl_OrderDetail VALUES(?,?,?,?)";
    private static final String SELECT = "SELECT * FROM tbl_Order where orderId = ?";
    private static final String SELECTBYUSERID = "SELECT * FROM tbl_Order where userId = ?";
    private static final String SELECTOD = "select *\n"
            + "from  tbl_Order o\n"
            + "join tbl_OrderDetail od on od.orderId = o.orderId\n"
            + "join tbl_Product p on od.productId = p.productId\n"
            + "where o.orderId = ?";

    public boolean insert(Order order) throws ClassNotFoundException, SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setInt(1, order.getOrderId());
                ptm.setString(2, order.getUserId());
                ptm.setDouble(3, order.getTotalPrice());
                ptm.setString(4, order.getOrderDate());
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

    public boolean insertOD(int orderId, String productId, int quantity, double price) throws ClassNotFoundException, SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_OD);
                ptm.setInt(1, orderId);
                ptm.setString(2, productId);
                ptm.setInt(3, quantity);
                ptm.setDouble(4, price);
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

    public Order getOrder(int orderId) throws SQLException {
        Order order = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT);
                ptm.setInt(1, orderId);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userId = rs.getString("userId");
                    double totalPrice = rs.getDouble("totalPrice");
                    String orderDate = rs.getString("orderDate");
                    int status = rs.getInt("status");
                    order = new Order(orderId, userId, totalPrice, orderDate);
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
        return order;
    }

    public List<Order> getListOrder(String userId) throws SQLException {
        List<Order> listOrder = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECTBYUSERID);
                ptm.setString(1, userId);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderId = rs.getInt("orderId");
                    double totalPrice = rs.getDouble("totalPrice");
                    String orderDate = rs.getString("orderDate");
                    int status = rs.getInt("status");
                    Order order = new Order(orderId, userId, totalPrice, orderDate);
                    listOrder.add(order);
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
        return listOrder;
    }
    public List<OrderDetail> getListOrderDetail(int orderId) throws SQLException {
        List<OrderDetail> listOrder = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECTOD);
                ptm.setInt(1, orderId);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productId = rs.getString("productId");
                    String image = rs.getString("image");
                    String brand = rs.getString("brand");
                    String productName = rs.getString("productName");
                    double price = rs.getDouble("price");
                    String description = rs.getString("description");
                    int yearOfProduction = rs.getInt("yearOfProduction");
                    int quantity = rs.getInt("quantity");
                    int notSale = rs.getInt("notSale");
                    int discount = rs.getInt("discount");
                    int quantityToBuy = rs.getInt("quantity");
                    double price2 = rs.getDouble("price");
                    Product product = new Product(productId, image, brand, productName, price, description, yearOfProduction, quantity, notSale, discount);
                    OrderDetail od = new OrderDetail(orderId, product, quantityToBuy , price2);
                    listOrder.add(od);
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
        return listOrder;
    }

    public boolean updateQuantity(String productId, int quantity) throws ClassNotFoundException, SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("{CALL UpdateProductQuantity(?, ?)}");
                ptm.setString(1, productId);
                ptm.setInt(2, quantity);
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
}
