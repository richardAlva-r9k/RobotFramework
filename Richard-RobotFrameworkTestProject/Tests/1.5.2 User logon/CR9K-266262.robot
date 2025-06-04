*** Settings ***
Documentation    Verify that the system displays an error message and allows re-entry when an incorrect password is provided.
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
Incorrect Password Handling    
    Open Login Page    ${LOGIN_URL}
    Input Login Incorrect Credentials    Mode="Incorrect Username"
    Input Login Incorrect Credentials    Mode="Incorrect Password"
