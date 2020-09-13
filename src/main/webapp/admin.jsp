<%@page import="java.util.Map"%>
<%@page import="com.mrperfect.helper.Helper"%>
<%@page import="com.mrperfect.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.mrperfect.dao.CategoryDao"%>
<%@page import="com.mrperfect.helper.FactoryProvider"%>
<%@page import="com.mrperfect.entities.User"%>
<%

    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("message", "You are not logged In !! Log in First..");
        response.sendRedirect("login.jsp");
    } else {
        if (user.getUserType().equals("normal")) {

            session.setAttribute("message", "You are not Admin !! Access Denied..");
            response.sendRedirect("login.jsp");
            return;
        }

    }

%>

   <%  CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                                List<Category> list = cDao.getCategories();
                                
//getting count

           Map<String,Long> m=Helper.getCount(FactoryProvider.getFactory());


                            %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>


        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>

            </div>

            <div class="row mt-3">
                <!-- first column -->
                <div class="col-md-4">

                    <div class="card">

                        <div class="card-body text-center">
                            <div class="container">

                                <img style="max-width: 100px" class="img-fluid" src="img/worker.png" alt="" />
                            </div>
                            <h2><%= m.get("userCount") %></h2>
                            <h2 class="text-uppercase text-muted">Users</h2>
                        </div>
                    </div>


                </div>
                <!-- second column -->
                <div class="col-md-4">
                    <div class="card">

                        <div class="card-body text-center">
                            <div class="container">

                                <img style="max-width: 100px" class="img-fluid" src="img/list.png" alt="" />
                            </div>
                            <h2><%= list.size() %></h2>
                            <h2 class="text-uppercase text-muted">Categories</h2>
                        </div>
                    </div>

                </div>
                <!-- third column -->
                <div class="col-md-4">
                    <div class="card">

                        <div class="card-body text-center">
                            <div class="container">

                                <img style="max-width: 100px" class="img-fluid" src="img/product.png" alt="" />
                            </div>
                            <h2><%= m.get("productCount") %></h2>
                            <h2 class="text-uppercase text-muted">Products</h2>
                        </div>
                    </div>

                </div>

            </div>

            <!-- Second row-->

            <div class="row text-center mt-3">

                <!--second row first col-->


                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category">

                        <div class="card-body text-center">
                            <div class="container">

                                <img style="max-width: 100px" class="img-fluid" src="img/add.png" alt="" />
                            </div>
<!--                            <h2>1234</h2>-->
                            <p>Click here to add new category</p>
                            <h2 class="text-uppercase text-muted">Add Category</h2>
                        </div>
                    </div>

                </div>

                <!--second row second col-->


                <div class="col-md-6">

                    <div class="card"data-toggle="modal" data-target="#add-product">

                        <div class="card-body text-center">
                            <div class="container">

                                <img style="max-width: 100px" class="img-fluid" src="img/add-product.png" alt="" />
                            </div>
<!--                            <h2>1234</h2>-->
                            <p>Click here to add new category</p>
                            <h2 class="text-uppercase text-muted">Add Product</h2>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <!--start of Modal-->



        <!-- Modal -->
        <div class="modal fade" id="add-category" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details.</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" value="addcategory" name="operation"/>
                            <div class="form-group">


                                <input type="text" placeholder="Enter Category Title" class="form-control" required name="catTitle"/>
                            </div>

                            <div class="form-group">

                                <textarea style="height: 200px"class="form-control" placeholder="Enter Category Details" name="catDescription" required></textarea>
                            </div>
                            <div class="container text-center">

                                <button class="btn btn-outline-success">Add category</button>
                                <button type="reset" class="btn btn-outline-danger">Reset</button>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                    </div>
                </div>
            </div>
        </div>

        <!--end of modal-->

        <!--add product modal-->


        <div class="modal fade" id="add-product" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Product Details.</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" value="addproduct" name="operation"/>


                            <!--Product Category-->

                           
                            <select class="form-control mb-3" name="catId"  id="">

                                <%   
                                     for (Category c : list) {
                                %>
                                <option value="<%=c.getCategoryId()%>">
                                    <%=c.getCategoryTitle()%>

                                </option> 

                                <% }%>




                            </select>


                            <!--Product Title-->
                            <div class="form-group">


                                <input type="text" placeholder="Enter Product Title" class="form-control" required name="pTitle" required />
                            </div>

                            <!--Product description-->

                            <div class="form-group">

                                <textarea style="height: 200px"class="form-control" placeholder="Enter Product Details" name="pDescription" required></textarea>
                            </div>

                            <!--product price-->
                            <div class="form-group">


                                <input type="number" placeholder="Enter Product Price" class="form-control" required name="pPrice" required />
                            </div>

                            <!--Product discount-->

                            <div class="form-group">


                                <input type="number" placeholder="Enter Product Discount" class="form-control" required name="pDiscount" required />
                            </div>

                            <!--product quantity-->

                            <div class="form-group">


                                <input type="number" placeholder="Enter Product Quantity" class="form-control" required name="pQuantity" required />
                            </div>

                            <!--Product image-->
                            <div class="input-group mb-3">
                                <div class="custom-file">
                                    <input name="pImage" type="file" class="custom-file-input fa fa-cloud-upload" id="inputGroupFile02">
                                    <label class="custom-file-label" for="inputGroupFile02">Choose file</label>
                                </div>
                                <div>

                                </div>
                            </div>




                            <!--buttons-->
                            <div class="container text-center">

                                <button class="btn btn-outline-success">Add Product</button>
                                <button type="reset" class="btn btn-outline-danger">Reset</button>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                    </div>
                </div>
            </div>
        </div>

        <!--end of add product Modal-->




    </body>
</html>
