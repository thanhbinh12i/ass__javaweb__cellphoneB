<%-- 
    Document   : header
    Created on : May 26, 2024, 2:55:57 PM
    Author     : PC
--%>

<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
        <link href="css/index.css" rel="stylesheet">
    </head>
    <body>
        <%
            Object obj = session.getAttribute("LOGIN_USER");
            User loginUser = null;
            if (obj != null) {
                loginUser = (User) obj;
            }
        %>
        <!-- Navbar -->
        <div class="header">
            <nav class="navbar navbar-expand-lg bg-light">
                <div class="container-fluid row ">
                    <button class="navbar-toggler" type="button"
                            data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                            aria-controls="navbarSupportedContent" aria-expanded="false"
                            aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="col-md-9">
                        <div class="myNavBar__left">
                            <a class="navbar-brand me-0" href="index.jsp">
                                <img class="logo" src="img/cellphoneb.jpg" alt="">
                            </a>
                            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                                <ul class="navbar-nav">
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" href="index.jsp">Trang chủ</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" href="shop.jsp">Cửa hàng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" href="#contact">Liên hệ</a>
                                    </li>
                                </ul>
                            </div>
                            <%
                                String search = request.getParameter("search");
                                if (search == null) {
                                    search = "";
                                }
                            %>
                            <form action="MainController" class="myNavBar__form-search">

                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm" name="search" value="<%= search%>">
                                    <span class="input-group-text" id="basic-addon2">
                                        <button name="action" value="TimKiem">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                    <%

                        if (loginUser == null) {
                    %>
                    <div class="col-md-3 row collapse navbar-collapse" id="navbarSupportedContent">
                        <form class="myNavBar__right" style="">
                            <ul class="navbar-nav mb-2 mb-lg-0">
                                <li class="nav-item myNavBar__button">
                                    <a class="btn button--red" style="white-space: nowrap;" href="login.jsp">
                                        Đăng nhập
                                    </a>
                                    <a class="btn button--white" style="white-space: nowrap;" href="register.jsp">
                                        Đăng ký
                                    </a>
                                </li>
                            </ul>
                        </form>
                    </div>
                    <%} else {%>
                    <div class="col-md-3 row collapse navbar-collapse" id="navbarSupportedContent">
                        <form class="myNavBar__right" style="">
                            <%

                                if (loginUser.getRole().equals("US")) {
                            %>
                            <ul class="navbar-nav mb-2 mb-lg-0">
                                <li class="nav-item myNavBar__cart">
                                    <a class="nav-link" href="cart.jsp">
                                        <i class="fa fa-shopping-cart"></i>
                                    </a>
                                </li>
                                <ul class="myNavBar_user navbar-nav me-auto mb-2 mb-lg-0 bg-infor ">
                                    <li class="nav-item dropdown dropstart">
                                        <a
                                            class="nav-link dropdown-toggle" href="#" role="button"
                                            data-bs-toggle="dropdown" aria-expanded="false"> 
                                            <img style="width: 50px; height: 50px" src="img/admin.jpg">
                                            <span><%= loginUser.getFullName()%></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="myWishList.jsp">Sản phẩm yêu thích</a></li>
                                            <li><a class="dropdown-item" href="myorder.jsp">Đơn hàng của tôi</a></li>
                                            <li><a class="dropdown-item" href="changeInfoUser.jsp">Thay đổi thông tin</a></li>
                                            <li><a class="dropdown-item" href="changePassword.jsp">Đổi mật khẩu</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="LogoutController">Thoát tài khoản</a></li>
                                        </ul></li>
                                </ul>				


                            </ul>
                            <% } else if ((loginUser.getRole().equals("AD"))) {%>
                            <ul class="navbar-nav mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a class="nav-link" href="admin.jsp">
                                        ADMIN MANAGER
                                    </a>
                                </li>
                                <ul class="myNavBar_user navbar-nav me-auto mb-2 mb-lg-0 bg-infor ">
                                    <li class="nav-item dropdown dropstart">
                                        <a
                                            class="nav-link dropdown-toggle" href="#" role="button"
                                            data-bs-toggle="dropdown" aria-expanded="false"> 
                                            <img style="width: 50px; height: 50px" src="img/admin.jpg">
                                            <span><%= loginUser.getFullName()%></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="changePassword.jsp">Đổi mật khẩu</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="LogoutController">Thoát tài khoản</a></li>
                                        </ul></li>
                                </ul>
                                <% }%>
                        </form>
                    </div>
                    <% }%>
                </div>
            </nav>
            <!-- End Navbar -->
            <nav id="headerFixed" class="navbar navbar-expand-lg bg-light">
                <div class="container-fluid row ">
                    <button class="navbar-toggler" type="button"
                            data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                            aria-controls="navbarSupportedContent" aria-expanded="false"
                            aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="col-md-9">
                        <div class="myNavBar__left">
                            <a class="navbar-brand me-0" href="#">
                                <img class="logo" src="img/cellphoneb.jpg" alt="">
                            </a>
                            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                                <ul class="navbar-nav">
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" href="index.jsp">Trang chủ</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" href="shop.jsp">Cửa hàng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" href="#contact">Liên hệ</a>
                                    </li>
                                </ul>
                            </div>
                            <%
                                if (search == null) {
                                    search = "";
                                }
                            %>
                            <form action="MainController" class="myNavBar__form-search">

                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm" name="search" value="<%= search%>">
                                    <span class="input-group-text" id="basic-addon2">
                                        <button name="action" value="TimKiem">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                    <%

                        if (loginUser == null) {
                    %>
                    <div class="col-md-3 row collapse navbar-collapse" id="navbarSupportedContent">
                        <form class="myNavBar__right" style="">
                            <ul class="navbar-nav mb-2 mb-lg-0">
                                <li class="nav-item myNavBar__button">
                                    <a class="btn button--red" style="white-space: nowrap;" href="login.jsp">
                                        Đăng nhập
                                    </a>
                                    <a class="btn button--white" style="white-space: nowrap;" href="register.jsp">
                                        Đăng ký
                                    </a>
                                </li>
                            </ul>
                        </form>
                    </div>
                    <%} else {%>
                    <div class="col-md-3 row collapse navbar-collapse" id="navbarSupportedContent">
                        <form class="myNavBar__right" style="">
                            <%

                                if (loginUser.getRole().equals("US")) {
                            %>
                            <ul class="navbar-nav mb-2 mb-lg-0">
                                <li class="nav-item myNavBar__cart">
                                    <a class="nav-link" href="cart.jsp">
                                        <i class="fa fa-shopping-cart"></i>
                                    </a>
                                </li>
                                <ul class="myNavBar_user navbar-nav me-auto mb-2 mb-lg-0 bg-infor ">
                                    <li class="nav-item dropdown dropstart">
                                        <a
                                            class="nav-link dropdown-toggle" href="#" role="button"
                                            data-bs-toggle="dropdown" aria-expanded="false"> 
                                            <img style="width: 50px; height: 50px" src="img/admin.jpg">
                                            <span><%= loginUser.getFullName()%></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="myWishList.jsp">Sản phẩm yêu thích</a></li>
                                            <li><a class="dropdown-item" href="myorder.jsp">Đơn hàng của tôi</a></li>
                                            <li><a class="dropdown-item" href="changeInfoUser.jsp">Thay đổi thông tin</a></li>
                                            <li><a class="dropdown-item" href="changePassword.jsp">Đổi mật khẩu</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="LogoutController">Thoát tài khoản</a></li>
                                        </ul></li>
                                </ul>				


                            </ul>
                            <% } else if ((loginUser.getRole().equals("AD"))) {%>
                            <ul class="navbar-nav mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a class="nav-link" href="admin.jsp">
                                        ADMIN MANAGER
                                    </a>
                                </li>
                                <ul class="myNavBar_user navbar-nav me-auto mb-2 mb-lg-0 bg-infor ">
                                    <li class="nav-item dropdown dropstart">
                                        <a
                                            class="nav-link dropdown-toggle" href="#" role="button"
                                            data-bs-toggle="dropdown" aria-expanded="false"> 
                                            <img style="width: 50px; height: 50px" src="img/admin.jpg">
                                            <span><%= loginUser.getFullName()%></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="changePassword.jsp">Đổi mật khẩu</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="LogoutController">Thoát tài khoản</a></li>
                                        </ul></li>
                                </ul>
                                <% }%>
                        </form>
                    </div>
                    <% }%>
                </div>
            </nav>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
                integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
            integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
        crossorigin="anonymous"></script>


        <script>
            window.onscroll = function () {
                if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
                    document.getElementById("headerFixed").style.transform = "translate(0, 0)";
                } else {
                    document.getElementById("headerFixed").style.transform = "translate(0, -100%)";
                }
            }
        </script>
    </body>
</html>
