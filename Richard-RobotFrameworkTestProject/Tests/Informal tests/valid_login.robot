*** Settings ***
Documentation    A test suite to check that CSX logs correctly.
Resource    ../../Resources/initialConfiguration.resource
Suite Setup   Set initial configuration
Suite Teardown  Close Test
Metadata         Version    0.1

*** Test Cases ***
Log in as supervisor
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
