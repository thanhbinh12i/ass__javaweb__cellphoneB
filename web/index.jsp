<%-- 
    Document   : index.jsp
    Created on : Jun 10, 2024, 10:27:15 PM
    Author     : PC
--%>

<%@page import="model.Product"%>
<%@page import="database.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cellphone B</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
            crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
        <!-- OWL CAROUSEL -->
        <link href="css/owl.carousel.min.css" rel="stylesheet" >
        <link href="css/owl.theme.default.min.css" rel="stylesheet" >

        <link href="css/index.css" rel="stylesheet">

    </head>
    <body>
        <jsp:include page="header.jsp" />
        <section class="carousel">
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="./img/banner-1.jpg" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item">
                        <img src="./img/banner-2.jpg" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item">
                        <img src="./img/banner-3.jpg" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item">
                        <img src="./img/banner-4.png" class="d-block w-100" alt="...">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </section>
        <h1 class="pt-4 text-center">Sản phẩm nổi bật</h1>
        <!--Product-->

        <section class="product mt-4">
            <div id="hotsale" class="hotsale__content">
                <div class="product__header">
                    <h2 style="color: red"><img style="width: 80px" src="img/hotsale.jpg">  Khuyến mãi Hot</h2>
                    <a href="shop.jsp"><i class="fa fa-eye"></i> Xem tất cả</a>
                </div>
                <%
                    ProductDAO dao = new ProductDAO();
                    List<Product> listHotSale = dao.getListProductSQL("select top 8 * from tbl_Product order by discount desc");

                    if (listHotSale != null && !listHotSale.isEmpty()) {
                %>
                <div class="owl-carousel owl-theme product__carousel">
                    <% for (Product product : listHotSale) {%>
                    <div class="card" style="width: 18rem;">
                        <img src="<%= product.getImage()%>" class="card-img-top" alt="...">

                        <div class="card-body">
                            <h5 class="card-title"><%= product.getProductName() + " " + product.getDescription()%></h5>

                            <%
                                if (product.getDiscount() > 0) {
                                    double price = product.getPrice();
                                    double newPrice = price * (100 - product.getDiscount()) / 100;
                            %>
                            <div class="card-percent">
                                <p>Sale <%= product.getDiscount()%> %</p>
                            </div>
                            <div class="card-price">
                                <span class="price"><%= product.getFormat()%></span>
                                <span class="price-sale"><%= product.formatNumber(newPrice)%></span>
                            </div>
                            <% } else {%>
                            <div class="card-price">
                                <span><%= product.getFormat()%></span>
                            </div>
                            <% }%>
                            <div class="card-rating d-flex justify-content-between">
                                <span class="pt-1 card-stars">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </span>
                                <span class="card-wishlist">
                                    <a style="color: red" href="#" class="btn btn-wishlist"><i class="fa-solid fa-heart"></i> Yêu thích</a>
                                </span>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                <%
                    }
                %>

            </div>
            <div id="product" class="phone__content">
                <div class="product__header">
                    <h2>Điện thoại nổi bật  </h2>
                    <a href="shop.jsp"><i class="fa fa-eye"></i> Xem tất cả</a>
                </div>
                <%
                    
                    List<Product> listIphone = dao.getListProductSQL("select top 8 * from tbl_Product");

                    if (listIphone != null && !listIphone.isEmpty()) {
                %>
                <div class="owl-carousel owl-theme product__carousel">
                    <% for (Product product : listIphone) {%>
                    <div class="card" style="width: 18rem;">

                        <img src="<%= product.getImage()%>" class="card-img-top" alt="...">


                        <div class="card-body">
                            <h5 class="card-title"><%= product.getProductName() + " " + product.getDescription()%></h5>

                            <%
                                if (product.getDiscount() > 0) {
                                    double price = product.getPrice();
                                    double newPrice = price * (100 - product.getDiscount()) / 100;
                            %>
                            <div class="card-percent">
                                <p>Sale <%= product.getDiscount()%> %</p>
                            </div>
                            <div class="card-price">
                                <span class="price"><%= product.getFormat()%></span>
                                <span class="price-sale"><%= product.formatNumber(newPrice)%></span>
                            </div>
                            <% } else {%>
                            <div class="card-price">
                                <span><%= product.getFormat()%></span>
                            </div>
                            <% }%>
                            <div class="card-rating d-flex justify-content-between">
                                <span class="pt-1 card-stars">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </span>
                                <span class="card-wishlist">
                                    <a style="color: red" href="#" class="btn btn-wishlist"><i class="fa-solid fa-heart"></i> Yêu thích</a>
                                </span>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                <%
                    }
                %>
            </div>    


            <div id="limited" class="limited__content">
                <div class="product__header">
                    <h2>Sản phẩm độc quyền</h2>
                    <a href="shop.jsp"><i class="fa fa-eye"></i> Xem tất cả</a>
                </div>
                <%
                    List<Product> listLimited = dao.getListProductSQL("SELECT * FROM tbl_Product where description like N'%Chỉ có tại CellPhoneB%'");

                    if (listLimited != null && !listLimited.isEmpty()) {
                %>
                <div class="owl-carousel owl-theme product__carousel">
                    <% for (Product product : listLimited) {%>
                    <div class="card" style="width: 18rem;">
                        <img src="<%= product.getImage()%>" class="card-img-top" alt="...">

                        <div class="card-body">
                            <h5 class="card-title"><%= product.getProductName() + " " + product.getDescription()%></h5>

                            <%
                                if (product.getDiscount() > 0) {
                                    double price = product.getPrice();
                                    double newPrice = price * (100 - product.getDiscount()) / 100;
                            %>
                            <div class="card-percent">
                                <p>Sale <%= product.getDiscount()%> %</p>
                            </div>
                            <div class="card-price">
                                <span class="price"><%= product.getFormat()%></span>
                                <span class="price-sale"><%= product.formatNumber(newPrice)%></span>
                            </div>
                            <% } else {%>
                            <div class="card-price">
                                <span><%= product.getFormat()%></span>
                            </div>
                            <% }%>
                            <div class="card-rating d-flex justify-content-between">
                                <span class="pt-1 card-stars">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </span>
                                <span class="card-wishlist">
                                    <a style="color: red" class="btn btn-wishlist"><i class="fa-solid fa-heart"></i> Yêu thích</a>
                                </span>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                <%
                    }
                %>

            </div>
        </section>
        <section class="contact"></section>
            <jsp:include page="footer.jsp" />
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

        <!-- OWL CAROUSEL -->
        <script src="js/owl.carousel.min.js"></script>
        <script>
            $('.product__carousel').owlCarousel({
                loop: true,
                margin: 15,
                nav: true,
                dots: false,
                responsive: {
                    1000: {
                        items: 5,
                        margin: 5
                    }
                }
            })

        </script>
    </body>
</html>
