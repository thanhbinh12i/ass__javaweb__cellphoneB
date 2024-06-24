/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hd
 */
public class MainController extends HttpServlet {

    //User
    private static final String LOGIN = "Login";
    private static final String LOGIN_CONTROLLER = "LoginController";
    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    private static final String CHANGEINFO = "Lưu thông tin";
    private static final String CHANGEINFO_CONTROLLER = "ChangeInfoUserController";
    private static final String CHANGEPASSWORD = "Đổi Mật Khẩu";
    private static final String CHANGEPASSWORD_CONTROLLER = "ChangePasswordController";
    private static final String REGISTER = "Register";
    private static final String REGISTER_CONTROLLER = "RegisterController";
    
    //Admin
    private static final String SHOWLISTUSER = "Search";
    private static final String SHOWLISTUSER_CONTROLLER = "ShowListUserController";
    private static final String REMOVEUSER = "RemoveUser";
    private static final String REMOVEUSER_CONTROLLER = "RemoveUserController";
    private static final String UPDATEUSER = "UpdateUser";
    private static final String UPDATEUSER_CONTROLLER = "UpdateUserController";
    private static final String SHOWLISTPRODUCT = "SearchProduct";
    private static final String SHOWLISTPRODUCT_CONTROLLER = "ShowListProductController";
    private static final String REMOVEPRODUCT = "RemoveProduct";
    private static final String REMOVEPRODUCT_CONTROLLER = "RemoveProductController";
    private static final String UPDATEPRODUCT = "UpdateProduct";
    private static final String UPDATEPRODUCT_CONTROLLER = "UpdateProductController";
    private static final String SHOWINVOICE = "Show Invoice";
    private static final String SHOWINVOICE_CONTROLLER = "ShowInvoiceController";
    private static final String ADDPRODUCT = "Add Product";
    private static final String ADDPRODUCT_CONTROLLER = "AddNewProductController";
    
    //Product
    private static final String ADDTOCART = "Add To Cart";
    private static final String ADDTOCART_CONTROLLER = "AddToCartController";
    private static final String REMOVE="Remove";
    private static final String REMOVE_CONTROLLER="RemoveInCartController";
    private static final String UPDATEMinus="cartminus";
    private static final String UPDATEQUANTITY_CONTROLLER="UpdateMinusQuantityController";
    private static final String UPDATEPlus="cartplus";
    private static final String UPDATEQUANTITY2_CONTROLLER="UpdatePlusQuantityController";
    private static final String SEARCHProduct = "TimKiem";
    private static final String SEARCHProduct_CONTROLLER = "SearchProductController";
    private static final String Order = "Checkout";
    private static final String Order_CONTROLLER = "OrderController";
    private static final String ADDTOWISHLIST = "AddToWishList";
    private static final String ADDTOWISHLIST_CONTROLLER = "AddToWishListController";
    private static final String RemoveWishList = "RemoveWL";
    private static final String RemoveWishList_CONTROLLER = "RemoveInWishListController";
    private static final String SEARCHBYBRAND = "searchByBrand";
    private static final String SEARCHBYBRAND_CONTROLLER = "FilterProductController";

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";
        try {
            String action = request.getParameter("action");
            if (LOGIN.equals(action)) {
                url = LOGIN_CONTROLLER;
            } else if (LOGOUT.equals(action)) {
                url = LOGOUT_CONTROLLER;
            } else if (REGISTER.equals(action)) {
                url = REGISTER_CONTROLLER;
            } else if (CHANGEINFO.equals(action)) {
                url = CHANGEINFO_CONTROLLER;
            }else if (CHANGEPASSWORD.equals(action)) {
                url = CHANGEPASSWORD_CONTROLLER;
            }else if (ADDTOCART.equals(action)) {
                url = ADDTOCART_CONTROLLER;
            }else if(REMOVE.equals(action)){
                url= REMOVE_CONTROLLER;
            }else if (ADDTOWISHLIST.equals(action)) {
                url = ADDTOWISHLIST_CONTROLLER;
            }else if (RemoveWishList.equals(action)) {
                url = RemoveWishList_CONTROLLER;
            }else if(UPDATEMinus.equals(action)){
                url= UPDATEQUANTITY_CONTROLLER;
            }else if(UPDATEPlus.equals(action)){
                url= UPDATEQUANTITY2_CONTROLLER;
            }else if (Order.equals(action)) {
                url = Order_CONTROLLER;
            }else if (SHOWLISTUSER.equals(action)) {
                url = SHOWLISTUSER_CONTROLLER;
            }else if (REMOVEUSER.equals(action)) {
                url = REMOVEUSER_CONTROLLER;
            }else if (UPDATEUSER.equals(action)) {
                url = UPDATEUSER_CONTROLLER;
            }else if (SEARCHProduct.equals(action)) {
                url = SEARCHProduct_CONTROLLER;
            }else if (SHOWLISTPRODUCT.equals(action)) {
                url = SHOWLISTPRODUCT_CONTROLLER;
            }else if (REMOVEPRODUCT.equals(action)) {
                url = REMOVEPRODUCT_CONTROLLER;
            }else if (UPDATEPRODUCT.equals(action)) {
                url = UPDATEPRODUCT_CONTROLLER;
            }else if (SHOWINVOICE.equals(action)) {
                url = SHOWINVOICE_CONTROLLER;
            }else if (ADDPRODUCT.equals(action)) {
                url = ADDPRODUCT_CONTROLLER;
            }else if (SEARCHBYBRAND.equals(action)) {
                url = SEARCHBYBRAND_CONTROLLER;
            }else {
                request.setAttribute("ERROR", "Your action not support");
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
