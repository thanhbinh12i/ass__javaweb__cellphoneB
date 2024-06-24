<%-- 
    Document   : order
    Created on : Jun 14, 2024, 11:20:47 AM
    Author     : PC
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Order"%>
<%@page import="model.User"%>
<%@page import="java.util.Random"%>
<%@page import="model.Product"%>
<%@page import="model.Cart"%>
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
        <form action="MainController">

            <div class="container">
                <main>
                    <div class="py-5 text-center">
                        <h2>Checkout form</h2>
                    </div>

                    <div class="row g-5">
                        <%
                            Cart cart = (Cart) session.getAttribute("CART");
                            double total = 0;
                            if (cart != null) {
                        %>
                        <div class="col-md-5 col-lg-4 order-md-last">
                            <h4 class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-primary">Your cart</span>
                            </h4>
                            <%
                                int count = 1;
                                for (Product product : cart.getCart().values()) {
                                    total += product.getQuantity() * product.getPrice();
                            %>
                            <form action="MainController">
                                <ul class="list-group mb-3">
                                    <li class="list-group-item d-flex justify-content-between lh-sm">
                                        <div>
                                            <h6 class="my-0"><%=  product.getProductName()%> x <%=  product.getQuantity()%></h6>

                                            <input type="hidden" name="name" value="<%=  product.getProductName()%>" readonly=""/>
                                            <small class="text-body-secondary"><%=  product.getDescription()%></small>
                                        </div>
                                        <span class="text-body-secondary"><%=  product.formatNumber(product.getQuantity() * product.getPrice())%></span>
                                    </li>
                                </ul>
                                <%
                                    }
                                %>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Total</span>
                                    <strong><%= String.format("%,.0f", total).replace(",", ".")%></strong>

                                </li>
                            </form>


                        </div>
                        <%
                            }
                        %>
                        <div class="col-md-7 col-lg-8">
                            <h4 class="mb-3">Billing address</h4>
                            <form action="MainController" class="needs-validation" novalidate>
                                <%
                                    Random random = new Random();
                                    int orderId = (int) System.currentTimeMillis() + random.nextInt(900);
                                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                    String date = formatter.format(new Date());
                                %>
                                <input type="hidden" name="totalPrice" value="<%= total%>" required=""/>
                                <input type="hidden" name="orderId" value="<%= orderId%>">
                                <input type="hidden" name="orderDate" value="<%= date%>">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <%
                                            String invoiceId = "INV-" + (int) System.currentTimeMillis() + random.nextInt(900);
                                        %>
                                        <label for="invoiceId" class="form-label">InvoiceID</label>
                                        <div class="input-group has-validation">
                                            <span class="input-group-text">@</span>
                                            <input type="text" class="form-control" id="invoiceId" name="invoiceId" value="<%=invoiceId%>" readonly="">
                                            <div class="invalid-feedback">
                                                Your username is required.
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                        User loginUser = (User) session.getAttribute("LOGIN_USER");
                                        if (loginUser != null) {
                                    %>
                                    <div class="col-12">
                                        <label for="userId" class="form-label">UserID</label>
                                        <div class="input-group has-validation">
                                            <span class="input-group-text">@</span>
                                            <input type="text" class="form-control" id="userId" name="userId" value="<%=loginUser.getUserId()%>" readonly="">
                                        </div>

                                    </div>
                                    <div class="col-12">
                                        <label for="fullName" class="form-label">Full name</label>
                                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder="" value="<%= loginUser.getFullName()%>" required>
                                    </div>

                                    <div class="col-12">
                                        <label for="phone" class="form-label">Phone </label>
                                        <input type=tel" class="form-control" id="phone" name="phone" placeholder="0xxxxxxxxx" value="<%= loginUser.getPhoneNumber()%>">
                                    </div>

                                    <div class="col-12">
                                        <label for="email" class="form-label">Email <span class="text-body-secondary"></span></label>
                                        <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" value="<%= loginUser.getEmail()%>">
                                    </div>

                                    <div class="col-12">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" class="form-control" id="address" name="address" placeholder="1234 Main St" value="<%= loginUser.getAddress()%>" required>
                                    </div>
                                    <%}%>
                                </div>

                                <hr class="my-4">

                                <h4 class="mb-3">Payment</h4>

                                <div class="my-3">
                                    <div class="form-check">
                                        <input id="momo" name="paymentMethod" value="Momo" type="radio" class="form-check-input" checked required>
                                        <label class="form-check-label" for="momo">Momo</label>
                                    </div>
                                    <div class="form-check">
                                        <input id="bank" name="paymentMethod" value="Bank" type="radio" class="form-check-input" required>
                                        <label class="form-check-label" for="bank">Bank</label>
                                    </div>
                                    <div class="form-check">
                                        <input id="paypal" name="paymentMethod" value="PayPal" type="radio" class="form-check-input" required>
                                        <label class="form-check-label" for="paypal">PayPal</label>
                                    </div>
                                </div>

                                <hr class="my-4">

                                <input class="w-100 btn btn-primary btn-lg" type="submit" name="action" value="Checkout">
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </form>

    </body>
</html>
