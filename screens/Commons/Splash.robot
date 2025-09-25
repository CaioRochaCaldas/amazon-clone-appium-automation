*** Settings ***
Library     AppiumLibrary

*** Variables ***

${Amazon_Logo}                              xpath=//android.widget.ImageView

*** Keywords ***

Amazon Logo
    Wait Until Element Is Visible        ${Amazon_Logo} 
    Click Element   ${Amazon_Logo} 