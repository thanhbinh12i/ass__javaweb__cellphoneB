/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import database.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Product;

/**
 *
 * @author PC
 */
@WebServlet(name = "UpdatePlusQuantityController", urlPatterns = {"/UpdatePlusQuantityController"})
public class UpdatePlusQuantityController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "cart.jsp";
    private static final String SUCCESS = "cart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        
        try {
            String id = request.getParameter("ID");
            ProductDAO dao = new ProductDAO();
            int quantity = dao.getProductQuantity(id);
            HttpSession session = request.getSession();

            Cart cart = (Cart) session.getAttribute("CART");
            if (cart != null) {
                if (cart.getCart().containsKey(id)) {
                    String image = cart.getCart().get(id).getImage();
                    String brand = cart.getCart().get(id).getBrand();
                    String name = cart.getCart().get(id).getProductName();
                    double price = cart.getCart().get(id).getPrice();
                    String description = cart.getCart().get(id).getDescription();
                    int year = cart.getCart().get(id).getYearOfProduction();
                    int notSale = cart.getCart().get(id).getNotSale();
                    int quantityToBuy = cart.getCart().get(id).getQuantity();
                    int discount = cart.getCart().get(id).getDiscount();
                    if (quantityToBuy < quantity) {
                        quantityToBuy = quantityToBuy + 1;
                        Product updatedProduct = new Product(id, image, brand, name, price, description, year, quantityToBuy, notSale, discount);
                        boolean check = cart.change(id, updatedProduct);
                        if (check) {
                            session.setAttribute("CART", cart);
                            url = SUCCESS;
                        }
                    }else{
                        request.setAttribute("ERROR", "Không đủ số lượng");
                    }

                }
            }
        } catch (Exception e) {
            log("Error at UpdateQuantityController: " + e.toString());
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
