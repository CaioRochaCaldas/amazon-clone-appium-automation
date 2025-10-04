*** Settings ***

Library     AppiumLibrary
Library     OperatingSystem

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
