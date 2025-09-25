*** Settings ***
Library     AppiumLibrary

*** Variables ***
${Btn_WishList}                          accessibility_id:Wish List
${Btn_Logout}                            accessibility_id:Log Out
${Btn_BuyAgain}                          accessibility_id:Buy Again
${Btn_YourOrders}                        xpath=//android.widget.Button[@content-desc="Your Orders"]
${First_Product_In_List}                 xpath=(//android.widget.ImageView)[1]
${Second_Product_In_List}                xpath=(//android.widget.ImageView)[2]
${Third_Product_In_List}                 xpath=(//android.widget.ImageView)[3]
${Fourth_Product_In_List}                xpath=(//android.widget.ImageView)[4]
${Fifth_Product_In_List}                 xpath=(//android.widget.ImageView)[5]
${OrderDate}                             xpath=//android.view.View[contains(@content-desc, "Order date")]
${OrderTotal}                            xpath=//android.view.View[contains(@content-desc, "Order total")]
${InputOrders}                           xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText

*** Keywords ***

Log Out User
  Wait Until Keyword Succeeds  10s  1s
  ...      Click Element    android=new UiScrollable(new UiSelector().scrollable(true).instance(0)).scrollIntoView(new UiSelector().description("Log Out"))
              
Wish List
    Wait Until Element Is Visible        ${Btn_WishList}
    Click Element    ${Btn_WishList}

Your Orders
    Wait Until Element Is Visible    ${Btn_YourOrders} 
    Click Element    ${Btn_YourOrders}

Choose First Product
    [Arguments]    ${OrderDate_Value}    ${OrderTotal_Value}   
    Wait Until Element Is Visible    ${First_Product_In_List}  
    Click Element    ${First_Product_In_List} 

    Wait Until Element Is Visible    ${OrderDate}
    Element Attribute Should Match    ${OrderDate}     content-desc    Order date        ${OrderDate_Value} 
    Element Attribute Should Match    ${OrderTotal}     content-desc    Order total        ${OrderTotal_Value}
 
    Wait Until Element Is Visible    ${First_Product_In_List}  
    Click Element    ${First_Product_In_List} 

    Wait Until Element Is Visible    ${OrderDate}
    Element Attribute Should Match    ${OrderDate}     content-desc    Order date        ${OrderDate_Value} 
    Element Attribute Should Match    ${OrderTotal}     content-desc    Order total        ${OrderTotal_Value}

Search all orders
    [Arguments]    @{Order_Name_Value}
  
    #Default
    Wait Until Element Is Visible      ${First_Product_In_List}
    ${Order_Name}=    Get Element Attribute    ${First_Product_In_List}        content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    ${Order_Name}=    Get Element Attribute    ${Second_Product_In_List}      content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    ${Order_Name}=    Get Element Attribute     ${Third_Product_In_List}     content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[4]

    ${Order_Name}=    Get Element Attribute     ${Fourth_Product_In_List}     content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

     ${Order_Name}=    Get Element Attribute    ${Fifth_Product_In_List}       content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    #OnePlus
    Click Element    ${InputOrders}   
    Input Text    ${InputOrders}      ${Order_Name_Value}[0]
    Press Keycode    66
    
    Wait Until Element Is Visible      ${First_Product_In_List}
    ${Order_Name}=    Get Element Attribute    ${First_Product_In_List}        content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    ${Order_Name}=    Get Element Attribute    ${Second_Product_In_List}      content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]
   
    ${Order_Name}=    Get Element Attribute     ${Third_Product_In_List}     content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    ${Order_Name}=    Get Element Attribute     ${Fourth_Product_In_List}     content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    Go Back
    
    #oneplus
    Click Element    ${InputOrders}  
    Clear Text     ${InputOrders}  
    Input Text   ${InputOrders}      ${Order_Name_Value}[1]
    Press Keycode    66

    Wait Until Element Is Visible      ${First_Product_In_List}
    ${Order_Name}=    Get Element Attribute    ${First_Product_In_List}        content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    ${Order_Name}=    Get Element Attribute    ${Second_Product_In_List}      content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    ${Order_Name}=    Get Element Attribute     ${Third_Product_In_List}     content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    ${Order_Name}=    Get Element Attribute     ${Fourth_Product_In_List}     content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[0]

    Go Back

    #OnePlus 11
    Click Element    ${InputOrders}
    Clear Text     ${InputOrders}  
    Input Text  ${InputOrders}      ${Order_Name_Value}[2]
    Press Keycode    66

    Wait Until Element Is Visible      ${First_Product_In_List}
    ${Order_Name}=    Get Element Attribute    ${First_Product_In_List}        content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[2]

    ${Order_Name}=    Get Element Attribute    ${Second_Product_In_List}      content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[2]

    ${Order_Name}=    Get Element Attribute     ${Third_Product_In_List}     content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[2]

    Go Back

    # Product OnePlus 108
    Click Element    ${InputOrders}   
    Clear Text     ${InputOrders}  
    Input Text    ${InputOrders}      ${Order_Name_Value}[3]
    Press Keycode    66

    Wait Until Element Is Visible      ${First_Product_In_List}
    ${Order_Name}=    Get Element Attribute    ${First_Product_In_List}        content-desc
    Should Contain    ${Order_Name}    ${Order_Name_Value}[3]
