
<%@page import="com.mrperfect.entities.User"%>
<%

User user1=(User)session.getAttribute("current-user");

%>


<nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <div class="container">


        <a class="navbar-brand" href="index.jsp"><sapn class="fa fa-shopping-basket" ></sapn> My Cart</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp"><span class="fa fa-home"></span> Home <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <span class="fa fa-bars"></span>
                        Category
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </li>
          
            </ul>
            <ul class="navbar-nav ml-auto">
                
                <li>
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#cart-modal"><span  style="font-size: 20px" class="fa fa-cart-arrow-down cart-items" style="font-size: 20px"></span> </a>
                </li>
                
                  <% if(user1==null){
                      
                      %>
                      <li><a class="nav-link" href="login.jsp"><span class="fa fa-sign-in" ></span> LOGIN </a>
                </li>
                <li>
                    <a class="nav-link" href="register.jsp"><span class="fa fa-user-plus" ></span> SIGN-UP </a>
                </li>
                      
                      
                  
               <% }else{
%>

<li><a class="nav-link" href="#!"><%= user1.getUserName() %> </a>
                </li>
                <li>
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out"></span>LOGOUT </a>
                </li>



<%  }   %>
               
            </ul>

        </div>
    </div>
</nav>