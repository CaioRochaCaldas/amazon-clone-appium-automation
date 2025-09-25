*** Settings ***
Library     AppiumLibrary

*** Variables ***

${Menu_You}                              accessibility_id:You\nTab 2 of 5
${Btn_WishList}                          xpath=//android.widget.Button[@content-desc="Wish List"]
${Menu_Cart}                             accessibility_id:1\nCart\nTab 4 of 5

*** Keywords ***


Menu cart
    Wait Until Element Is Visible        ${Menu_Cart}  
    Click Element    ${Menu_Cart}

Menu You
    Wait Until Element Is Visible        ${Menu_You}
    Click Element    ${Menu_You}

