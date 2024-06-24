<%-- 
    Document   : dangnhap.jsp
    Created on : May 11, 2024, 9:12:59 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign In Page</title>
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
            String error = (String) request.getAttribute("ERROR");
            if (error == null) {
                error = "";
            }
        %>
        <div class="container form-body">
            <div class="container form"> 
                <form action="MainController" class="form" method="POST"> 
                    <img src="img/logoLogin.png">
                    <span class="form-title text-center">
                        Đăng nhập
                    </span>
                    <div class="form-input text-center" >
                        <span class="input-icon">
                            <i class="fa fa-user"></i>
                        </span>
                        <input class="input" type="text" name="userId" placeholder="User ID">
                        <span class="focus-input"></span>
                    </div>
                    <div class="form-input text-center">
                        <span class="input-icon">
                            <i class="fa fa-lock"></i>
                        </span>
                        <input class="input" type="password" name="password" placeholder="Password">
                        <span class="focus-input"></span>
                    </div>
                    <div class="form-btn text-center">
                        <input class="button" type="submit" name="action" value="Login">
                    </div>
                    <div class="form-question d-flex justify-content-center">
                        <p>Bạn chưa có tài khoản? </p>
                        <a href="register.jsp">
                            Đăng ký ngay
                        </a>
                    </div>

                </form>
                <h6 class="red"><%= "*" + error%></h6>
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
    </body>
</html>
