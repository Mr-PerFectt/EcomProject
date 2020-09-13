<%-- 
    Document   : index
    Created on : Sep 9, 2020, 9:32:47 AM
    Author     : JEET
--%>

<%@page import="com.mrperfect.helper.Helper"%>
<%@page import="com.mrperfect.entities.Category"%>
<%@page import="com.mrperfect.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mrperfect.entities.Product"%>
<%@page import="com.mrperfect.dao.ProductDao"%>
<%@page import="com.mrperfect.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>

        <%@include file="components/navbar.jsp" %>

        <%
            String cat = request.getParameter("category");
            //out.println(cat);

            ProductDao dao = new ProductDao(FactoryProvider.getFactory());
            List<Product> list = null;
            try {
                if (cat == null || cat.trim().equals("all")) {

                    list = dao.getAllProduct();
//
                } else {
                    int cid = Integer.parseInt(cat.trim());
                    list = dao.getAllProductById(cid);

                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
            List<Category> clist = cdao.getCategories();


        %>

        <div class="container-fluid">
            <div class="row mt-3 mx-2">



                <!--show category-->
                <div class="col-md-2">

                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item active">All Product</a>

                        <%     for (Category c : clist) {%>


                        <a href="index.jsp?category=<%=c.getCategoryId()%>" class="list-group-item"><%=c.getCategoryTitle()%></a>


                        <%
                            }
                        %>
                    </div>



                </div>

                <!--show Product-->
                <div class="col-md-10">

                    <!--row-->
                    <div class="row mt-4">


                        <!--col-12 grid-->




                        <div class="col-md-12">

                            <div class="card-columns">

                                <!--fetch data-->

                                <% for (Product p : list) {%>

                                <!--product card-->
                                <div class="card">
                                    <div class="container text-center">

                                        <img src="img/products/<%= p.getpPhoto()%>" style="max-height: 150px;max-width:100%;  width: auto; " class="card-img-top m-2">
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <%=p.getpName()%>
                                        </h5>
                                        <p class="card-text">
                                            <%= Helper.get10Words(p.getpDesc())%>

                                        </p>
                                    </div>

                                    <div class="card-footer text-center">
                                        <button class="btn btn-outline-info"> &#8377; <%= p.getPriceAfterDiscount() %>/-<span class="text-secondary discount-lable">&#8377; <%=p.getpPrice() %>,<%=  p.getpDiscount() %>% off</span> </button>
                                        <button class="btn btn-outline-success"> Buy Now</button>
                                        <button onclick="add_to_cart(<%= p.getpId()%>,'<%= p.getpName() %>',<%= p.getPriceAfterDiscount() %>)" class="btn btn-outline-warning "> <span class="fa fa-cart-plus"style="font-size:24px"></span></button>

                                    </div>


                                </div>

                                <%}%>



                                <% if (list.size() == 0) {
                                %>

                                <div class="container-fluid mt-4 text-center">

                                    <span class="fa fa-exclamation-triangle"style="font-size:48px;"> No items !!</span>
                                </div>

                                <%}


                                %>
                            </div>


                        </div>

                    </div>



                </div>


            </div>
        </div>
                            
                                <%@include file="components/common_modals.jsp" %>
    </body>
</html>
