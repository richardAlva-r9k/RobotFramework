*** Settings ***
Resource    db.resource
Resource    browser.resource

*** Variables ***

*** Keywords ***
Set initial configuration
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}    args=['--incognito']    
    Connect Users BBDD
    Check Open Sessions

Closing Test
    Disconnect Users BBDD
    Close Browser
    Log To Console    Test finalizado

    