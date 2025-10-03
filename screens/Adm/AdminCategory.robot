*** Settings ***
Library     AppiumLibrary

*** Variables ***
${Btn_Delete_Product}                          xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.view.View[2]/android.view.View/android.widget.ImageView[1]/android.widget.Button

*** Keywords ***
Select Product
    [Arguments]          ${Product_Name}
    Wait Until Element Is Visible      //android.widget.ImageView[@content-desc="${Product_Name}"]
    Click Element                       ${Btn_Delete_Product}