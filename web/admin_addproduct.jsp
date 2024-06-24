<%-- 
    Document   : admin_addproduct
    Created on : Jun 15, 2024, 9:00:48 PM
    Author     : PC
--%>

<%@page import="model.ProductError"%>
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
                            <a href="admin_addproduct.jsp" class="nav-link active">
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
                ProductError productError = (ProductError) request.getAttribute("PRODUCT_ERROR");
                if (productError == null) {
                    productError = new ProductError();
                }
            %>
            <div class="col-md-10">
                <div class="add-content">
                    <h2 class="pt-4 text-center">Add a new Product</h2>
                    <div>
                        <%
                            String message = (String) request.getAttribute("MESSAGE");
                            if (message == null) {
                                message = "";
                            }
                        %>
                        <h5><%= message%></h5>
                    </div>
                    <form action="MainController" method="POST">
                        <div class="row">
                            <div class="col-md-7">
                                <div class="mb-3 row">
                                    <label for="ID" class="col-sm-2 col-form-label">ID: </label>
                                    <div class="col-sm-10">
                                        <input type="text" id="ID" name="ID" required=""/>
                                        <span><%= productError.getProductId()%></span>
                                    </div>
                                </div>

                                <div class="mb-3 row">
                                    <label for="brand" class="col-sm-2 col-form-label">Brand: </label>
                                    <div class="col-sm-10">
                                        <input type="text" id="brand" name="brand" required=""/>
                                        <span><%= productError.getBrand()%></span>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="name" class="col-sm-2 col-form-label">Name: </label>
                                    <div class="col-sm-10">
                                        <input type="text" id="name" name="name" required=""/>
                                        <span><%= productError.getProductName()%></span>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="price" class="col-sm-2 col-form-label">Price: </label>
                                    <div class="col-sm-10">
                                        <input type="text" id="price" name="price" required=""/>
                                        <span><%= productError.getPrice()%></span>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="description" class="col-sm-2 col-form-label">Description: </label>
                                    <div class="col-sm-10">
                                        <input type="text" id="description" name="description" required=""/>
                                        <span><%= productError.getDescription()%></span>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="year" class="col-sm-2 col-form-label">Year: </label>
                                    <div class="col-sm-10">
                                        <input type="text" id="year" name="year" required=""/>
                                        <span><%= productError.getYearOfProduction()%></span>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="quantity" class="col-sm-2 col-form-label">Quantity: </label>
                                    <div class="col-sm-10">
                                        <input type="text" id="quantity" name="quantity" required=""/>
                                        <span><%= productError.getQuantity()%></span>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="sale" class="col-sm-2 col-form-label">Sale: </label>
                                    <div class="col-sm-10">
                                        <input type="text" id="sale" name="sale"  required=""/>
                                        <span><%= productError.getNotSale()%></span>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="discount" class="col-sm-2 col-form-label">Discount: </label>
                                    <div class="col-sm-10">
                                        <input type="text" id="discount" name="discount"  required=""/>
                                        <span><%= productError.getDiscount()%></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <label class="control-label">Ảnh sản phẩm</label>
                                <div id="myfileupload">
                                    <input type="file" id="uploadfile" multiple="" name="product_img" onchange="readURL(this);" />
                                </div>
                                <div id="thumbbox">
                                    <img height="450" width="400" alt="Thumb image" id="thumbimage" style="display: none" />
                                    <a class="removeimg" href="javascript:"></a>
                                </div>
                                <div id="boxchoice">
                                    <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Chọn ảnh</a>
                                    <p style="clear:both"></p>
                                </div>
                            </div>
                            <input class="btn btn-primary" type="submit" name="action" value="Add Product" >
                        </div>
                    </form>
                </div>
            </div>
        </div>
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
                                        function readURL(input, thumbimage) {
                                            if (input.files && input.files[0]) {
                                                var reader = new FileReader();
                                                reader.onload = function (e) {
                                                    $("#thumbimage").attr('src', e.target.result);
                                                }
                                                reader.readAsDataURL(input.files[0]);
                                            } else { // Sử dụng cho IE
                                                $("#thumbimage").attr('src', input.value);
                                            }
                                            $("#thumbimage").show();
                                            $('.filename').text($("#uploadfile").val());
                                            $('.Choicefile').css('background', '#14142B');
                                            $('.Choicefile').css('cursor', 'default');
                                            $(".removeimg").show();
                                            $(".Choicefile").unbind('click');

                                        }
                                        $(document).ready(function () {
                                            $(".Choicefile").bind('click', function () {
                                                $("#uploadfile").click();

                                            });
                                            $(".removeimg").click(function () {
                                                $("#thumbimage").attr('src', '').hide();
                                                $("#myfileupload").html('<input type="file" id="uploadfile"  onchange="readURL(this);" />');
                                                $(".removeimg").hide();
                                                $(".Choicefile").bind('click', function () {
                                                    $("#uploadfile").click();
                                                });
                                                $('.Choicefile').css('background', '#14142B');
                                                $('.Choicefile').css('cursor', 'pointer');
                                                $(".filename").text("");
                                            });
                                        });



        </script>   
    </body>
</html>
