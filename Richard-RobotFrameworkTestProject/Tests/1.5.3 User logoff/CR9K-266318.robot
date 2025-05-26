*** Settings ***
Documentation    Verify that the user is able to cancel the logoff process
Resource    ../../Resources/initialConfiguration.resource
Suite Setup   Set initial configuration
Suite Teardown  Closing Test
Metadata         Version    1.0

*** Variables ***
${VALID_USERNAME}    supervisor
${VALID_PASSWORD}    supervisor
${ROLE}    Chief Dispatcher
${POSITION}    Florence
${HOS}    False

*** Test Cases ***
Cancel logoff process
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Select Role And Position    ${ROLE}    ${POSITION}    ${HOS}
    Cancel Logoff    HOS=${HOS}    CANCEL_LOGOFF=True    CLOSE_LOGOFF_WINDOW=False
    Cancel Logoff    HOS=${HOS}    CANCEL_LOGOFF=False    CLOSE_LOGOFF_WINDOW=True
    