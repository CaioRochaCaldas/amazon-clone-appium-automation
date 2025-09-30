*** Settings ***
Library     AppiumLibrary

*** Variables ***
${TopListedProduct}                     xpath=(//android.widget.ImageView)[1]
${Text_Empty_Cart}                      xpath=//android.view.View[@content-desc="Your Amazon Cart is empty"]
${Btn_Add_More_Product}                 xpath=//android.widget.ImageView/android.view.View[2]
${Btn_Remove_More_Product}              xpath=//android.widget.ImageView/android.view.View[1]
${Text_SubTotal_Value}                  xpath=//android.view.View[contains(@content-desc, ".")]
${Btn_Delete}                           xpath=//android.view.View[@content-desc="Delete"]
${Btn_SaveForLater}                     xpath=//android.view.View[@content-desc="Save for later"]
${Btn_SaveForLater_MovetoCart}          xpath=//android.view.View[@content-desc="Move to cart"]
${Input_FlatHouseBuilding}              xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[1]
${Input_AreaStreet}                     xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[2]
${Input_Pincode}                        xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[3]
${Input_TownCity}                       xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[4]
${Btn_OrderWithPlay}                  xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.Button
${Checkbox_I_AgreeWithGooglePay}        xpath=//android.widget.CheckBox[@content-desc="Get Google Pay emails with helpful product tips and current promotions. Unsubscribe anytime at wallet.google.com."]
${Btn_Pay}                              xpath=//android.widget.Button[@text="Pay"]
${Btn_ProceedToBuy}                     xpath=//android.widget.Button[@content-desc="Proceed to Buy (1 item)"]

*** Keywords ***
Check Product in Cart
    Page Should Not Contain Element    ${Text_Empty_Cart}
    Wait Until Element Is Visible       ${TopListedProduct}  

Buy Product
    Wait Until Element Is Visible        ${Btn_ProceedToBuy} 
    Click Element                    ${Btn_ProceedToBuy} 

Adress
    [Arguments]    ${Flat_House_Building}    ${Area_Street}     ${Pincode}    ${Town_City}
    Wait Until Element Is Visible    ${Input_FlatHouseBuilding}  
    Click Element    ${Input_FlatHouseBuilding}   
    Input Text    ${Input_FlatHouseBuilding}      ${Flat_House_Building}

    Click Element   ${Input_AreaStreet} 
    Input Text    ${Input_AreaStreet}     ${Area_Street}

    Click Element     ${Input_Pincode}  
    Input Text    ${Input_Pincode}    ${Pincode} 

    Click Element    ${Input_TownCity}
    Input Text    ${Input_TownCity}    ${Town_City}
    
    Click Element    ${Btn_OrderWithPlay}

Pay With Google Pay
    #Wait Until Element Is Visible     ${Checkbox_I_AgreeWithGooglePay}    100s
    #Click Element    ${Checkbox_I_AgreeWithGooglePay}
    Wait Until Element Is Visible     ${Btn_Pay}    100s
    Click Element    ${Btn_Pay} 


Changing Product Quantity
    Wait Until Element Is Visible    ${Btn_Add_More_Product}
    Click Element                    ${Btn_Add_More_Product}
    
    #Quatity of Value 2 
    Wait Until Element Is Visible       ${Text_SubTotal_Value}  
    Element Attribute Should Match    ${Text_SubTotal_Value}    content-desc    79,998.00

    #Quatity of Value 1 
    Wait Until Element Is Visible        ${Btn_Remove_More_Product}
    Click Element    ${Btn_Remove_More_Product}

    Wait Until Element Is Visible        ${Text_SubTotal_Value} 
    Element Attribute Should Match    ${Text_SubTotal_Value}    content-desc    39,999.00

    
    #Quatity of Value 0 = Remove product from cart
    Click Element    ${Btn_Remove_More_Product}
    Wait Until Element Is Visible    ${Text_Empty_Cart}

Remove Product From Cart Using Button
    Wait Until Element Is Visible            ${Btn_Delete}
    Click Element                            ${Btn_Delete}
    Wait Until Element Is Visible    ${Text_Empty_Cart}
Remove Product From Cart Using Swipe
    Wait Until Element Is Visible            ${Btn_Delete}
    Swipe   start_x=369    start_y=1189    end_x=1037    end_y=1202
    Wait Until Element Is Visible    ${Text_Empty_Cart}    10s

Saving product for later with button
    Wait Until Element Is Visible            ${Btn_SaveForLater} 
    Click Element        ${Btn_SaveForLater}
    Swipe   start_x=502    start_y=1571  end_x=498    end_y=788
    Wait Until Element Is Visible    ${Btn_SaveForLater_MovetoCart}  

Saving product for later with swipe
    Wait Until Element Is Visible            ${Btn_SaveForLater} 
    Swipe   start_x=977    start_y=1179  end_x=170    end_y=1179
    Wait Until Element Is Visible    ${Text_Empty_Cart}
    Swipe   start_x=502    start_y=1571  end_x=498    end_y=788
    Wait Until Element Is Visible    ${Btn_SaveForLater_MovetoCart}  
    