*** Settings ***
Documentation    This test checks that robotframework is able to connecto to CSX DB
Resource    ../Resources/db.resource
Resource    ../Resources/initialConfiguration.resource

Suite Setup    Set initial configuration
Suite Teardown    Close test
Metadata         Version    0.1

*** Test Cases ***
Check database
    ${usersessions}=    Query
    ...    SELECT * FROM usersessions;

    Log To Console   Listado de sesiones abiertas: ${usersessions}