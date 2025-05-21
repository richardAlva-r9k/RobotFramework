*** Settings ***
Documentation    This resource contains the keywords to access to the database
Library           DatabaseLibrary
Library           OperatingSystem
Library           Collections
Library    ../Libraries/ConfigReader.py    path=data/users_csx_bbdd.cfg


*** Variables ***
${DBHost}         ${None}
${DBName}         ${None}
${DBPass}         ${None}
${DBPort}         ${None}
${DBUser}         ${None}

*** Keywords ***
Connect Users BBDD
    ${DBHost}=    Get Config    host    database
    ${DBName}=    Get Config    name    database
    ${DBPass}=    Get Config    password    database
    ${DBPort}=    Get Config    port    database
    ${DBUser}=    Get Config    user    database
    Connect to database   psycopg2   ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}

Check userssessions
    ${usersessions}=    Query    SELECT * FROM userssessions;
    
    
Disconnect Users BBDD
    Disconnect from database