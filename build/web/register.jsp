<%-- 
    Document   : register.jsp
    Created on : May 17, 2024, 10:28:26 PM
    Author     : PC
--%>

<%@page import="model.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
            crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
        <link href="css/form.css" rel="stylesheet">
        <link href="css/index.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <%
            UserError userError= (UserError)request.getAttribute("USER_ERROR");
            if(userError== null){
                userError= new UserError();
            }
        %>
        <div class="container form-body">
            <div class="container form"> 
                <form action="MainController" class="form" method="POST"> 
                    <img src="img/logoLogin.png">
                    <span class="form-title text-center">
                        Đăng ký
                    </span>
                    <div class="form-input text-center" >
                        <span class="input-icon">
                            <i class="fa fa-user"></i>
                        </span>
                        <input class="input" type="text" name="userId" placeholder="User ID">
                        <span class="focus-input"></span>
                    </div>
                    <p class="red"><%= userError.getUserID()%></p>
                    <div class="form-input text-center" >
                        <span class="input-icon">
                            <i class="fa fa-user"></i>
                        </span>
                        <input class="input" type="text" name="name" placeholder="Full Name">
                        <span class="focus-input"></span>
                    </div>
                    <p class="red"><%= userError.getFullName()%></p>
                    <div class="form-input text-center" >
                        <span class="input-icon">
                            <i class="fa fa-phone"></i>
                        </span>
                        <input class="input" type="text" name="phoneNumber" placeholder="Phone Number (0xxxxxxxxx)">
                    </div>
                    <p class="red"><%= userError.getPhoneNumber() %></p>
                    <div class="form-input text-center" >
                        <span class="input-icon">
                            <i class="fa fa-envelope"></i>
                        </span>
                        <input class="input" type="text" name="email" placeholder="Email (your-email@example.com)">
                        <span class="focus-input"></span>
                    </div>
                    <p class="red"><%= userError.getEmail()%></p>
                    <div class="form-input text-center" >
                        <span class="input-icon">
                            <i class="fa fa-home"></i>
                        </span>
                        <input class="input" type="text" name="address" placeholder="Address (123 Main St, Anytown, USA)">
                        <span class="focus-input"></span>
                    </div>
                    <p class="red"><%= userError.getAddress() %></p>
                    <div class="form-input text-center">
                        <span class="input-icon">
                            <i class="fa fa-lock"></i>
                        </span>
                        <input id="pass" class="input" type="password" name="password" placeholder="Password">
                        <span class="focus-input"></span>
                    </div>
                    <p class="red" ></p>
                     <div class="form-input text-center">
                        <span class="input-icon">
                            <i class="fa fa-lock"></i>
                        </span>
                        <input id="re_pass" class="input" type="password" name="repassword" placeholder="Re Password" onkeyup="checkPass()">
                        <span class="focus-input"></span>
                    </div>
                    <p id="msg" class="red" ></p>
                    <div class="form-btn text-center">
                        <input class="button" type="submit" name="action" value="Register">
                    </div>
                    <div class="form-question d-flex justify-content-center">
                        <p>Bạn đã có tài khoản? </p>
                        <a href="login.jsp">
                            Đăng nhập ngay
                        </a>
                    </div>
                </form>

            </div>
        </div>
        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
            integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
        crossorigin="anonymous"></script>
        <script>
            function checkPass() {
                let pass = document.getElementById('pass').value;
                let re_pass = document.getElementById('re_pass').value;
                if (pass != re_pass) {
                    document.getElementById("msg").innerHTML = "*Mật khẩu không khớp!";
                    return false;
                } else {
                    document.getElementById("msg").innerHTML = "";
                    return true;
                }
            }
        </script>
    </body>
</html>
