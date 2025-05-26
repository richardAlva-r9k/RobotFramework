*** Settings ***
Documentation    Verify that when the user works under hours of service, the system shall ask for confirmation password to complete the logoff
Resource    ../../Resources/initialConfiguration.resource
Suite Setup   Set initial configuration
Suite Teardown  Closing Test
Metadata         Version    1.0

*** Variables ***
${VALID_USERNAME}    supervisor
${VALID_PASSWORD}    supervisor
${ROLE}    Dispatcher
${POSITION}    FE
${HOS}    True

*** Test Cases ***
Logoff HOS user type
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Select Role And Position    ${ROLE}    ${POSITION}    ${HOS}
    Cancel Logoff    HOS=${HOS}    Mode="Incorrect Password Logoff HOS"
    Cancel Logoff    HOS=${HOS}    Mode="Close HOS Logoff Window"
    Confirm Logoff    ${HOS}