*** Settings ***
Documentation    This test checks that robotframework is able to connecto to CSX DB
Resource    ../Resources/resource.resource
Suite Setup    Connect to database    psycopg2    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Disconnect From Database
Metadata         Version    0.1

*** Test Cases ***
Check database
    ${tablas}=    Query
    ...    SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE';

    Log To Console   Listado de tablas: ${tablas}