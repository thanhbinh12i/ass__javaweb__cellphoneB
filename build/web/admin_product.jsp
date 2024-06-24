<%-- 
    Document   : admin_product
    Created on : Jun 14, 2024, 11:44:22 PM
    Author     : PC
--%>

<%@page import="model.Product"%>
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
                            <a href="admin_product.jsp" class="nav-link active">
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
                            <a href="admin_invoice.jsp" class="nav-link link-dark">
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

            <div id="product" class="col-md-10 section active">
                <div class="form-container">
                    <form action="MainController">
                        <input class="search" type="text" name="search" placeholder="Search for Id or Name" value="<%= search%>"/>
                        <input id="searchProduct" class="btn btn-primary" type="submit" name="action" value="SearchProduct"/>
                    </form>
                </div>
                <div>
                    <%
                        String message = (String) request.getAttribute("MESSAGE");
                        if (message == null) {
                            message = "";
                        }
                    %>
                    <h5><%= message%></h5>
                </div>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Brand</th>
                            <th>Product Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Year</th>
                            <th>Quantity</th>
                            <th>Sale</th>
                            <th>Discount</th>
                            <th>Action</th>
                            <th>Update</th>

                        </tr>    
                    </thead>
                    <%
                        List<Product> listProduct = (List<Product>) request.getAttribute("LIST_Product");
                        if (listProduct != null) {
                    %> 
                    <%
                        int count = 1;
                        for (Product product : listProduct) {
                    %>
                    <form action="MainController" method="GET">
                        <tr>
                            <td class="td-hidden"><%= count++%></td>
                            <td class="td-hidden">
                                <%= product.getProductId()%>
                                <input type="hidden" name="ID" value="<%= product.getProductId()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <img src="<%= product.getImage()%>">
                                <input type="hidden" name="image" value="<%= product.getImage()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <%=  product.getBrand()%>
                                <input type="hidden" name="name" value="<%=  product.getBrand()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <%=  product.getProductName()%>
                                <input type="hidden" name="name" value="<%=  product.getProductName()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <%= product.getDescription()%>
                                <input type="hidden" name="description" value="<%= product.getDescription()%>" required=""/>
                            </td>
                            <td class="td-hidden">
                                <%=  product.getFormat()%>
                                <input type="hidden" name="price" value="<%=  product.getPrice()%>" required=""/>
                            </td>

                            <td class="td-hidden">
                                <%= product.getYearOfProduction()%>
                                <input type="hidden" name="year" value="<%= product.getYearOfProduction()%>" readonly=""/>
                            </td>
                            <td class="td-hidden">
                                <%= product.getQuantity()%>
                                <input type="hidden" name="quantity" value="<%= product.getQuantity()%>" required=""/>
                            </td>
                            <td class="td-hidden">
                                <%= product.getNotSale()%>
                                <input type="hidden" name="sale" value="<%= product.getNotSale()%>" required=""/>
                            </td>   
                            <td class="td-hidden">
                                <%= product.getDiscount()%>
                                <input type="hidden" name="discount" value="<%= product.getDiscount()%>" required=""/>
                            </td> 
                            <td class="td-button">
                                <button class="btn btn-primary" name="action" value="RemoveProduct">
                                    Delete
                                </button>
                            </td>
                            <td class="td-button">
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#<%= product.getProductId()%>">
                                    Update
                                </button>
                            </td>
                        </tr>
                    </form>
                    <%

                        }
                    %>
                </table>
            </div>
            <%
                for (Product product : listProduct) {
            %>
            <form action="MainController" method="GET">
                <div class="modal_update modal fade" id="<%= product.getProductId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Update <%=  product.getProductName()%></h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 row">
                                    <label for="ID" class="col-sm-3 col-form-label">ID: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="ID" value="<%= product.getProductId()%>" readonly=""/>

                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="brand" class="col-sm-3 col-form-label">ID: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="brand" value="<%= product.getBrand()%>" readonly=""/>

                                    </div>
                                </div> 
                                <div class="mb-3 row">
                                    <label for="name" class="col-sm-3 col-form-label">Name: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="name" value="<%=  product.getProductName()%>" readonly=""/>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="price" class="col-sm-3 col-form-label">Price: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="price" value="<%=  String.format("%.0f", product.getPrice())%>" required=""/>

                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="description" class="col-sm-3 col-form-label">Description: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="description" value="<%= product.getDescription()%>" required=""/>

                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="year" class="col-sm-3 col-form-label">Year: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="year" value="<%= product.getYearOfProduction()%>" readonly=""/>

                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="quantity" class="col-sm-3 col-form-label">Quantity: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="quantity" value="<%=product.getQuantity()%>" required=""/>

                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="sale" class="col-sm-3 col-form-label">Sale: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="sale" value="<%= product.getNotSale()%>" required=""/>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="discount" class="col-sm-3 col-form-label">Discount: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="discount" value="<%= product.getDiscount()%>" required=""/>
                                    </div>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <input type="hidden" name="image" value="<%= product.getImage()%>" readonly=""/>
                                <input class="button" type="submit" name="action" value="UpdateProduct" />
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <%
                    }
                }
            %>

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
