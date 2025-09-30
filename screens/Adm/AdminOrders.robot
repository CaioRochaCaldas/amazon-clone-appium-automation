*** Settings ***
Library     AppiumLibrary
Library    OperatingSystem


*** Variables ***

${First_Products}               xpath=(//android.widget.ImageView[@content-desc])[2]
${OrderDate}                    xpath=//android.view.View[contains(@content-desc, "Order date")]
${OrderTotal}                   xpath=//android.view.View[contains(@content-desc, "Order total")]

*** Keywords ***
CheckOrderInfo
    [Arguments]   ${Product_Name}    
    Wait Until Element Is Visible    ${First_Products}
    Element Attribute Should Match   ${First_Products}     content-desc    ${Product_Name}
    Click Element     ${First_Products} 

    Wait Until Element Is Visible    ${OrderDate}
    Wait Until Element Is Visible    ${OrderTotal}   
    
 