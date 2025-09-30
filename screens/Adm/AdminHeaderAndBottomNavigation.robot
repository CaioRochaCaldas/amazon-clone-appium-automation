*** Settings ***
Library     AppiumLibrary

*** Variables ***

${Btn_Logout_Adm}                               xpath=//android.widget.Button
${MenuOrders}                               accessibility_id=Orders\nTab 4 of 4
*** Keywords ***


LogOut Adm
    Wait Until Element Is Visible       ${Btn_Logout_Adm}       15s
    Click Element                       ${Btn_Logout_Adm}   
Menu Orders
    Wait Until Element Is Visible       ${MenuOrders}         15s
    Click Element                       ${MenuOrders}    

