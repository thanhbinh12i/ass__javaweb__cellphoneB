/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import database.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Product;

/**
 *
 * @author PC
 */
@WebServlet(name = "FilterProductController", urlPatterns = {"/FilterProductController"})
public class FilterProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "shop.jsp";
    private static final String SUCCESS = "shop.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();
        try {
            String[] selectedBrands = request.getParameterValues("brand");
            String[] selectedPriceRanges = request.getParameterValues("filterprice");

            ProductDAO dao = new ProductDAO();
            List<Product> products = new ArrayList<>();

            if ((selectedBrands == null || selectedBrands.length == 0 || "allBrands".equals(selectedBrands[0]))
                    && (selectedPriceRanges == null || selectedPriceRanges.length == 0)) {
                products = dao.getListProduct();
            } else if (selectedBrands != null && selectedBrands.length > 0
                    && (selectedPriceRanges == null || selectedPriceRanges.length == 0)) {
                products = dao.getListProductByBrand(selectedBrands);
            } else if ((selectedBrands == null || selectedBrands.length == 0)
                    && selectedPriceRanges != null && selectedPriceRanges.length > 0) {
                List<Product> filteredProducts = new ArrayList<>();
                for (String priceRange : selectedPriceRanges) {
                    String[] bounds = priceRange.split("-");
                    double lowerBound = Double.parseDouble(bounds[0]);
                    double upperBound = Double.parseDouble(bounds[1]);
                    filteredProducts.addAll(dao.getProductsByPriceRange(lowerBound, upperBound));
                }

                Set<Product> productSet = new HashSet<>(filteredProducts);
                products = new ArrayList<>(productSet);
            } else {

                List<Product> filteredProducts = new ArrayList<>();
                for (String priceRange : selectedPriceRanges) {
                    String[] bounds = priceRange.split("-");
                    double lowerBound = Double.parseDouble(bounds[0]);
                    double upperBound = Double.parseDouble(bounds[1]);
                    List<Product> productsByPriceRange = dao.getProductsByPriceRange(lowerBound, upperBound);
                    for (Product product : productsByPriceRange) {
                        for (String brand : selectedBrands) {
                            if (product.getBrand().equals(brand)) {
                                filteredProducts.add(product);
                                break;
                            }
                        }
                    }
                }
                Set<Product> productSet = new HashSet<>(filteredProducts);
                products = new ArrayList<>(productSet);
            }



            request.setAttribute("LIST_SearchProduct", products);

            request.setAttribute("selectedBrands", selectedBrands);
            request.setAttribute("selectedPrices", selectedPriceRanges);

        } catch (Exception e) {
            log("Error at AddToWishListController: " + e.toString());
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
