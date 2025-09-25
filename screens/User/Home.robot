*** Settings ***
Library     AppiumLibrary

*** Variables ***
${Input_search}                          xpath=//android.widget.EditText
${Image_DealOfTheDayProduct}             xpath=//android.widget.ScrollView/android.widget.ImageView

${Menu_You}                              accessibility_id=You\nTab 2 of 5
${Btn_WishList}                          xpath=//android.widget.Button[@content-desc="Wish List"]

${Menu_Cart}                             accessibility_id=1\nCart\nTab 4 of 5

*** Keywords ***
Search Product
    [Arguments]          ${Search_value}
    Wait Until Element Is Visible        ${Input_search} 
    Click Element        ${Input_search}
    Input Text    ${Input_search}    ${SEARCH_VALUE}
    Press Keycode    66

Select Deal of the Day Product
    Wait Until Keyword Succeeds  60s  2s  Element Should Be Enabled  ${Image_DealOfTheDayProduct}
    Click Element  ${Image_DealOfTheDayProduct} 

Menu cart
    Wait Until Element Is Visible        ${Menu_Cart}  
    Click Element    ${Menu_Cart}

Menu You
    Wait Until Element Is Visible        ${Menu_You}
    Click Element    ${Menu_You}

Home Screen elements
    Page Should Not Contain Element   ${Menu_Cart}