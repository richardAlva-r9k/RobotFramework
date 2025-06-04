*** Settings ***
Documentation    Verify that the system prompts for credentials when a user attempts to log on.
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
Prompt For Credentials
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
