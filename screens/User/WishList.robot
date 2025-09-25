*** Settings ***
Library     AppiumLibrary

*** Variables ***
${Screen_Title}                       xpath=//android.view.View[@content-desc="Your Wish List"]
${Btn_Remove_Product_at_WishList}            xpath=(//android.widget.ImageView//android.widget.Button)[2]
${Btn_Add_to_cart}                    accessibility_id=Add to cart
${First_Product}                         xpath=(//android.widget.ImageView)[1]
${Empty_WishList}                         xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/*


*** Keywords ***
Checking product at wishList
    [Arguments]    ${Product_Name_Value}
    Wait Until Element Is Visible       ${Screen_Title} 
    Wait Until Element Is Visible       ${First_Product}
    
    ${Product_Name_Content}          Get Element Attribute    ${first_product}    content-desc
    Should Contain      ${Product_Name_Content}    ${Product_Name_Value}

Remove product From wishList
     Wait Until Element Is Visible      ${Btn_Remove_Product_at_WishList}
     Click Element                      ${Btn_Remove_Product_at_WishList}
     Page Should Not Contain Element     ${First_Product}
Add product From wishList To Cart
     Wait Until Element Is Visible        ${Btn_Add_to_cart} 
     Click Element                        ${Btn_Add_to_cart}
     Go Back

Check Wish List Is Empty
    ${child_count}=    Get Matching Xpath Count    ${Empty_WishList}
    Should Be Equal As Integers    ${child_count}    0
    Go Back
        
    
     
     
    
    
    
