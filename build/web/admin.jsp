<%-- 
    Document   : admin.jsp
    Created on : Jun 10, 2024, 10:45:14 PM
    Author     : PC
--%>

<%@page import="model.Product"%>
<%@page import="java.util.List"%>
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
        <link href="css/admin.css" rel="stylesheet">
    </head>
    <body>

        <div class="main row">
            <div class="col-md-2 sidebar">
                <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="height: 100vh">
                    <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
                        <svg class="bi me-2" width="40" height="32"><img src="img/admin.jpg"></svg>
                        <span class="fs-4">Admin</span>
                    </a>
                    <hr>
                    <ul class="nav nav-pills flex-column mb-auto">
                        <li class="nav-item">
                            <a href="#user" class="nav-link active" aria-current="page">
                                <svg class="bi" width="16" height="16"><use xlink:href="#user"/></svg>
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

            <div id="user" class="col-md-10 section active">
                <div class="form-container">
                    <form action="MainController">
                        <input class="search" type="text" name="search" placeholder="Search for Id or Name" value="<%= search%>"/>
                        <input id="search" class="btn btn-primary" type="submit" name="action" value="Search"/>
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
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Role ID</th>
                            <th>Password</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Delete</th>
                            <th>Update</th>
                        </tr>   
                    </thead>
                    <%
                        Object obj = session.getAttribute("LOGIN_USER");
                        User loginUser = null;
                        if (obj != null) {
                            loginUser = (User) obj;
                        }
                        List<User> listUser = (List) request.getAttribute("LIST_USER");
                        if (listUser != null) {
                    %>
                    <%
                        int count = 1;
                        for (User user : listUser) {
                    %>
                    <form action="MainController" method="GET">
                        <tr>
                            <td class="td-hidden"><%= count++%></td>
                            <td class="td-hidden">
                                <%= user.getUserId()%>
                                <input type="hidden" name="userID" value="<%= user.getUserId()%>" readonly=""/>
                            </td >
                            <td class="td-hidden">
                                <%= user.getFullName()%>
                                <input type="hidden" name="fullName" value="<%= user.getFullName()%>" required=""/>
                            </td>
                            <td class="td-hidden">
                                <%= user.getRole()%>
                                <input type="hidden" name="role" value="<%= user.getRole()%>" required=""/>
                            </td>
                            <td class="td-hidden"><%= user.getPassword()%></td>
                            <td class="td-hidden">
                                <%= user.getPhoneNumber()%>
                                <input type="hidden" name="phoneNumber" value="<%= user.getPhoneNumber()%>" required=""/>
                            </td >
                            <td class="td-hidden">
                                <%= user.getEmail()%>
                                <input type="hidden" name="email" value="<%= user.getEmail()%>" required=""/>
                            </td>
                            <td class="td-hidden">
                                <%= user.getAddress()%>
                                <input type="hidden" name="address" value="<%= user.getAddress()%>" required=""/>
                            </td>
                            <%
                                if (!loginUser.getUserId().equals((user.getUserId()))) {
                            %>
                            <td class="td-button">
                                <a href="MainController?userID=<%= user.getUserId()%>&action=RemoveUser&search=<%= search%>"><i class="fa-solid fa-trash-can"></i></a>
                            </td>
                            <td class="td-button">
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#<%= user.getUserId()%>">
                                    Update
                                </button>
                            </td>
                            <%}%>   
                        </tr>
                    </form>
                    <%
                        }
                    %>
                </table>
            </div>
            <%
                for (User user : listUser) {
            %>
            <form action="MainController" method="GET">
                <div class="modal fade" id="<%= user.getUserId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Update <%=  user.getFullName()%></h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 row">
                                    <label for="userId" class="col-sm-3 col-form-label">ID: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="userId" value="<%= user.getUserId()%>" readonly=""/>

                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="fullName" class="col-sm-3 col-form-label">FullName: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="fullName" value="<%= user.getFullName()%>" readonly=""/>

                                    </div>
                                </div> 
                                <div class="mb-3 row">
                                    <label for="role" class="col-sm-3 col-form-label">Role: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="role" value="<%=  user.getRole()%>" readonly=""/>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="password" class="col-sm-3 col-form-label">Password: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="password" value="<%=  user.getPassword()%>" readonly=""/>

                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="phoneNumber" class="col-sm-3 col-form-label">PhoneNumber: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="phoneNumber" value="<%= user.getPhoneNumber()%>" required=""/>

                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="email" class="col-sm-3 col-form-label">Email: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="email" value="<%= user.getEmail()%>" required=""/>

                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="address" class="col-sm-3 col-form-label">Address: </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="address" value="<%=user.getAddress()%>" required=""/>

                                    </div>
                                </div>


                            </div>
                            <div class="modal-footer">
                                <input class="button" type="submit" name="action" value="UpdateUser" />
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
