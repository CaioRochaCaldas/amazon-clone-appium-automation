*** Settings ***

Library     AppiumLibrary

*** Variables ***
${Product_Title_Not_Found}            xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[3][not(*)]
${Product}                            xpath=(//android.widget.ImageView)[1]

*** Keywords ***
Click First Search Result
    [Arguments]          ${Search_value}
    ${Product_Title_Link}=    Set Variable    xpath=(//android.widget.ImageView[contains(@content-desc, '${Search_value}')])[1]

    Page Should Contain Element    ${Product_Title_Link} 
    Click Element                  ${Product_Title_Link} 
    
   
No Products Found
    Page Should Contain Element    ${Product_Title_Not_Found}

     



    
    
    
