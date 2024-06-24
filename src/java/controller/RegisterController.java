/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import database.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import model.UserError;

/**
 *
 * @author PC
 */
@WebServlet(name="RegisterController", urlPatterns={"/RegisterController"})
public class RegisterController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR="register.jsp";
    private static final String SUCCESS="login.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url= ERROR;
        UserDAO dao= new UserDAO();
        UserError userError= new UserError();
        try {
            String userID= request.getParameter("userId");
            String fullName= request.getParameter("name");
            String phoneNumber= request.getParameter("phoneNumber");
            String email= request.getParameter("email");
            String address= request.getParameter("address");
            String passwordStr = request.getParameter("password");
            String re_passStr= request.getParameter("repassword");
            
            boolean checkValidation= true;
            if(userID.length() == 0){
                userError.setUserID("User ID can not empty");
                checkValidation= false;
            }
            if(dao.checkDuplicate(userID)){
                userError.setUserID("User ID already exist");
                checkValidation= false;
            }
            if(fullName.length() == 0){
                userError.setFullName("Full Name can not empty");
                checkValidation= false;
            }
            if(!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")){
                userError.setEmail("Email must be abc@abc.com");
                checkValidation= false;
            }
            if(!phoneNumber.matches("^0\\d{9}$")){
                userError.setPhoneNumber("Phone number must be 0xxxxxxxxx");
                checkValidation= false;
            }
            if(!passwordStr.equals(re_passStr)){
                checkValidation= false;
            }
            if(checkValidation){
                User user= new User(userID, passwordStr, fullName, "US", phoneNumber, address, email);
                boolean checkInsert= dao.insert(user);
                if(checkInsert){
                    url= SUCCESS;
                }
            }else{
                request.setAttribute("USER_ERROR", userError);
            }
        } catch (Exception e) {
            log("Error at CreateController: "+ e.toString());
            if(e.toString().contains("duplicate")){
                userError.setUserID("Trung id roi!");
                request.setAttribute("USER_ERROR", userError);
            }
            
        }finally{
            request.getRequestDispatcher(url).forward(request, response);
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
