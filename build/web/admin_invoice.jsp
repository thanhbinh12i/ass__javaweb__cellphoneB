<%-- 
    Document   : admin_order
    Created on : Jun 14, 2024, 11:47:55 PM
    Author     : PC
--%>

<%@page import="model.Invoice"%>
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

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
        <link href="css/admin.css" rel="stylesheet">
    </head>
    <body>
        <div class="main row">
            <div class="col-md-2 sidebar">
                <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="height: 90vh">
                    <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
                        <svg class="bi me-2" width="40" height="32"><img src="img/admin.jpg"></svg>
                        <span class="fs-4">Admin</span>
                    </a>
                    <hr>
                    <ul class="nav nav-pills flex-column mb-auto">
                        <li class="nav-item">
                            <a href="admin.jsp" class="nav-link link-dark" aria-current="page">
                                <svg class="bi" width="16" height="16"><use xlink:href="admin.jsp"/></svg>
                                Danh sách người dùng
                            </a>
                        </li>
                        <li>
                            <a href="admin_product.jsp" class="nav-link link-dark">
                                <svg class="bi " width="16" height="16"><use xlink:href="admin_product.jsp"/></svg>
                                Danh sách sản phẩm
                            </a>
                        </li>
                        <li>
                            <a href="admin_addproduct.jsp" class="nav-link link-dark">
                                <svg class="bi " width="16" height="16"><use xlink:href="admin_addproduct.jsp"/></svg>
                                Thêm sản phẩm
                            </a>
                        </li>
                        <li>
                            <a href="admin_invoice.jsp" class="nav-link active">
                                <svg class="bi " width="16" height="16"><use xlink:href="admin_invoice.jsp"/></svg>
                                Hóa đơn
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="index.jsp" class="nav-link" aria-current="page">
                                <svg class="bi" width="16" height="16"><use xlink:href="index.jsp"/></svg>
                                Quay về trang chủ
                            </a>
                        </li>
                    </ul>            
                </div>
            </div>
            <%
                String search = request.getParameter("search");
                if (search == null) {
                    search = "";
                }
            %>
            <div id="invoice" class="col-md-10 section active">
                <div class="form-container">
                    <form action="MainController">
                        <input class="search" type="text" name="search" placeholder="Search for userId" value="<%= search%>"/>
                        <input id="searchProduct" class="btn btn-primary" type="submit" name="action" value="Show Invoice"/>
                    </form>
                </div>

                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Inv Id</th>
                            <th>UserId</th>
                            <th>OrderId</th>
                            <th>Full Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Date</th>
                            <th>Total Price</th>
                            <th>Method</th>
                        </tr>    
                    </thead>
                    <%
                        List<Invoice> listInvoice = (List<Invoice>) request.getAttribute("LIST_INVOICE");
                        if (listInvoice != null) {
                    %> 
                    <%
                        int count = 1;
                        for (Invoice invoice : listInvoice) {
                    %>
                    <form action="MainController" method="GET">
                        <tr>
                            <td class="td-hidden"><%= count++%></td>
                            <td class="td-hidden">
                                <%= invoice.getInvoiceId()%>
                                <input type="hidden" name="invId" value="<%= invoice.getInvoiceId()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <%= invoice.getUserId()%>
                                <input type="hidden" name="userId" value="<%= invoice.getUserId()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <%=  invoice.getOrderId()%>
                                <input type="hidden" name="orderId" value="<%=  invoice.getOrderId()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <%=  invoice.getFullName()%>
                                <input type="hidden" name="name" value="<%=  invoice.getFullName()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <%= invoice.getPhoneNumber()%>
                                <input type="hidden" name="phone" value="<%= invoice.getPhoneNumber()%>" required=""/>
                            </td>
                            <td class="td-hidden">
                                <%=  invoice.getEmail()%>
                                <input type="hidden" name="email" value="<%=  invoice.getEmail()%>" required=""/>
                            </td>

                            <td class="td-hidden">
                                <%= invoice.getAddress()%>
                                <input type="hidden" name="address" value="<%= invoice.getAddress()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <%=invoice.getDate()%>
                                <input type="hidden" name="date" value="<%= invoice.getDate()%>" required=""/>
                            </td>
                            <td class="td-hidden">
                                <%=  String.format("%,.0f", invoice.getTotalPrice()).replace(",", ".")%>
                                <input type="hidden" name="price" value="<%= invoice.getTotalPrice()%>" required=""/>
                            </td>   
                            <td class="td-hidden">
                                <%= invoice.getMethod()%>
                                <input type="hidden" name="method" value="<%= invoice.getMethod()%>" required=""/>
                            </td> 
                        </tr>
                    </form>
                    <%
                            }
                        }
                    %>
                </table>
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
