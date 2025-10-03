*** Settings ***

Library     AppiumLibrary
Library     OperatingSystem

*** Variables ***

#Appium Configurations
${REMOTE_URL}               http://localhost:4723
${PLATFORM_NAME}            Android
${DEVICE_NAME}              Android Emulator
${AUTOMATION_NAME}          UIAutomator2
${APP_LOCATION}             /apps/amazon-clone.apk
${UDID}                     emulator-5554
${AUTO_GRANT_Permissions}   true

*** Keywords ***
Start App
    Open Application    ${REMOTE_URL}
    ...                 platformName=${PLATFORM_NAME} 
    ...                 deviceName=${DEVICE_NAME}
    ...                 automationName=${AUTOMATION_NAME}
    ...                 app=${EXECDIR}${APP_LOCATION} 
    ...                 udid=${UDID}
    ...                 autoGrantPermissions=${AUTO_GRANT_Permissions}

Close App
        Capture Page Screenshot
        Close Application  
