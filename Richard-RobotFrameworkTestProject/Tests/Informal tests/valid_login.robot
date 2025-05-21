*** Settings ***
Documentation    A test suite to check that CSX logs correctly.
Resource    ../../Resources/browser.resource
Suite Setup    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}
Suite Teardown    Close Browser
Metadata         Version    0.1

*** Test Cases ***
Log in as supervisor
    Open Login Page    ${LOGIN_URL}
    Input Login Valid Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
