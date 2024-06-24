<%-- 
    Document   : cart
    Created on : Jun 13, 2024, 12:01:37 AM
    Author     : PC
--%>

<%@page import="java.util.Random"%>
<%@page import="model.Product"%>
<%@page import="model.Cart"%>
<%@page import="java.util.List"%>
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

        <link href="css/index.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <section class=" h-custom" style="background-color: white">
            <div class="container py-5">
                <div class="row d-flex justify-content-center align-items-center ">
                    <div class="col-12">
                        <div class="h-100 card card-registration card-registration-2" style="border-radius: 15px" >
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <div class="col-lg-8">
                                        <div class="p-5">
                                            <div class="d-flex justify-content-between align-items-center mb-5" >
                                                <h1 class="cart-header-text fw-bold mb-0 text-black">
                                                    Giỏ Hàng
                                                </h1>
                                            </div>
                                            <hr class="my-4" />

                                            <%
                                                Cart cart = (Cart) session.getAttribute("CART");
                                                int count = 0;
                                                double total = 0;
                                                if (cart == null) {
                                            %>
                                            <div>
                                                <div class="text-center">
                                                    Bạn chưa có sản phẩm nào trong giỏ hàng.
                                                </div>
                                            </div>
                                            <%} else {%>
                                            <%

                                                for (Product product : cart.getCart().values()) {
                                                    total += product.getQuantity() * product.getPrice();
                                                    count++;
                                            %>
                                            <form action="MainController">
                                                <div>
                                                    <div class="row mb-4 d-flex justify-content-between align-items-center" >
                                                        <div class="col-md-2 col-lg-2 col-xl-2">
                                                            <img style="width: 50px; height: 50px;" src ="<%= product.getImage()%>"  class="img-fluid rounded-3" alt="Cotton T-shirt"  />
                                                        </div>
                                                        <div class="col-md-3 col-lg-3 col-xl-3">
                                                            <h6 class="text-muted">
                                                                <%=  product.getProductName()%>
                                                            </h6>
                                                        </div>
                                                        <div class="col-md-3 col-lg-3 col-xl-2 ">
                                                            <div>
                                                                <p>
                                                                    <input type="hidden" name="ID" value="<%= product.getProductId()%>">
                                                                    <input type="hidden" name="num" value="num">

                                                                    <button type="submit" name="action" value="cartminus" class="button_mp">
                                                                        <input type="hidden" name="up" value="minus">
                                                                        <i class="fa-solid fa-minus"></i>
                                                                    </button>
                                                                    <%= product.getQuantity()%>
                                                                    <button type="submit" name="action" value="cartplus" class="button_mp" onclick="handleCartPlus()">
                                                                        <input type="hidden" name="up" value="plus">
                                                                        <i class="fa-solid fa-plus"></i>
                                                                    </button>
                                                                </p>
                                                            </div>


                                                        </div>
                                                        <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                                                            <h6 class="mb-0">
                                                                <%= product.formatNumber(product.getQuantity() * product.getPrice())%>
                                                                đ
                                                            </h6>
                                                        </div>
                                                        <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                                            <button class="btn btn-danger" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#<%= product.getProductId()%>">
                                                                <i class="fa-solid fa-trash"></i>
                                                            </button>
                                                            <div class="modal fade" id="<%= product.getProductId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                                                                <input type="hidden" name="ID" value="<%= product.getProductId()%>">
                                                                                <input class="btn btn-primary" type="submit" name="action" value="Remove">
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

                                            <div class="pt-5">
                                                <h6 class="mb-0">
                                                    <a href="shop.jsp" class="text-body" >
                                                        <i class="fas fa-long-arrow-alt-left me-2"></i>Trở lại cửa hàng</a>
                                                </h6>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 bg-grey">
                                        <div class="p-5">
                                            <h3 class="fw-bold mb-5 mt-2 pt-1">Tóm lược</h3>
                                            <hr class="my-4" />

                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="text-uppercase">
                                                    <%= count%> sản phẩm
                                                </h5>
                                                <h5><%= String.format("%,.0f", total).replace(",", ".")%> đ</h5>
                                            </div>

                                            <hr class="my-4" />

                                            <div class="d-flex justify-content-between mb-5">
                                                <h5 class="text-uppercase">Tổng tiền</h5>
                                                <h5><%= String.format("%,.0f", total).replace(",", ".")%></h5>
                                            </div>
                                            <% if (cart != null) { %>
                                            <a class="btn btn-primary" href="order.jsp">Thanh toán</a>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%
            String error = (String) request.getAttribute("ERROR");
            if (error == null) {
                error = "";
            }
        %>
        <input id="error" type="hidden" value="<%=error%>">

        <!-- Modal for error message -->
        <div id="error-modal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
            <div style="background-color: white; padding: 20px; border-radius: 5px; text-align: center; max-width: 400px; width: 80%;">
                <h4 id="error-message" style="color: red; margin-top: 10px"></h4>
                <br>
                <button class="btn btn-danger" onclick="closeErrorModal()">Close</button>
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

                    function handleCartPlus() {
                        var error = document.getElementById("error").value;
                        if (error) {
                            var errorMessageDiv = document.getElementById("error-message");
                            errorMessageDiv.innerText = error;
                            var errorModal = document.getElementById("error-modal");
                            errorModal.style.display = "flex";
                        } else {
                            document.getElementById("cart-form").submit();
                        }
                    }

                    function closeErrorModal() {
                        var errorModal = document.getElementById("error-modal");
                        errorModal.style.display = "none";
                    }

                    window.onload = function () {
                        var error = document.getElementById("error").value;
                        if (error) {
                            var errorMessageDiv = document.getElementById("error-message");
                            errorMessageDiv.innerText = error;
                            var errorModal = document.getElementById("error-modal");
                            errorModal.style.display = "flex";
                        }
                    }

        </script>

    </body>
</html>
