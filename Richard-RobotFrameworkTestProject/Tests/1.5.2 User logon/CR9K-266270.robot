*** Settings ***
Documentation    Verify that on logon the UI stores a cookie received from the backend as a reference to the user session in the backend
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
Cookie With Reference To The User Session Stored
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Check Usersession Cookie
