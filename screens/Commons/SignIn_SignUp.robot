*** Settings ***

Library     AppiumLibrary

*** Variables ***
${Welcome_Message}                         xpath=//android.view.View[@content-desc="Welcome"]
${toast_UserCreated}                       accessibility_id=User Created, you can sign in now!
${toast_UserAlreadyExists}                 accessibility_id=User with same email already exists

${raio_SignIn_AlreadyACustomer}            xpath=//android.view.View[@content-desc="Sign in. Already a customer?"]/android.widget.RadioButton
${raio_SignUp_CreateAccount}               xpath=//android.view.View[@content-desc="Create account. New to Amazon?"]/android.widget.RadioButton
${raio_SignIp_AlreadyaCustomer}           xpath=//android.view.View[@content-desc="Sign in. Already a customer?"]/android.widget.RadioButton
${raio_SignIp_AlreadyaCustomer_id}            accessibility_id=Sign in. Already a customer?

#Create account
${Input_FirstAndLastName}                  xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[1]
${Input_Create_Email}                      xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[2]
${Input_SetPassword}                       xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[3]
${Btn_Create_account}                      xpath=//android.widget.Button[@content-desc="Create account"]

${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_01}      xpath=(//android.view.View[@content-desc="This field cannot be empty"])[1]
${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_02}          xpath=(//android.view.View[@content-desc="This field cannot be empty"])[2]
${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_03}            xpath=(//android.view.View[@content-desc="This field cannot be empty"])[3]

${Input_SignIn_Email}                      xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[1]
${Input_SignIn_Password}                   xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[2]
${Btn_SignIn_account}                      xpath=//android.widget.Button[@content-desc="Continue"]

*** Keywords ***
Register User Successfully
    [Arguments]          ${Welcome_Message_Value}   ${Input_FirstName_Value}      ${Input_Email_Value}      @{Input_Password_Value} 
    
    Wait Until Element Is Visible   ${raio_SignUp_CreateAccount}    
    #Checking if radio button is selected
    ${element}=    Get WebElement    ${raio_SignUp_CreateAccount}
    ${is_checked}=    Get Element Attribute    ${element}    checked
    Should Be Equal    ${is_checked}    true

    Click Element        ${Input_FirstAndLastName}     
    Input Text           ${Input_FirstAndLastName}     ${Input_FirstName_Value}
    
    Click Element        ${Input_Create_Email}   
    Input Text           ${Input_Create_Email}         ${Input_Email_Value} 
    
    Click Element        ${Input_SetPassword}    
    Input Text           ${Input_SetPassword}          ${Input_Password_Value}

    Click Element        ${Btn_Create_account}

    #${toast_text}=    Get Text     ${toast_UserCreated}  
    #Log    ${toast_text}
    
    Click Element    ${raio_SignIp_AlreadyaCustomer_id}  
    Wait Until Element Is Visible  ${Input_SignIn_Email}    10s

    ${InputValueEmail}=    Get Element Attribute   ${Input_SignIn_Email}    text
    Should Be Equal    ${InputValueEmail}   ${Input_Email_Value}

   # ${InputValuePassword}=    Get Element Attribute   ${Input_SignIn_Password}    text
   # ${InputValuePassword}=    Set Variable    ${InputValuePassword}[0]
   # Should Be Equal    ${InputValuePassword}    ${Input_Password_Value}

    Click Element    ${Btn_SignIn_account}  

Registration Rejected: Empty Name, Empty Email and Empty Password
    [Arguments]          ${Welcome_Message_Value}      ${Error_Message_Value}
    
    Wait Until Element Is Visible   ${raio_SignUp_CreateAccount}    60s
    ${element}=    Get WebElement    ${raio_SignUp_CreateAccount}
    ${is_checked}=    Get Element Attribute    ${element}    checked
    Should Be Equal    ${is_checked}    true

    #Wrong data: False,False,False    
    Click Element        ${Btn_Create_account}

    Wait Until Element Is Visible    ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_01}
    Element Attribute Should Match      ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_01}  content-desc      ${Error_Message_Value}

    Wait Until Element Is Visible    ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_02}
    Element Attribute Should Match      ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_02}  content-desc      ${Error_Message_Value}

    Wait Until Element Is Visible    ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_03}
    Element Attribute Should Match     ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_03}     content-desc    ${Error_Message_Value}

