*** Settings ***
Documentation    This resource contains the keywords to access to CSX main page and also to log in the user
Library    Browser
Library           OperatingSystem
Library           Collections

*** Variables ***
${LOGIN_URL}    http://127.0.0.1.nip.io/
${BROWSER}    Chromium
${VALID_USERNAME}    supervisor
${VALID_PASSWORD}    supervisor
${INVALID_USERNAME}    invalid
${INVALID_PASSWORD}    invalid
${HEADLESS}    false
${SLOWMO}    0.5

*** Keywords ***
Open Login Page
    [Arguments]    ${LOGIN_URL}
    Open Url    ${LOGIN_URL}
    Check Login Page Should Be Loaded    Sign in to CSX CoreSystem

Open Url
    [Arguments]    ${url}
    New Context
    New Page    ${url}
    Set Viewport Size   1920    1080
    
Check Login Page Should Be Loaded
    [Arguments]    ${expected_title}
    Wait For Elements State    css=div.login-pf-page    visible
    ${title}=    Get Title
    Should Be Equal    ${title}    ${expected_title}

Input Login Valid Credentials
    [Arguments]    ${username}    ${password}
    Fill Text    input[name="username"]    ${username}
    Fill Text    input[name="password"]    ${password}
    Click    id=kc-login
    Main Page Should Be Open    Core System

Role&Position Page Should Be Open
    [Arguments]    ${expected_title}
    Wait For Elements State       ix-blind.rootPane.blind-outline.hydrated    visible
    ${title}=    Get Title
    Should Be Equal    ${title}    ${expected_title}

Select Role And Position
    [Arguments]    ${role}    ${position}
    Wait For Elements State    ix-select >> nth=0
    Click    ix-select >> nth=0
    Wait For Elements State    ix-select-item[ng-reflect-value="${role}"]
    Click    ix-select-item[ng-reflect-value="${role}"]
    Wait For Elements State    ix-select >> nth=1
    Click    ix-select >> nth=1
    Wait For Elements State    ix-select-item[ng-reflect-value="${position}"]
    Click    ix-select-item[ng-reflect-value="${position}"]
    Wait For Elements State    text=Start session
    Click    text=Start session
    Main Page Should Be Open    Core System

Main Page Should Be Open
    [Arguments]    ${expected_title}
    Wait For Elements State    gridster-item#DashBoard_mainCanvas    visible
    ${title}=    Get Title
    Should Be Equal    ${title}    ${expected_title}