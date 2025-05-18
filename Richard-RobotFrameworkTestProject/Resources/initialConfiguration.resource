*** Settings ***
Resource    db.resource
Resource    browser.resource

*** Variables ***

*** Keywords ***
Set initial configuration
    Connect Users BBDD   
    
Close test
    Disconnect From All Databases