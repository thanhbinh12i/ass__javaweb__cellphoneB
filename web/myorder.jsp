<%-- 
    Document   : myorder.jsp
    Created on : Jun 16, 2024, 11:01:59 AM
    Author     : PC
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.OrderDetail"%>
<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page import="database.OrderDAO"%>
<%@page import="model.User"%>
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
                                            Đơn hàng của tôi    <i class="fa fa-shopping-cart"></i>
                                        </h2>
                                    </div>
                                    <hr class="my-4" />
                                    <%
                                        User loginUser = (User) session.getAttribute("LOGIN_USER");
                                        int count = 1;
                                        OrderDAO dao = new OrderDAO();
                                        List<Order> listOrder = dao.getListOrder(loginUser.getUserId());


                                    %>



                                    <% for (Order order : listOrder) {%>
                                    <div class="row mb-4 d-flex justify-content-between align-items-center">
                                        <div class="col-md-1">
                                            <h6 class="mb-0"><%= count++%></h6>
                                        </div>
                                        <div class="col-md-2">
                                            <strong>ID: <%= order.getOrderId()%></strong>
                                        </div>
                                        <div class="col-md-3">
                                            <h6 class="text-muted mb-0">
                                                <%= order.getOrderDate()%> 
                                            </h6>
                                        </div>
                                        <div class="col-md-2">
                                            <h5 class="mb-0">
                                                Tổng tiền: <%= String.format("%,.0f", order.getTotalPrice()).replace(",", ".")%>
                                            </h5>
                                        </div>
                                        <div class="col-md-2">
                                            <h5 class="mb-0" style="color: green">Thành công</h5> 
                                        </div>
                                        <div class="col-md-2">
                                            <button type="button" class="btn btn-primary" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#modal_<%= order.getOrderId()%>">
                                                Chi tiết
                                            </button>
                                        </div>
                                    </div>


                                    <div class="modal fade" id="modal_<%= order.getOrderId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Chi tiết đơn hàng <%= order.getOrderId()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="mb-4">
                                                        <strong>ID đơn hàng: <%= order.getOrderId()%></strong>
                                                        <br>
                                                        Ngày đặt hàng: <%= order.getOrderDate()%>
                                                        <br>
                                                        Tổng tiền: <%= String.format("%,.0f", order.getTotalPrice()).replace(",", ".")%>
                                                        <br>
                                                        Trạng thái: <span style="color: green;">Thành công</span>
                                                    </div>


                                                    <% List<OrderDetail> listOrderDetail = dao.getListOrderDetail(order.getOrderId()); %>
                                                    <% if (listOrderDetail.isEmpty()) { %>
                                                    <div class="text-center">
                                                        <p>Không có chi tiết đơn hàng cho đơn hàng này.</p>
                                                    </div>
                                                    <% } else { %>
                                                    <table class="table table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Ảnh sản phẩm</th>
                                                                <th scope="col">Tên sản phẩm</th>
                                                                <th scope="col">Số lượng</th>
                                                                <th scope="col">Giá</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (OrderDetail od : listOrderDetail) {%>
                                                            <tr>
                                                                <td><img src="<%= od.getProduct().getImage()%>" style="width: 50px; height: 50px;"></td>
                                                                <td><%= od.getProduct().getProductName()%></td>
                                                                <td><%= od.getQuantity()%></td>
                                                                <td><%= String.format("%,.0f", od.getPrice()).replace(",", ".")%></td>
                                                            </tr>
                                                            <% } %>
                                                        </tbody>
                                                    </table>
                                                    <% } %>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <% }%>
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