Registration Rejected: Valid Name,Invalid Email
    [Arguments]          ${Welcome_Message_Value}   ${Input_FirstName_Value}     ${Input_Password_Value} 
    
    Wait Until Element Is Visible   ${raio_SignUp_CreateAccount}    60s
    ${element}=    Get WebElement    ${raio_SignUp_CreateAccount}
    ${is_checked}=    Get Element Attribute    ${element}    checked
    Should Be Equal    ${is_checked}    true

    #Wrong data: True,False=empty
    Click Element        ${Input_FirstAndLastName}     
    Input Text           ${Input_FirstAndLastName}     ${Input_FirstName_Value}

    Click Element        ${Input_SetPassword}    
    Input Text           ${Input_SetPassword}          ${Input_Password_Value}

    Click Element        ${Btn_Create_account}

    Wait Until Element Is Visible    ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_01}
    Page Should Not Contain Element    ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_02}
    Page Should Not Contain Element    ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_03}


Registration Rejected: Valid Name, Valid Email and Invalid Password less them 6
    [Arguments]          ${Welcome_Message_Value}   ${Input_FirstName_Value}      ${Input_Email_Value}      ${Input_Password_Value} 
    
    Wait Until Element Is Visible   ${raio_SignUp_CreateAccount}    60s
    ${element}=    Get WebElement    ${raio_SignUp_CreateAccount}
    ${is_checked}=    Get Element Attribute    ${element}    checked
    Should Be Equal    ${is_checked}    true

    #Wrong data          True,true,False=password<6

    Click Element        ${Input_FirstAndLastName}     
    Input Text           ${Input_FirstAndLastName}     ${Input_FirstName_Value}

    Click Element        ${Input_Create_Email}   
    Input Text           ${Input_Create_Email}         ${Input_Email_Value}  
    
    Click Element        ${Input_SetPassword}    
    Input Text           ${Input_SetPassword}          ${Input_Password_Value}

    Click Element        ${Btn_Create_account}

    Page Should Not Contain Element   ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_01}
    Page Should Not Contain Element   ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_02}
    Page Should Not Contain Element   ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_03}


Fail to Register User with Already Registered Email
    [Arguments]          ${Welcome_Message_Value}   ${Input_FirstName_Value}      ${Input_Email_Value}      ${Input_Password_Value} 
    
    Wait Until Element Is Visible   ${raio_SignUp_CreateAccount}    60s
    ${element}=    Get WebElement    ${raio_SignUp_CreateAccount}
    ${is_checked}=    Get Element Attribute    ${element}    checked
    Should Be Equal    ${is_checked}    true

    Click Element        ${Input_FirstAndLastName}     
    Input Text           ${Input_FirstAndLastName}     ${Input_FirstName_Value}

    Click Element        ${Input_Create_Email}   
    Input Text           ${Input_Create_Email}         ${Input_Email_Value}  

    Click Element        ${Input_SetPassword}    
    Input Text           ${Input_SetPassword}          ${Input_Password_Value}

    Click Element        ${Btn_Create_account}

    Page Should Not Contain Element    ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_01}
    Page Should Not Contain Element   ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_02}
    Page Should Not Contain Element   ${Text_Contentdesc_Input_ThisFieldCannotBeEmpty_03}

Login With Valid Credentials
    [Arguments]    ${Input_Email_Value}    ${Input_Password_Value}
    
    Wait Until Element Is Visible   ${raio_SignIp_AlreadyaCustomer}    60s
    Click Element    ${raio_SignIp_AlreadyaCustomer}  
    
    #${element}=    Get WebElement    ${raio_SignIp_AlreadyaCustomer}  
    #${is_checked}=    Get Element Attribute    ${element}    checked
    #Should Be Equal    ${is_checked}    true

    Wait Until Element Is Visible  ${Input_SignIn_Email}    10s
    Click Element    ${Input_SignIn_Email}    
    Input Text       ${Input_SignIn_Email}      ${Input_Email_Value} 

    Click Element    ${Input_SignIn_Password}  
    Input Text       ${Input_SignIn_Password}      ${Input_Password_Value}

    Click Element    ${Btn_SignIn_account}  

App returns to the Login Screen
    Wait Until Element Is Visible      ${Welcome_Message}     30s
