*** Settings ***
Documentation    Verify that the UI shall periodically ask backend about user information, including permissions, to check the user session is valid
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
UI periodically asks information about user permissions
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Select Role And Position    ${ROLE}    ${POSITION}    ${HOS}
    Check API Session Request