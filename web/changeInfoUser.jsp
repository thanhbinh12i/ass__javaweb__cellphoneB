<%-- 
    Document   : changeInfoUser
    Created on : Jun 14, 2024, 4:15:04 PM
    Author     : PC
--%>

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
        <link href="css/index.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <%
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            if (loginUser != null) {
        %>
        <form action="MainController">
            <div class="container">
                <div class="">

                    <h3>Thông tin khách hàng</h3>
                    <div class="mb-3">
                        <label for="userId" class="form-label">UserId</label> <input
                            type="text" class="form-control" id="userId" name="userId" value="<%=loginUser.getUserId()%>" readonly="">
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">Họ và tên</label> <input
                            type="text" class="form-control" id="name" name="name" value="<%=loginUser.getFullName()%>">
                    </div>
                    <input type="hidden" name="role" value="<%=loginUser.getRole()%>">
                    <input type="hidden" name="password" value="<%=loginUser.getPassword()%>">
                    <div class="mb-3">
                        <label for="address" class="form-label">Địa chỉ</label> 
                        <input type="text" class="form-control" id="address" name="address" value="<%= loginUser.getAddress()%>">
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label">Điện thoại</label> <input
                            type="tel" class="form-control" id="phone" name="phone" value="<%= loginUser.getPhoneNumber()%>">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label> <input
                            type="email" class="form-control" id="email" name="email"  value="<%= loginUser.getEmail()%>">
                    </div>
                    <hr />					
                    <input class="btn btn-primary form-control" type="submit"
                           value="Lưu thông tin" name="action" id="submit" />
                </div>
            </div>
        </form>
        <%}%>
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
