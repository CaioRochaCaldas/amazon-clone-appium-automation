*** Settings ***
Library     AppiumLibrary

*** Variables ***
${Btn_Add_Product}                                 xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button
${Toast_Product_Added}                                         accessibility_id=Product added successfully!
${ElectronicsCategory}                                         accessibility_id=Electronics

*** Keywords ***
Toast Product added successfully
    Wait Until Element Is Visible        ${Toast_Product_Added}

Electronics category
     Wait Until Element Is Visible       ${ElectronicsCategory}   
     Click Element                       ${ElectronicsCategory}   