*** Settings ***
Resource    db.resource
Resource    browser.resource

*** Variables ***

*** Keywords ***
Set initial configuration
    New Browser    browser=chromium    headless=true
    #Connect Users BBDD   
    
Close test
    #Disconnect From All Databases