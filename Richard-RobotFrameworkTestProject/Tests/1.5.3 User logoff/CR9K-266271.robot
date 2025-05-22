*** Settings ***
Documentation    Verify that a logged on user shall be able to logoff at anytime during their shitf
Resource    ../../Resources/initialConfiguration.resource
Suite Setup   Set initial configuration
Suite Teardown  Closing Test
Metadata         Version    1.0

*** Variables ***
${VALID_USERNAME}    supervisor
${VALID_PASSWORD}    supervisor
${ROLE}    Chief Dispatcher
${POSITION}    Florence

*** Test Cases ***
Log off at any time
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Select Role And Position    role=${ROLE}    position=${POSITION}
    Cancel Logoff
    Confirm Logoff
    