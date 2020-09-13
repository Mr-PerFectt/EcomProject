/* global totalPrice */

function add_to_cart(pid, pname, price) {



    let cart = localStorage.getItem("cart");

    if (cart == null) {

        //no cat yet

        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price}
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
       // console.log("Product added Fist time")
        showToast("Item added to Cart ^-^");
    } else {
        let pcart = JSON.parse(cart);

        let oldProduct = pcart.find((item) => item.productId == pid)

        if (oldProduct) {
            // we have to increase quantity

            oldProduct.productQuantity = oldProduct.productQuantity + 1
            pcart.map((item) => {
                if (item.productId == oldProduct.productId) {


                    item.productQuantity = oldProduct.productQuantity;
                }


            })
            localStorage.setItem("cart", JSON.stringify(pcart));

            //console.log("product quantity incresed")
               showToast(oldProduct.productName+" Quantity Increased ^-^");

        } else {
            // add the new product

            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price}
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));

           // console.log("new Product added")
              showToast("Item added to Cart ^-^");

        }




    }updateCart();
}



function updateCart() {

    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if (cart == null || cart.length == 0) {

        console.log("cart is empty !!")
        $(".cart-items").html("(0)");
        $(".cart-body").html("<h3> Cart Have No Items </h3>");
        $(".checkout-btn").addClass('disabled');


    } else {

        console.log(cart)
        $(".cart-items").html(`(${cart.length})`);
        let table = `
             <table class='table'>
             <thead class='thead-light'>
             <tr>
        <th> Item Name </th>
        <th> Price</th>
        <th> Quantity</th>
        <th>Total Price</th>
        <th>Action</th>
        
        </tr>
        </thead>
        
`;
let totalPrice=0;
        cart.map((item) => {
            table += `
                   <tr>
            <td> ${item.productName} </td>
            <td> ${item.productPrice} </td>
            <td> ${item.productQuantity} </td>
            <td> ${item.productPrice * item.productQuantity} </td>
            <td> <button onclick="deleteItemFromcart(${item.productId})" class='btn btn-outline-danger btn-sm'>Remove</button></td>




                   </tr>




                `
            totalPrice += item.productPrice * item.productQuantity;




        })


        table = table + `
<tr><td colspan='5' class='text-right font-weight-bold m-5'>Total Price:${totalPrice}</td></tr>
</table>`;

        $(".cart-body").html(table);

    }


}

//delete item from cart

function deleteItemFromcart(pid){
    let cart = JSON.parse(localStorage.getItem('cart'));
    let newcart= cart.filter((item)=> item.productId!=pid)
    localStorage.setItem('cart',JSON.stringify(newcart))
   
      
    
    updateCart();
   showToast("Item removed from Cart ^-^ ");  
    
}
$(document).ready(function () {

    updateCart()

})


function showToast(content){
    
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(()=>{
        $("#toast").removeClass("display");
    },2000);
    
    
    
}