*** Settings ***
Documentation    Verify that a logged on user shall be able to logoff at anytime during their shitf
Resource    ../../Resources/initialConfiguration.resource
Suite Setup   Set initial configuration
Suite Teardown  Closing Test
Metadata         Version    1.0

*** Test Cases ***
Log in as supervisor
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Select Role And Position    role=Chief Dispatcher    position=Florence
    