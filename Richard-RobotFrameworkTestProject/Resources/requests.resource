*** Settings ***
Documentation    This resource contains all the keywords related to the requests library which interact with CSX application.

Library    Browser
Library    OperatingSystem
Library    Collections
Library    DateTime
Library    String
Library    RequestsLibrary

Resource   variables.resource
Resource   db.resource
Resource   browser.resource

*** Variables ***
${API_URL}    http://127.0.0.1.nip.io/

*** Keywords ***

API POST Method
    [Arguments]    ${mode}="withCookie"    ${endpoint}=None
    Create Session    mysession    ${API_URL}
    IF    ${mode} == "noCookie"
        ${response}=    Run Keyword And Ignore Error    POST On Session   mysession    url=${endpoint}
    ELSE IF    ${mode} == "withCookie"
        ${cssid}=    Retrieve Usersession Cookie
        ${headers}=    Create Dictionary    Cookie=CSSID=${cssid}
        ${response}=    POST On Session   mysession    url=${endpoint}    headers=${headers}
    END
    RETURN    ${response}
    
API GET Method
    [Arguments]    ${mode}="withCookie"    ${endpoint}=None
    Create Session    mysession    ${API_URL}
    IF    ${mode} == "noCookie"
        ${response}=    Run Keyword And Ignore Error    GET On Session   mysession    url=${endpoint}
    ELSE IF    ${mode} == "withCookie"
        ${cssid}=    Retrieve Usersession Cookie
        ${headers}=    Create Dictionary    Cookie=CSSID=${cssid}
        ${response}=    GET On Session   mysession    url=${endpoint}    headers=${headers}
    END
    RETURN    ${response}

API Get all existing users - 200 Response
    ${response}=    API GET Method    mode="withCookie"    endpoint=/usrmgr/bff/users?roleId=Chief%20Dispatcher&positions=Florence&roleIsHos=false&startTime=undefined
    Should Be Equal As Strings    ${response.status_code}    200

API Get all existing users - 401 Error
    ${response}=    API GET Method    mode="noCookie"    endpoint=/usrmgr/bff/users?roleId=Chief%20Dispatcher&positions=Florence&roleIsHos=false&startTime=undefined
    Should Be Equal As Strings    ${response[0]}    FAIL
    Should Contain    ${response[1]}    HTTPError: 401 Client Error

API Get Current User Session Information - 200 Response    
    ${response}=    API POST Method    mode="withCookie"    endpoint=usrmgr/sessions/session?tz=Europe%2FBerlin
    Should Be Equal As Strings    ${response.status_code}    200
