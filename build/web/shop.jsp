<%-- 
    Document   : phone.jsp
    Created on : Jun 13, 2024, 7:18:49 AM
    Author     : PC
--%>

<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page import="database.ProductDAO"%>
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
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div id="product" class="product__content">
            <%
                int pageSize = 12;
                int currentPage = 1;
                if (request.getParameter("page") != null) {
                    currentPage = Integer.parseInt(request.getParameter("page"));
                }

                List<Product> listProduct = (List<Product>) request.getAttribute("LIST_SearchProduct");
                String[] selectedBrand = (String[]) request.getAttribute("selectedBrands");
                String[] selectedPrice = (String[]) request.getAttribute("selectedPrices");
                if (listProduct == null) {
                    ProductDAO dao = new ProductDAO();
                    listProduct = dao.getListProduct();
                }

                int totalProducts = listProduct.size();
                int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
                int start = (currentPage - 1) * pageSize;
                int end = Math.min(start + pageSize, totalProducts);

                if (listProduct != null && !listProduct.isEmpty()) {
            %>
            <div class="row">
                <div class="col-md-2 filter-form">
                    <form action="MainController">
                        <h3 class="pt-4 ps-3">Thương hiệu</h3>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="brand" id="allBrands" value="allBrands">
                            <label class="form-check-label" for="allBrands">
                                All
                            </label>
                        </div>
                        <%
                            ProductDAO dao = new ProductDAO();
                            List<String> listBrand = dao.getBrands();
                            for (String brand : listBrand) {
                        %>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="brand" id="brand_<%= brand%>" value="<%= brand%>"
                                   >
                            <label class="form-check-label" for="brand_<%= brand%>">
                                <%= brand%>
                            </label>
                        </div>
                        <%}%>
                        <h3 class="ps-3">Theo giá</h3>
                        <%
                            Map<String, String> priceRanges = new LinkedHashMap<>();
                            priceRanges.put("1-5", "Từ 1 đến 5 triệu");
                            priceRanges.put("5-10", "Từ 5 đến 10 triệu");
                            priceRanges.put("10-20", "Từ 10 đến 20 triệu");
                            priceRanges.put("20-100", "Trên 20 triệu");

                            // Lặp qua từng mức giá để tạo checkbox
                            for (Map.Entry<String, String> entry : priceRanges.entrySet()) {
                                String value = entry.getKey();
                                String label = entry.getValue();
                        %>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="filterprice" id="filterprice_<%= value%>" value="<%= value%>">
                            <label class="form-check-label" for="filterprice_<%= value%>">
                                <%= label%>
                            </label>
                        </div>
                        <% }%>

                        <button class="btn--search button--red" name="action" value="searchByBrand">
                            Tìm
                        </button>

                    </form>
                </div>
                <div class="col-md-10">
                    <h1 style="color: red;padding-left: 10px;"><%= listProduct.size()%> sản phẩm</h1>
                    <div class="card-list">
                        <% for (int i = start; i < end; i++) {
                                Product mobile = listProduct.get(i);%>
                        <div class="card" style="width: 18rem;">
                            <img src="<%= mobile.getImage()%>" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title"><%= mobile.getProductName() + " " + mobile.getDescription()%></h5>
                                <%
                                    if (mobile.getNotSale() == 0) {
                                        if (mobile.getDiscount() > 0) {
                                            double price = mobile.getPrice();
                                            double newPrice = price * (100 - mobile.getDiscount()) / 100;
                                %>
                                <div class="card-percent">
                                    <p>Sale <%= mobile.getDiscount()%> %</p>
                                </div>
                                <div class="card-price">
                                    <span class="price"><%= mobile.getFormat()%></span>
                                    <span class="price-sale"><%= mobile.formatNumber(newPrice)%></span>
                                </div>
                                <% } else {%>
                                <div class="card-price">
                                    <span><%= mobile.getFormat()%></span>
                                </div>
                                <% }%>
                                <form action="MainController">
                                    <div id="cartButtons" class="card-cart">
                                        <input type="hidden" name="ID" value="<%= mobile.getProductId()%>" readonly="" />
                                        <input type="hidden" name="image" value="<%= mobile.getImage()%>" readonly="" />
                                        <input type="hidden" name="brand" value="<%= mobile.getBrand()%>" readonly="" />
                                        <input type="hidden" name="name" value="<%= mobile.getProductName()%>" readonly="" />
                                        <input type="hidden" name="description" value="<%= mobile.getDescription()%>" readonly="" />
                                        <input type="hidden" name="price" value="<%= mobile.getPrice() * (100 - mobile.getDiscount()) / 100%>" readonly="" />
                                        <input type="hidden" name="year" value="<%= mobile.getYearOfProduction()%>" readonly="" />
                                        <input type="hidden" name="quantity" value="<%= mobile.getQuantity()%>" readonly="" />
                                        <input type="hidden" name="sale" value="<%= mobile.getNotSale()%>" readonly="" />
                                        <input type="hidden" name="discount" value="<%= mobile.getDiscount()%>" readonly="" />
                                        <button class="btn btn-primary" name="action" value="Add To Cart" onclick="handleSuccess(), handleError()">
                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                        </button>

                                        <span>Còn <%= mobile.getQuantity()%> </span>
                                    </div>
                                </form>
                                <% } else if (mobile.getNotSale() == 1) { %>
                                <div class="card-notice d-flex justify-content-between">
                                    <p>Sắp về hàng</p>
                                    <p>Giá liên hệ</p>
                                </div>
                                <% } else if (mobile.getNotSale() == 2) { %>
                                <div class="card-notice">
                                    <p>Hết hàng</p>
                                </div>
                                <% }%>
                                <div class="pt-1 card-rating d-flex justify-content-between">
                                    <span class="pt-1 card-stars">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </span>
                                    <span class="card-wishlist">
                                        <a href="MainController?ID=<%= mobile.getProductId()%>&action=AddToWishList" class="btn btn-wishlist"
                                           onclick="handleError()">
                                            <i class="fa-solid fa-heart"></i> Yêu thích
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <% }%>

                    </div>

                </div>
                <%
                    String error = (String) request.getAttribute("ERROR");
                    String success = (String) request.getAttribute("MESSAGE");
                    if (error == null) {
                        error = "";
                    }
                    if (success == null) {
                        success = "";
                    }
                %>
                <input id="error" type="hidden" value="<%=error%>">

                <div id="error-modal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
                    <div style="background-color: white; padding: 20px; border-radius: 5px; text-align: center; max-width: 400px; width: 80%;">
                        <h4 id="error-message" style="color: red; margin-top: 10px"></h4>
                        <br>
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
                        <hr>
                        <button class="btn btn-danger" onclick="closeErrorModal()">Close</button>
                    </div>
                </div>  
                <input id="success" type="hidden" value="<%= success %>">
                <div id="success-modal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
                    <div style="background-color: white; padding: 20px; border-radius: 5px; text-align: center; max-width: 400px; width: 80%;">
                        <h4 id="success-message" style="color: red; margin-top: 10px"></h4>
                        <br>
                        <button class="btn btn-danger" onclick="closeSuccessModal()">Close</button>
                    </div>
                </div>  
                <form action="MainController">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <li class="page-item <%= (currentPage == 1) ? "disabled" : ""%>">
                                <a class="page-link" href="?page=<%= currentPage - 1%><%= selectedBrand != null ? "&brand=" + selectedBrand : ""%><%= selectedPrice != null ? "&filterprice=" + selectedPrice : ""%>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <% for (int i = 1; i <= totalPages; i++) {%>
                            <li class="page-item <%= (i == currentPage) ? "active" : ""%>">
                                <a class="page-link" href="?page=<%= i%><%= selectedBrand != null ? "&brand=" + selectedBrand : ""%><%= selectedPrice != null ? "&filterprice=" + selectedPrice : ""%>"><%= i%></a>
                            </li>
                            <% }%>
                            <li class="page-item <%= (currentPage == totalPages || totalPages == 0) ? "disabled" : ""%>">
                                <a class="page-link" href="?page=<%= currentPage + 1%><%= selectedBrand != null ? "&brand=" + selectedBrand : ""%><%= selectedPrice != null ? "&filterprice=" + selectedPrice : ""%>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </form>

            </div>
            <% }%>
        </div>

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
        <script>
                            function handleSuccess() {
                                var success = document.getElementById("success").value;
                                if (success) {
                                    var successMessageDiv = document.getElementById("success-message");
                                    successMessageDiv.innerText = error;
                                    var successModal = document.getElementById("success-modal");
                                    successModal.style.display = "flex";
                                } else {
                                    document.getElementById("cart-form").submit();
                                }
                            }
                            function handleError() {
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
                            function closeSuccessModal() {
                                var errorModal = document.getElementById("success-modal");
                                errorModal.style.display = "none";
                            }

                            window.onload = function () {
                                var error = document.getElementById("error").value;
                                var success = document.getElementById("success").value;
                                if (error) {
                                    var errorMessageDiv = document.getElementById("error-message");
                                    errorMessageDiv.innerText = error;
                                    var errorModal = document.getElementById("error-modal");
                                    errorModal.style.display = "flex";
                                }else if(success){
                                    var successMessageDiv = document.getElementById("success-message");
                                    successMessageDiv.innerText = success;
                                    var successModal = document.getElementById("success-modal");
                                    successModal.style.display = "flex";
                                }
                            }
        </script>
    </body>
</html>
