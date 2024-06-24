/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import database.InvoiceDAO;
import database.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Order;
import model.Product;
import model.User;

/**
 *
 * @author PC
 */
@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "order.jsp";
    private static final String SUCCESS = "checkout.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            double price = Double.parseDouble(request.getParameter("totalPrice"));
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String invoiceId = request.getParameter("invoiceId");
            String date = request.getParameter("orderDate");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String paymentMethod = request.getParameter("paymentMethod");
            
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            User user = new User(loginUser.getUserId(), loginUser.getPassword(), fullName, loginUser.getRole(), phone, address, email);
            
            
            Order order = new Order(orderId, loginUser.getUserId(), price, date);
            if (loginUser != null) {

                OrderDAO dao = new OrderDAO();
                
                boolean check = dao.insert(order);

                if (check) {
                    Cart cart = (Cart) session.getAttribute("CART");
                    if (cart == null) {
                        cart = new Cart();
                    }
                    for (Product product : cart.getCart().values()) {
                        check = dao.insertOD(orderId, product.getProductId(), product.getQuantity(), product.getPrice()*product.getQuantity());
                        dao.updateQuantity(product.getProductId(), product.getQuantity());
//                        cart.remove(product.getProductId());
                    }
                    cart.removeAll();
                }
                InvoiceDAO invdao = new InvoiceDAO();
                check = invdao.insert(invoiceId, user, order, paymentMethod);
                if (check) {
                    url = SUCCESS;
                }

            }

        } catch (Exception e) {
            log("Error at AddToCartController: " + e.toString());
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
