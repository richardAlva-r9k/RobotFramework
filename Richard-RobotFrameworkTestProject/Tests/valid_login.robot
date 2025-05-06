*** Settings ***
Documentation    A test suite to check that CSX logs correctly.
Resource    ../Resources/resource.resource
Suite Teardown    Close Browser
Metadata         Version    0.1

*** Test Cases ***
Login with Valid Credentials
    Open Browser To Login Page    ${LOGIN_URL}
    Input Username    ${VALID_USERNAME}
    Input Password    ${VALID_PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open