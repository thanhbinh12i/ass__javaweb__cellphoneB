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
import model.User;

/**
 *
 * @author PC
 */
public class UserDAO {
    private static final String LOGIN="SELECT * FROM tbl_User WHERE userId=? AND password=? ";
    private static final String SELECTBYID="SELECT * FROM tbl_User WHERE userId=? ";
    private static final String SEARCH = "SELECT * FROM tbl_User WHERE fullName like ?";
    private static final String UPDATE = "UPDATE tbl_User set fullName = ?, phoneNumber=?, address =?, email=? where userId = ?";
    private static final String CHANGEPASSWORD = "UPDATE tbl_User set password=? where userId = ?";
    private static final String DELETE = "DELETE tbl_User WHERE userID=?";
    private static final String SELECT="SELECT * FROM tbl_User ";
    private static final String CHECK_DUPLICATE="SELECT userId FROM tbl_User WHERE userId=?  ";
    private static final String INSERT="INSERT INTO tbl_User VALUES(?,?,?,?,?,?,?)";
    public User checkLogin(String userID, String password) throws SQLException {
        User user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LOGIN);
                ptm.setString(1, userID);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String role = rs.getString("role");
                    String phoneNumber = rs.getString("phoneNumber");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    user = new User(userID, password, fullName, role,phoneNumber,address,email);
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
        return user;
    }
    public User getUserByID(User user) throws SQLException {
        User reuser = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECTBYID);
                ptm.setString(1, user.getUserId());
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String userId = rs.getString("userId");
                    String password = rs.getString("password");
                    String fullName = rs.getString("fullName");
                    String role = rs.getString("role");
                    String phoneNumber = rs.getString("phoneNumber");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    user = new User(userId, password, fullName, role,phoneNumber,address,email);
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
        return reuser;
    }
    public List<User> getListUserByName(String search) throws SQLException {
        List<User> list = new ArrayList<>();
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
                    String userID = rs.getString("userId");
                    String fullName = rs.getString("fullName");
                    String role = rs.getString("role");
                    String password = "***";
                    String phoneNumber = rs.getString("phoneNumber");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    list.add(new User(userID, password, fullName, role, phoneNumber, address, email));
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
    public List<User> getListUserByID(String search) throws SQLException {
        List<User> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECTBYID);
                ptm.setString(1,search);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userId");
                    String fullName = rs.getString("fullName");
                    String role = rs.getString("role");
                    String password = "***";
                    String phoneNumber = rs.getString("phoneNumber");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    list.add(new User(userID, password, fullName, role, phoneNumber, address, email));
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
    public List<User> getListUser() throws SQLException {
        List<User> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userId");
                    String fullName = rs.getString("fullName");
                    String role = rs.getString("role");
                    String password = "***";
                    String phoneNumber = rs.getString("phoneNumber");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    list.add(new User(userID, password, fullName, role, phoneNumber, address, email));
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
    public boolean updateInfo(User user) throws SQLException {
        boolean checkUpdate = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, user.getFullName());
                ptm.setString(2, user.getPhoneNumber());
                ptm.setString(3, user.getAddress());
                ptm.setString(4, user.getEmail());
                ptm.setString(5, user.getUserId());
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
    public boolean changePassword(User user) throws SQLException {
        boolean checkUpdate = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHANGEPASSWORD);
                ptm.setString(1, user.getPassword());
                ptm.setString(2, user.getUserId());
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
    public boolean delete(String userID) throws SQLException {
        boolean checkDelete = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE);
                ptm.setString(1, userID);
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
    public boolean checkDuplicate(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_DUPLICATE);
                ptm.setString(1, userID);
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

    public boolean insert(User user) throws ClassNotFoundException, SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = JDBCUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, user.getUserId());
                ptm.setString(2, user.getPassword());
                ptm.setString(3, user.getFullName());
                ptm.setString(4, user.getRole());
                ptm.setString(5, user.getPhoneNumber());
                ptm.setString(6, user.getAddress());
                ptm.setString(7, user.getEmail());
                
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
