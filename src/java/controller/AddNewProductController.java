/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import database.ProductDAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Product;
import model.ProductError;

/**
 
 * @author PC
 */
@MultipartConfig
@WebServlet(name = "AddNewProductController", urlPatterns = {"/AddNewProductController"})
public class AddNewProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "admin_addproduct.jsp";
    private static final String SUCCESS = "admin_addproduct.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        ProductDAO dao = new ProductDAO();
        ProductError productError = new ProductError();
        try {
            boolean checkValidation = true;
            boolean check2 = true;
            String[] images = request.getParameterValues("product_img");
            String productId = request.getParameter("ID");
            String brand = request.getParameter("brand");
            String productName = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String yearStr = request.getParameter("year");
            String quantityStr = request.getParameter("quantity");
            String notSaleStr = request.getParameter("sale");
            String discountStr = request.getParameter("discount");
            double price = 0;
            int yearOfProduction = 0;
            int quantity = 0;
            int notSale = 0;
            int discount = 0;

            if (!priceStr.matches("\\d+")) {
                productError.setPrice("Price must be a valid positive number");
                checkValidation = false;
            }

            if (!yearStr.matches("\\d+")) {
                productError.setYearOfProduction("Year must be a valid positive number");
                checkValidation = false;
            }

            if (!quantityStr.matches("\\d+")) {
                productError.setQuantity("Quantity must be a valid positive number");
                checkValidation = false;
            }
            if (!notSaleStr.matches("\\d+")) {
                productError.setNotSale("Sale status must be a valid positive number");
                checkValidation = false;
            }
            if (!discountStr.matches("\\d+")) {
                productError.setDiscount("Discount must be a valid positive number");
                checkValidation = false;
            }
            if (!productId.matches("MOB\\d{1,3}+$")) {
                productError.setProductId("ID must be MOBxxx");
                checkValidation = false;
            }
            if (checkValidation) {
                price = Double.parseDouble(priceStr);
                yearOfProduction = Integer.parseInt(yearStr);
                quantity = Integer.parseInt(quantityStr);
                notSale = Integer.parseInt(notSaleStr);
                discount = Integer.parseInt(discountStr);
                if (dao.checkDuplicate(productId)) {
                    check2 = false;
                    productError.setProductId(" ID is duplicated");
                }

                if (price <= 0) {
                    check2 = false;
                    productError.setPrice("Price must be greater than 0");
                }
                if (quantity <= 0) {
                    check2 = false;
                    productError.setQuantity("Quantity must be greater than 0");
                }
                if (notSale != 0 && notSale != 1 && notSale != 2) {
                    check2 = false;
                    productError.setNotSale("Sale must be 0 or 1 or 2");
                }
                if (discount < 0 || discount > 100) {
                    check2 = false;
                    productError.setDiscount("Discoutn must be between 0 and 100");
                }

            }
            String image = "";
            if (images[0] != null && !images[0].equals("")) {
                for (int i = 0; i < images.length; i++) {
                    image += "img/mobile/" + images[i] + " ";
                }
            }
            if (checkValidation && check2) {
                Product product = new Product(productId, image, brand, productName, price, description,
                        yearOfProduction, quantity, notSale, discount);

                boolean check = dao.insert(product);

                if (check) {
                    request.setAttribute("MESSAGE", "Add successfully");
                    url = SUCCESS;                }
            } else {
                request.setAttribute("PRODUCT_ERROR", productError);
            }

        } catch (Exception e) {
            log("Error at AddNewProductController: " + e.toString());

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
        return "AddNewProductController";
    }// </editor-fold>

}
