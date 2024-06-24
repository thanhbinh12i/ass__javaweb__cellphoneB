<%-- 
    Document   : checkout.jsp
    Created on : Jun 16, 2024, 1:53:59 PM
    Author     : PC
--%>

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
        <div class="success-container">
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                <h1>Thanh toán thành công!</h1>
                <p>Cảm ơn bạn đã tin tưởng và mua hàng tại CellPhoneB.</p>
                <a href="index.jsp" class="btn-home"><i class="fa-solid fa-house"></i> Quay lại trang chủ</a>
            </div>
        </div>
    </body>
</html>
