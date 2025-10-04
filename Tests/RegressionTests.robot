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
${Error_Message_Value}      This field cannot be empty

@{Order_Name_Value}    OnePlus    oneplus    OnePlus 11    OnePlus 108    Xiaomi

${User_Name}         John Stuart
${User_Email}        user3013@email.com
${User_Password}     123456


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
    ...                  4. Enter valid username and password.
    ...                  5. Click the "Continue" button.
    ...                  Expected Result: User is successfully registered and redirected to the Home Screen.
    [Tags]               SignUp    Positive    Regression    
    Splash.Amazon Logo
    SignIn_SignUp.Register User Successfully    ${Welcome_Message_Value}      ${User_Name}     ${User_Email}      ${User_Password}  
Search Product By Valid Name
    [Documentation]      Verifies that the system displays the correct results when a user searches for a product using a valid name.
    ...                  Precondition: User is on the home screen and the searched product exists.
    ...                  Test Steps:
    ...                  1. Enter a valid product name in the search field.
    ...                  2. Initiate the search.
    ...                  Expected Result: The system displays the matching product(s) with correct details.
    [Tags]    Positive    Search    Product    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials     teste123@gmail.com    123456
    UserHome.Search Product        OnePlus
    SearchResult.Click First Search Result    OnePlus
Add Product To Cart
    [Documentation]    Verifies that a user can successfully add a selected product to the shopping cart and that the cart updates correctly.
    ...                  Precondition: User is on the product page.
    ...                  Test Steps:
    ...                  1. Select a product from the Deal of the Day.
    ...                  2. Click the "Add to Cart" button.
    ...                  Expected Result: The product is added to the shopping cart, and the cart displays the correct quantity and product details.
    [Tags]    Product    Cart    Positive    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials     teste123@gmail.com    123456
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
    [Tags]    Product    Cart    Positive    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials    user1927@email.com      ${User_Password}  
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
    [Tags]    Product    Cart    Positive    Order    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials    jason@gmail.com    123456
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
Error Messages Display for Empty Name, Email, and Password during Registration
     [Documentation]    Verifies that appropriate error messages are displayed when a user attempts to register with all required fields empty (Name, Email, and Password).
    ...                 Precondition: User is on the registration page.
    ...                 Test Steps:
    ...                 1. Leave the Name, Email, and Password fields empty.
    ...                 2. Attempt to submit the registration form.
    ...                 Expected Result: Validation messages for all required fields are displayed and clearly visible to the user simultaneously.
    [Tags]              SignUp    Fail    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Registration Rejected: Empty Name, Empty Email and Empty Password    ${Welcome_Message_Value}    ${Error_Message_Value}
    UserHome.Home Screen elements
Invalid User Registration with Valid Name,Invalid Email
    [Documentation]      Verifies that the application prevents user registration when the email field is empty, even if the name and password are valid.
    ...                  Precondition: User is on the registration page.
    ...                  Test Steps:
    ...                  1. Enter a valid Name.
    ...                  2. Leave the Email field empty
    ...                  3. Fill in the Password field with valid data.
    ...                  4. Attempt to submit the registration form.
    ...                  Expected Result: The system displays an appropriate error message for the Email field and prevents registration.
    [Tags]               SignUp  Fail  Regression
    Splash.Amazon Logo
    SignIn_SignUp.Registration Rejected: Valid Name,Invalid Email  ${Welcome_Message_Value}    Geralt        123456
    UserHome.Home Screen elements
Invalid User Registration with With Already Registered Email
    [Documentation]      Verifies that the application prevents the creation of a new user account when the provided Email is already registered.
    ...                  Precondition: The system must already contain an account with the provided Email and the User is on the registration page.
    ...                  Test Steps:
    ...                  1. Enter a valid Name.
    ...                  2. Enter an Email that is already registered.
    ...                  3. Fill in the Password field with valid data.
    ...                  4. Attempt to submit the registration form.
    ...                  Expected Result: The system displays an appropriate error message and prevents account duplication.
    [Tags]             SignUp  Fail  Regression
    Splash.Amazon Logo
    SignIn_SignUp.Fail to Register User with Already Registered Email  ${Welcome_Message_Value}    Mason    teste123@gmail.com      123456 
    UserHome.Home Screen elements
