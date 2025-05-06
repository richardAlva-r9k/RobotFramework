*** Settings ***
Documentation    Tests to verify that account withdrawals succeed and
...              fail correctly depending on users credentials.
Library    SeleniumLibrary    timeout=1    implicit_wait=2
Library           DatabaseLibrary
Library           OperatingSystem
Library           Collections

*** Variables ***
${LOGIN_URL}    http://127.0.0.1.nip.io/
${BROWSER}    Edge
${VALID_USERNAME}    supervisor
${VALID_PASSWORD}    supervisor
${INVALID_USERNAME}    invalid
${INVALID_PASSWORD}    invalid

${DBHost}         localhost
${DBName}         users_csx
${DBPass}         ""
${DBPort}         5432
${DBUser}         postgres

*** Keywords ***
Open Url
    [Arguments]    ${browser}    ${url}
    Create WebDriver    ${browser}
    Maximize Browser Window
    Go To    ${url}
    Wait For Condition    return !!document.body

Open Url With Edge
    [Arguments]    ${url}
    Open Url    Edge    ${url}

Open Browser to Login Page
    [Arguments]    ${url}
    Open Url With Edge    ${url}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Sign in to CSX CoreSystem

Input Username
    [Arguments]    ${username}
    Input Text    username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Button    kc-login

Welcome Page Should Be Open
    Location Should Be    ${LOGIN_URL}
    Title Should Be    Core System
    
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Open Browser To Login Page    ${LOGIN_URL}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Sleep    0.1
    Login Should Have Failed
    [Teardown]    Close Browser

Login Should Have Failed
    Page Should Contain Element    xpath=//*[@id="input-error"]
