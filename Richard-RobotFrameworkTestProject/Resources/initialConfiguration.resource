*** Settings ***
Documentation    This resource contains the initial configuration for the test suite and teardown steps.

Resource    db.resource
Resource    browser.resource
Resource    requests.resource

*** Keywords ***
Set initial configuration
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}    args=['--incognito']    
    Connect Users BBDD
    Check Open Sessions

Closing Test
    Disconnect Users BBDD
    Close Browser
    Log To Console    Test finalizado

    