Invalid User Registration with Valid Name, Valid Email and Invalid Password less them 6
    [Documentation]    Verifies that the application blocks the creation of a new user account when the provided Password is invalid (fewer than 6 characters).
    ...                  Precondition: User is on the registration page.
    ...                  Test Steps:
    ...                  1. Enter a valid Name.
    ...                  2. Enter a valid Email.
    ...                  3. Enter a Password with fewer than 6 characters.
    ...                  4. Attempt to submit the registration form.
    ...                  Expected Result: The system displays a validation message for the Password field and prevents account registration.

    [Tags]             SignUp    Fail  Regression
    Splash.Amazon Logo
    SignIn_SignUp.Registration Rejected: Valid Name, Valid Email and Invalid Password less them 6    ${Welcome_Message_Value}    Mason    tester1999@gmail.com      12345 
    UserHome.Home Screen elements
Search Product With Invalid Name
   [Documentation]       Verifies that the system handles searches for invalid or non-existing product names appropriately.
    ...                  Precondition: User is on the home screen.
    ...                  Test Steps:
    ...                  1. Enter an invalid or non-existing product name in the search field.    
    ...                  2. Initiate the search.
    ...                  Expected Result: No products are displayed.
    [Tags]    Negative    Search    Product    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials     teste123@gmail.com   123456
    UserHome.Search Product        plastation 5
    SearchResult.No Products Found
Clear Product From Cart Using Button
    [Documentation]    Verifies that a user can remove a product from the shopping cart and that the cart updates correctly.
    ...                  Precondition: The product is already added to the shopping cart.
    ...                  Test Steps:
    ...                  1. Locate the product in the shopping cart.
    ...                  2. Click the "Remove" button for the product.
    ...                  Expected Result: The product is removed from the cart, and the cart reflects the change.
    [Tags]    Product    Cart    Positive    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials    teste123@gmail.com    123456
    UserHome.Select Deal of the Day Product
    Product.Add product to cart
    UserHome.Menu cart
    Cart.Check Product in Cart
    Cart.Remove Product From Cart Using Button
Clear Product From Cart Using Swipe
    [Documentation]    Verifies that a user can remove a product from the shopping cart using a swipe gesture and that the cart updates correctly.
    ...                  Precondition: The product is already added to the shopping cart.
    ...                  Test Steps:
    ...                  1. Locate the product in the shopping cart.
    ...                  2. Perform a swipe gesture to remove the product.
    ...                  Expected Result: The product is removed from the cart, and the cart reflects the change.
    [Tags]    Product    Cart    Positive    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials    teste123@gmail.com    123456
    UserHome.Select Deal of the Day Product
    Product.Add product to cart
    UserHome.Menu cart
    Cart.Check Product in Cart
    Cart.Remove Product From Cart Using Swipe
          
Save Product for Later Button
    [Documentation]    Verifies that a user can move a product from the shopping cart to the "Save for Later" list.
    ...                  Precondition: The product is already added to the shopping cart.
    ...                  Test Steps:
    ...                  1. Locate the product in the shopping cart.
    ...                  2. Click the "Save for Later" button for the product.
    ...                  Expected Result: The product is removed from the cart and appears in the "Save for Later" list on the cart page.
    [Tags]    Product    Cart    Positive    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials    teste123@gmail.com    123456
    UserHome.Select Deal of the Day Product
    Product.Add product to cart
    UserHome.Menu cart
    Cart.Check Product in Cart
    Cart.Saving product for later with button

Save Product for later Swipe
    [Documentation]    Verifies that a user can move a product from the shopping cart to the "Save for Later" list using a swipe gesture.
    ...                  Precondition: The product is already added to the shopping cart.
    ...                  Test Steps:
    ...                  1. Locate the product in the shopping cart.
    ...                  2. Perform a swipe gesture related to "Save for Later" option.
    ...                  Expected Result: The product is removed from the cart and appears in the "Save for Later" list on the cart page.
    [Tags]    Product    Cart    Positive    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials    teste123@gmail.com    123456
    UserHome.Select Deal of the Day Product
    Product.Add product to cart
    UserHome.Menu cart
    Cart.Check Product in Cart
    Cart.Saving product for later with swipe
