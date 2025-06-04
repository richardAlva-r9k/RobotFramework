*** Settings ***
Documentation    This resource contains the keywords to access to the databases
Library           DatabaseLibrary
Library           OperatingSystem
Library           Collections
Library    ../Libraries/ConfigReader.py    path=data/users_csx_bbdd.cfg

*** Keywords ***
Connect Users BBDD
    ${DBHost}=    Get Config    host    database
    ${DBName}=    Get Config    name    database
    ${DBPass}=    Get Config    password    database
    ${DBPort}=    Get Config    port    database
    ${DBUser}=    Get Config    user    database
    Connect to database   psycopg2   ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}

Check Open Sessions
    ${query}=    Query    SELECT COUNT(*) FROM usersessions WHERE status IS NOT NULL;
    ${count}=    Set Variable    ${query[0][0]}
    IF    ${count} > 0
        Close Open Sessions      
    END
    
Close Open Sessions
    Execute Sql String    DELETE FROM usersessions;

Disconnect Users BBDD
    Execute Sql String    DELETE FROM usersessions;
    Disconnect From Database

Check Usersession Cookie BBDD
    ${query}=    Query    SELECT session_id FROM usersessions;
    RETURN    ${query[0][0]}