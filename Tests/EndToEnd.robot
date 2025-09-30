*** Settings ***
Resource    ../resources/base.resource
Resource    ../screens/User/UserHome.robot
Resource    ../screens/Adm/AdminHome.robot
Resource    ../screens/Adm/AdminProduct.robot
Resource    ../screens/Adm/AddProductWidget.robot
Resource    ../screens/User/You.robot
Resource    ../screens/User/WishList.robot
Resource    ../screens/User/Product.robot
Resource    ../screens/User/Cart.robot
Resource    ../screens/User/Orders.robot
Resource    ../screens/User/SearchResult.robot
Resource    ../screens/Commons/SignIn_SignUp.robot
Resource    ../screens/Commons/Navigation.robot
Resource    ../screens/User/UserBottomNavigation.robot
Resource    ../screens/Adm/AdminHeaderAndBottomNavigation.robot
Resource    ../screens/Adm/AdminOrders.robot
Resource    ../screens/Commons/Splash.robot

Library    BuiltIn
Library    DateTime

Suite Setup       Start App
Suite Teardown    Close App

*** Variables ***


#User
${User_Name}         John Stuart
${User_Email}        user1927@email.com
${User_Password}     123456

#Product
${Product_Name}            Xbox Series X
${Product_ Description}    Experience true next-gen performance with stunning 4K visuals, up to 120 FPS, and ray tracing for lifelike lighting and shadows. The ultra-fast SSD dramatically reduces load times, while Quick Resume lets you jump between games in seconds. With thousands of titles spanning four generations of Xbox, the Series X is the ultimate choice for power, speed, and immersive gaming.
${Product_Price}           10
${Input_Quantity}          100


*** Test Cases ***

EndToEnd
    [Documentation]    End-to-End test of the complete flow in the Amazon clone app. 
    ...               This test covers the main interactions of both Admin and User:
    ...               1. Admin registers a new product in the "Electronics" category with the name "Xbox Series X"
    ...               2. User creates a new account and logs into the app.
    ...               3. User adds the product to the cart.
    ...               4. User completes the purchase and verifies the order.
    ...               5. Admin logs into the app again.
    ...               6. Admin checks the orders made by the customer.  
    [Tags]         EndToEnd    E2E
    #Admin
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials     admin@email.com    123456
    AddProductWidget.Click Add Product Widget
    AdminProduct.Create Product    ${Product_Name}   ${Product_ Description}   ${Product_Price}     ${Input_Quantity} 
    AdminHome.Toast Product added successfully  
    AdminHeaderAndBottomNavigation.LogOut Adm
  
    #User
    SignIn_SignUp.Register User Successfully    Welcome   ${User_Name}    ${User_Email}    ${User_Password}  
    UserHome.Search Product       ${Product_Name}
    SearchResult.Click First Search Result    ${Product_Name}
    Product.Add product to cart
    Navigation.Go Back From Product to Home
    UserHome.Menu cart
    Cart.Check Product in Cart
    Cart.Buy Product
    Cart.Adress    102     875 N Michigan Ave, John Hancock Center     60611    Chicago
    Cart.Pay With Google Pay
    UserBottomNavigation.Menu You
    ${Today}    Get Current Date    result_format=%B %d, %Y
    You.Your Orders
    Orders.Choose First Product      ${Today}       ₹10
    Navigation.Go Back From OrderScreen to YouScreen
    You.Log Out User

    #Admin
    SignIn_SignUp.Login With Valid Credentials     admin@email.com    123456
    AdminHeaderAndBottomNavigation.Menu Orders
    AdminOrders.CheckOrderInfo     ${Product_Name}
    