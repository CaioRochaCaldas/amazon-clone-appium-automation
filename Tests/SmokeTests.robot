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
Resource    ../screens/User/UserBottomNavigation.robot
Resource    ../screens/Adm/AdminHeaderAndBottomNavigation.robot
Resource    ../screens/Adm/AdminCategory.robot
Resource    ../screens/Commons/Splash.robot

Library    BuiltIn
Library    DateTime

Test Setup       Start App
Test Teardown    Close App

*** Variables ***

#Seach
${Welcome_Message_Value}    Welcome

${User_Name}         John Stuart
${User_Email}        user3008@email.com
${User_Password}     123456

#Adm Login
${Adm_Email}         admin@email.com     
${Adm_Password}      123456

#Product
${Product_Name}            Xbox Series X
${Product_ Description}    Experience true next-gen performance with stunning 4K visuals, up to 120 FPS, and ray tracing for lifelike lighting and shadows. The ultra-fast SSD dramatically reduces load times, while Quick Resume lets you jump between games in seconds. With thousands of titles spanning four generations of Xbox, the Series X is the ultimate choice for power, speed, and immersive gaming.
${Product_Price}           10
${Input_Quantity}          100

*** Test Cases ***
Register User With Valid Data
    [Documentation]      Validates the registration flow of a new user using valid data.
    ...                  Precondition: User must not be already registered.
    ...                  Test Steps:
    ...                  1. Navigate to the SignIn/SignUp Screen.
    ...                  2. Enter valid data in all required fields: name, email, and password.
    ...                  3. Submit the registration form.
    ...                  Expected Result: User is successfully registered and redirected to the Home Screen.

    [Tags]               SignUp    Positive    Smoke
    Splash.Amazon Logo
    SignIn_SignUp.Register User Successfully   ${Welcome_Message_Value}   ${User_Name}     ${User_Email}      ${User_Password}  
Logout User
   [Documentation]       Verifies that a registered user can successfully log out of the application.
    ...                  Precondition: User must be already registered and logged in.
    ...                  Test Steps:
    ...                  1. Navigate to the "You" Screen.
    ...                  2. Click the "Log Out" button.
    ...                  Expected Result: The user is logged out and redirected to the SignIn/SignUp Screen.
    [Tags]               SignIn    Positive    Regression     Smoke
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials  ${User_Email}    ${User_Password}  
    UserBottomNavigation.Menu You
    You.Log Out User
    SignIn_SignUp.App returns to the Login Screen
Logout Admin
   [Documentation]       Verifies that a registered admin can successfully log out of the application.
    ...                  Precondition: admin must be already registered and logged in.
    ...                  Test Steps:
    ...                  1. Click the "Log Out" button.
    ...                  Expected Result: The admin is logged out and redirected to the SignIn/SignUp Screen.
    [Tags]               SignIn    Positive    Regression    Smoke  
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials  ${Adm_Email}      ${Adm_Password}
    AdminHeaderAndBottomNavigation.Log Out Adm
    SignIn_SignUp.App returns to the Login Screen
Search Product By Valid Name
    [Documentation]      Verifies that the system displays the correct results when a user searches for a product using a valid name.
    ...                  Precondition: User is on the home screen and the searched product exists.
    ...                  Test Steps:
    ...                  1. Enter a valid product name in the search field.
    ...                  2. Initiate the search.
    ...                  Expected Result: The system displays the matching product(s) with correct details.
    [Tags]    Positive    Search    Product    Smoke
        Splash.Amazon Logo
        SignIn_SignUp.Login With Valid Credentials    ${User_Email}      ${User_Password}  
        UserHome.Search Product        OnePlus
        SearchResult.Click First Search Result    OnePlus
Add Product To Cart
  [Documentation]    Verifies that a user can successfully add a selected product to the shopping cart and that the cart updates correctly.
...                  Precondition: User is on the product page.
...                  Test Steps:
...                  1. Select a product from the Deal of the Day.
...                  2. Click the "Add to Cart" button.
...                  Expected Result: The product is added to the shopping cart, and the cart displays the correct quantity and product details.

    [Tags]    Product    Cart    Positive    Smoke    
        Splash.Amazon Logo
        SignIn_SignUp.Login With Valid Credentials    teste123@gmail.com    123456
        UserHome.Select Deal of the Day Product
        Product.Add product to cart
        USerHome.Menu cart
        Cart.Check Product in Cart

Update Product Quantity In Cart
    [Documentation]    Verifies that the quantity of a specific product in the shopping cart can be updated correctly.
    ...                  Precondition: The product is already added to the shopping cart.
    ...                  Test Steps:
    ...                  1. Locate the product in the shopping cart.
    ...                  2. Change the product quantity increment and decrement.
    ...                  3. Apply the update.
    ...                  Expected Result: The product quantity is updated correctly, and the cart reflects the change accurately.

     [Tags]    Product    Cart    Positive    Smoke
        Splash.Amazon Logo
        #SignIn_SignUp.Login With Valid Credentials    ${User_Email}      ${User_Password}  
        SignIn_SignUp.Login With Valid Credentials    ${User_Email}      ${User_Password}  
        UserHome.Select Deal of the Day Product
        Product.Add product to cart
        UserHome.Menu cart
        Cart.Check Product in Cart
        Cart.Changing Product Quantity
Purchase Product And Verify Order info
    [Documentation]    Verifies that a user can complete a purchase and that the order information is correctly displayed in the order summary.
    ...                  Precondition: The product is available in the store and added to the shopping cart.
    ...                  Test Steps:
    ...                  1. Proceed to checkout with a valid product in the cart.
    ...                  2. Complete the purchase process provide payment and delivery details.
    ...                  3. Navigate to the order summary page.
    ...                  Expected Result: The order summary displays the correct product details.

    [Tags]    Product    Cart    Positive    Order    Smoke
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials    ${User_Email}      ${User_Password}  
    UserHome.Select Deal of the Day Product
    Product.Add product to cart
    UserHome.Menu cart
    Cart.Check Product in Cart
    Cart.Buy Product
    Cart.Adress    102     875 N Michigan Ave, John Hancock Center     60611    Chicago
    Cart.Pay With Google Pay
    UserBottomNavigation.Menu You
    ${Today}    Get Current Date    result_format=%B %d, %Y
    You.Your Orders
    Orders.Choose First Product      ${Today}       ₹39,999
Admin creates and deletes a product    
    [Documentation]    This test verifies that an admin can create and delete a product.  
...                    The test covers the following steps:  
...                    1. Admin logs into the application.  
...                    2. Admin creates a new product with all necessary details.  
...                    3. Admin navigates to the category of the newly created product to verify its presence.  
...                    4. Admin deletes the created product.  
...                    5. Optionally, verify that the product no longer exists in the category.  
    [Tags]      Admin    Adm    Smoke
        Splash.Amazon Logo
        SignIn_SignUp.Login With Valid Credentials   ${Adm_Email}      ${Adm_Password}
        AddProductWidget.Click Add Product Widget
        AdminProduct.Create Product    ${Product_Name}   ${Product_ Description}   ${Product_Price}     ${Input_Quantity} 
        AdminHome.Toast Product added successfully
        AdminHome.Electronics category
        AdminCategory.Select Product     ${Product_Name} 
