*** Settings ***
Library     AppiumLibrary
Library    OperatingSystem


*** Variables ***

${Select_Product_images}           xpath=//android.view.View[@content-desc="Select product images"]
${Download_File}                   xpath=//android.widget.RelativeLayout
${All_Images}                      xpath=//android.widget.ImageView[@resource-id="com.google.android.apps.photos:id/end_checkmark"]

${Btn_Done}                        xpath=//android.widget.Button[@content-desc="Done"]

${Input_Product_Name}              xpath=//android.widget.ScrollView/android.widget.EditText[1]
${Input_Description}               xpath=//android.widget.ScrollView/android.widget.EditText[2]
${Input_Price}                     xpath=//android.widget.ScrollView/android.widget.EditText[3]

${box_Quantity}                  xpath=//android.widget.ScrollView/android.widget.EditText[4]

${Dropdown_Category}               xpath=//android.widget.Button[@content-desc="Category"]
${Dropdown_Category_Eletronics}    xpath=//android.view.View[@content-desc="Electronics"]
${Btn_Sell}                        accessibility_id=Sell

*** Keywords ***
Create Product
    [Arguments]    ${Input_Product_Name_Value}    ${Input_Description_Value}     ${Input_Price_Value}    ${Input_Quantity_Value} 
    Wait Until Element Is Visible    ${Select_Product_images}
    Click Element     ${Select_Product_images}

    Wait Until Element Is Visible    ${Download_File}
    Click Element    ${Download_File}

    Wait Until Element Is Visible    ${All_Images}  
    Click Element    ${All_Images}  

    Click Element    ${Btn_Done}
  
    Wait Until Element Is Visible     ${Input_Product_Name}  
    Click Element     ${Input_Product_Name}  
    Input Text        ${Input_Product_Name}        ${Input_Product_Name_Value}

    Click Element     ${Input_Description}  
    Input Text        ${Input_Description}         ${Input_Description_Value}  

    Swipe By Percent    50    80    50    20    500
    
    Click Element     ${Input_Price}   
    Input Text         ${Input_Price}              ${Input_Price_Value} 

    Click Element    ${box_Quantity}    
    Input Text        ${box_Quantity}          ${Input_Quantity_Value} 
    
    Click Element     ${Dropdown_Category} 
    Wait Until Element Is Visible       ${Dropdown_Category_Eletronics} 
    Click Element    ${Dropdown_Category_Eletronics}

    Wait Until Element Is Visible     ${Btn_Sell}
    Click Element       ${Btn_Sell} 

