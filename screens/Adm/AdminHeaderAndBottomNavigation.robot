*** Settings ***
Library     AppiumLibrary

*** Variables ***

${Btn_Logout}                              xpath=//android.widget.ImageView[@content-desc="Admin"]/android.widget.Button

*** Keywords ***


Log Out Adm
    Wait Until Element Is Visible       ${Btn_Logout}       15s
    Click Element                        ${Btn_Logout}   
    

