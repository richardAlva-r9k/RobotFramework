*** Settings ***
Resource    db.resource
Resource    browser.resource

*** Variables ***

*** Keywords ***
Set initial configuration
    New Browser    browser=chromium    headless=false    slowMo=0.5
    Connect Users BBDD
    Check Open Sessions

Close Test
    Disconnect Users BBDD
    Close Browser
    Log To Console    Test finalizado