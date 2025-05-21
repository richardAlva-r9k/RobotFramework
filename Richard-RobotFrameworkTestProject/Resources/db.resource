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

Check Open Sessions
    ${query}=    Query    SELECT COUNT(*) FROM usersessions WHERE status IS NOT NULL;
    ${count}=    Set Variable    ${query[0][0]}
    Log To Console   Número de sesiones abiertas: ${count}
    IF    ${count} > 0
        Close Open Sessions
    ELSE
        Log To Console   No hay sesiones abiertas        
    END
    
Close Open Sessions
    Log To Console   Hay sesiones abiertas, se procederá a cerrarlas
    Execute Sql String    DELETE FROM usersessions;
    Log To Console   Sesiones cerradas

Disconnect Users BBDD
    Execute Sql String    DELETE FROM usersessions;
    Log To Console   Cerrando sesiones abiertas
    Disconnect From Database