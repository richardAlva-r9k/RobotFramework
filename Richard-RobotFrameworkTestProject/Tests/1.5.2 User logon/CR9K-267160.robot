*** Settings ***
Documentation    Verify that the UI sends the user session cookie next to every request to the backend. if not received, then the user management subsystem shall automatically redirect to login page.
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
Authorization with user cookie
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    API Get all existing users - 200 Response
    API Get all existing users - 401 Error
    Delete Usersession Cookie

