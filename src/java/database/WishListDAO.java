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
import model.Product;
import model.WishList;

/**
 *
 * @author PC
 */
public class WishListDAO {
    private static final String SELECT = "SELECT p.*\n"
            + "FROM tbl_WishList wl \n"
            + "JOIN tbl_Product p ON p.productId = wl.productId\n"
            + "WHERE wl.userId = ?";

    private static final String INSERT = "INSERT INTO tbl_WishList VALUES(?,?)";

    private static final String DELETE = "DELETE tbl_WishList WHERE productId=?";
    public List<WishList> getWishList(String userId) throws SQLException {
        List<WishList> wishList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT);
                ptm.setString(1, userId);
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
                    Product product = new Product(productId, image, brand, productName, price, description, yearOfProduction, quantity, notSale, discount);
                    WishList wl = new WishList(userId, product);
                    wishList.add(wl);
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
        return wishList;
    }

    public boolean insert(String userId, String productId) throws ClassNotFoundException, SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, userId);
                ptm.setString(2, productId);
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
    public boolean delete(String productId) throws SQLException {
        boolean checkDelete = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE);
                ptm.setString(1, productId);
                checkDelete = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkDelete;
    }
}
