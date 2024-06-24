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

/**
 *
 * @author PC
 */
public class ProductDAO {

    private static final String SELECT = "SELECT * FROM tbl_Product where categoryId = ?";
    private static final String SELECTBYBRAND = "SELECT * FROM tbl_Product where brand = ?";
    private static final String SELECTALL = "SELECT * FROM tbl_Product";
    private static final String SEARCH = "SELECT * FROM tbl_Product WHERE productName like ?";
    private static final String SEARCHBYID = "SELECT * FROM tbl_Product WHERE productId= ?";
    private static final String DELETE = "DELETE tbl_Product WHERE productId=?";
    private static final String UPDATE = "UPDATE tbl_Product SET image=?,price=?,description=?,quantity=?,notSale=?,discount=? WHERE productId=?";
    private static final String INSERT = "INSERT INTO tbl_Product values (?,?,?,?,?,?,?,?,?,?)";
    private static final String SELECTQUANTITY = "select quantity from tbl_Product where productId = ?";
    private static final String CHECK_DUPLICATE="SELECT productId FROM tbl_Product WHERE productId=?  ";

    public List<Product> getListProductSQL(String sql) throws SQLException {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(sql);
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
                    list.add(new Product(productId, image, brand, productName, price, description, yearOfProduction, quantity, notSale, discount));
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
    public boolean checkDuplicate(String productId) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_DUPLICATE);
                ptm.setString(1, productId);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    check = true;
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
        return check;
    }
    public List<Product> getListProductByName(String search) throws SQLException {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH);
                ptm.setString(1, "%" + search + "%");
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
                    list.add(new Product(productId, image, brand, productName, price, description, yearOfProduction, quantity, notSale, discount));
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

    public List<Product> getListProductByBrand(String[] brands) throws SQLException {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                StringBuilder query = new StringBuilder("SELECT * FROM tbl_Product WHERE brand IN (");
                for (int i = 0; i < brands.length; i++) {
                    query.append("?");
                    if (i < brands.length - 1) {
                        query.append(", ");
                    }
                }
                query.append(")");

                ptm = conn.prepareStatement(query.toString());

                // Set the brands in the prepared statement
                for (int i = 0; i < brands.length; i++) {
                    ptm.setString(i + 1, brands[i]);
                }

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
                    list.add(new Product(productId, image, brand, productName, price, description, yearOfProduction, quantity, notSale, discount));
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

    public List<Product> getListProduct() throws SQLException {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECTALL);
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
                    list.add(new Product(productId, image, brand, productName, price, description, yearOfProduction, quantity, notSale, discount));
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
    public List<Product> getListProductByID(String search) throws SQLException {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCHBYID);
                ptm.setString(1,search);
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
                    list.add(new Product(productId, image, brand, productName, price, description, yearOfProduction, quantity, notSale, discount));
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

    public int getProductQuantity(String productId) throws SQLException {
        int quantity = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECTQUANTITY);
                ptm.setString(1, productId);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    quantity = rs.getInt("quantity");
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
        return quantity;
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

    public boolean update(Product product) throws SQLException {
        boolean checkUpdate = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, product.getImage());
                ptm.setDouble(2, product.getPrice());
                ptm.setString(3, product.getDescription());
                ptm.setInt(4, product.getQuantity());
                ptm.setInt(5, product.getNotSale());
                ptm.setInt(6, product.getDiscount());
                ptm.setString(7, product.getProductId());
                checkUpdate = ptm.executeUpdate() > 0 ? true : false;
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
        return checkUpdate;
    }

    public boolean insert(Product product) throws ClassNotFoundException, SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, product.getProductId());
                ptm.setString(2, product.getImage());
                ptm.setString(3, product.getBrand());
                ptm.setString(4, product.getProductName());
                ptm.setDouble(5, product.getPrice());
                ptm.setString(6, product.getDescription());
                ptm.setInt(7, product.getYearOfProduction());
                ptm.setInt(8, product.getQuantity());
                ptm.setInt(9, product.getNotSale());
                ptm.setInt(10, product.getDiscount());
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

    public List<String> getBrands() throws SQLException {
        List<String> brands = new ArrayList<>();
        String query = "SELECT DISTINCT brand FROM tbl_Product";
        try (Connection conn = JDBCUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(query);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                brands.add(rs.getString("brand"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brands;
    }

    public List<Product> getProductsByPriceRange(double lowerBound, double upperBound) throws SQLException {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                String query = "SELECT * FROM tbl_Product WHERE (price*(100-discount)/100) BETWEEN ? AND ?";
                ptm = conn.prepareStatement(query);
                ptm.setDouble(1, lowerBound * 1000000);  
                ptm.setDouble(2, upperBound * 1000000);  

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
                    products.add(new Product(productId, image, brand, productName, price, description, yearOfProduction, quantity, notSale, discount));
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
        return products;
    }
}
