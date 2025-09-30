*** Settings ***
Library     AppiumLibrary

*** Variables ***
${Btn_WishList}                          accessibility_id:Wish List
${Btn_BuyAgain}                          accessibility_id:Buy Again
${Btn_YourOrders}                        xpath=//android.widget.Button[@content-desc="Your Orders"]
${First_Product_In_List}                 xpath=(//android.widget.ImageView)[1]
${OrderDate}                             xpath=//android.view.View[contains(@content-desc, "Order date")]
${OrderTotal}                            xpath=//android.view.View[contains(@content-desc, "Order total")]

*** Keywords ***

Log Out User
  Wait Until Keyword Succeeds  10s  1s
  ...      Click Element    android=new UiScrollable(new UiSelector().scrollable(true).instance(0)).scrollIntoView(new UiSelector().description("Log Out"))
              
Accessing wish list
    Wait Until Element Is Visible        ${Btn_WishList}
    Click Element    ${Btn_WishList}


Your Orders
    Wait Until Element Is Visible    ${Btn_YourOrders} 
    Click Element    ${Btn_YourOrders}