Search bought itens history
    [Documentation]    Verifies that a user can search for previously purchased items in the order history.
    ...                  Precondition: The user is logged in and has past orders in the order history.
    ...                  Test Steps:
    ...                  1. Navigate to the order history page.
    ...                  2. Enter the name of a previously purchased product in the search field.
    ...                  3. Initiate the search.
    ...                  Expected Result: The system displays the matching purchased item(s) in the order history with correct details.
    [Tags]    Product    Cart    Positive    Order    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials    teste123@gmail.com    123456
    UserBottomNavigation.Menu You
    You.Your Orders
    Orders.Search all orders    @{Order_Name_Value}
Add Product To Wishlist
    [Documentation]  Adds a selected product to the wishlist. 
    ...              Precondition: User must be logged in and product available in catalog.
    ...              Steps:
    ...              1. Navigate to the product page.
    ...              2. Click on "Add to Wishlist".
    ...              3. Verify success message is displayed.
    ...              Expected Result: Product is successfully added to the wishlist and visible in the wishlist list. 
    [Tags]    Product    Wishlist    Positive    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials     ${User_Email}      ${User_Password}  
    UserHome.Select Deal of the Day Product
    Product.Add product to wishlist
    UserBottomNavigation.Menu You
    You.Accessing wish list
    WishList.Checking product at wishList    OnePlus 11R 5G
Remove Product From Wishlist
    [Documentation]  Removes a selected product from the wishlist.
    ...              Precondition: User must be logged in and product already added to the wishlist.
    ...              Steps:
    ...              1. Navigate to the wishlist page.
    ...              2. Click on "Remove" for the desired product.
    ...              3. Confirm removal if prompted.
    ...              Expected Result: Product is no longer displayed in the wishlist.

    [Tags]    Product    Wishlist    Positive     Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials     ${User_Email}      ${User_Password}  
    UserHome.Select Deal of the Day Product
    Product.Add product to wishlist
    UserBottomNavigation.Menu You
    You.Accessing wish list
    WishList.Remove product From wishList
Add Wishlist Product to Cart and Verify Removal from Wishlist
    [Documentation]  Moves a product from the wishlist to the cart and validates removal from wishlist.
    ...              Precondition: User must be logged in and have at least one product saved in the wishlist.
    ...              Steps:
    ...              1. Navigate to the wishlist page.
    ...              2. Select "Move to Cart" for the desired product.
    ...              3. Verify the product appears in the cart.
    ...              4. Return to the wishlist and check the product is no longer listed.
    ...              Expected Result: Product is successfully transferred to the cart and removed from the wishlist. 
    [Tags]    Product  Wishlist   Cart    Positive     Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials     ${User_Email}      ${User_Password}  
    UserHome.Select Deal of the Day Product
    Product.Add product to wishlist
    UserBottomNavigation.Menu You
    You.Accessing wish list
    WishList.Add product From wishList To Cart
    You.Accessing wish list
    WishList.Check Wish List Is Empty
    UserBottomNavigation.Menu cart
    Cart.Check Product in Cart
    Cart.Remove Product From Cart Using Button
Admin creates and deletes a product    
    [Documentation]    This test verifies that an admin can create and delete a product.  
    ...                The test covers the following steps:  
    ...                1. Admin logs into the application.  
    ...                2. Admin creates a new product with all necessary details.  
    ...                3. Admin navigates to the category of the newly created product to verify its presence.  
    ...                4. Admin deletes the created product.  
    ...                5. Optionally, verify that the product no longer exists in the category.  
    [Tags]      Admin    Adm    Regression
    Splash.Amazon Logo
    SignIn_SignUp.Login With Valid Credentials     admin@email.com    123456
    AddProductWidget.Click Add Product Widget
    AdminProduct.Create Product    ${Product_Name}   ${Product_ Description}   ${Product_Price}     ${Input_Quantity} 
    AdminHome.Toast Product added successfully
    AdminHome.Electronics category
    AdminCategory.Select Product     ${Product_Name} 
