*** Settings ***
Library     AppiumLibrary

*** Variables ***
${Btn_Add_Product}                          xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button

*** Keywords ***
Click Add Product Widget 
    Wait Until Element Is Visible        ${Btn_Add_Product} 
    Click Element                         ${Btn_Add_Product} 