<%-- 
    Document   : myWishList
    Created on : Jun 18, 2024, 9:55:06 AM
    Author     : PC
--%>

<%@page import="model.User"%>
<%@page import="database.WishListDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.WishList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
            crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
        <link href="css/index.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <section class=" h-custom" style="background-color: white">
            <div class="container-fluid py-5">
                <div class="row d-flex justify-content-center align-items-center ">
                    <div class="col-12">
                        <div class="h-100 card card-registration card-registration-2" style="border-radius: 15px" >
                            <div class="card-body p-0">
                                <div class="p-5">

                                    <div class="d-flex justify-content-between align-items-center mb-5" >
                                        <h2 class="cart-header-text fw-bold mb-0 text-black">
                                            Sản phẩm yêu thích
                                            <i style="color:red" class="fa-solid fa-heart"></i>
                                        </h2>
                                    </div>
                                    <hr class="my-4" />
                                    <%
                                        User loginUser = (User) session.getAttribute("LOGIN_USER");
                                        WishListDAO dao = new WishListDAO();
                                        List<WishList> wishList = dao.getWishList(loginUser.getUserId());
                                        if (wishList != null && !wishList.isEmpty()) {
                                            int count = 1;
                                            for (WishList product : wishList) {

                                    %>
                                    <form action="MainController">
                                        <div>
                                            <div class="row mb-4 d-flex justify-content-between align-items-center" >
                                                <div class="col-md-1 col-lg-2 col-xl-1">
                                                    <h6><%= count++%></h6>
                                                </div>
                                                <div class="col-md-2 col-lg-2 col-xl-2">
                                                    <img style="width: 120px; height: 80px;" src ="<%= product.getProduct().getImage()%>"  class="img-fluid rounded-3" alt="Cotton T-shirt"  />
                                                </div>
                                                <div class="col-md-3 col-lg-3 col-xl-3">
                                                    <h6 class="text-muted">
                                                        <%= product.getProduct().getProductName() + " " + product.getProduct().getDescription()%> 
                                                    </h6>
                                                </div>

                                                <div class="col-md-2 col-lg-2 col-xl-2 offset-lg-1">
                                                    <h5 class="mb-0">
                                                        <%= String.format("%,.0f", product.getProduct().getPrice()).replace(",", ".")%>
                                                    </h5>
                                                </div>
                                                <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                                                    <button class="btn btn-danger" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#<%= product.getProduct().getProductId()%>">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </button>
                                                    <div class="modal fade" id="<%= product.getProduct().getProductId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <div class="text-center modal-body">
                                                                    Bạn có muốn xóa khỏi giỏ hàng không
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    <form action="MainController">
                                                                        <input type="hidden" name="ID" value="<%= product.getProduct().getProductId()%>">
                                                                        <input class="btn btn-primary" type="submit" name="action" value="RemoveWL">
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </form>
                                    <hr class="my-4" />
                                    <%}%>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
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
