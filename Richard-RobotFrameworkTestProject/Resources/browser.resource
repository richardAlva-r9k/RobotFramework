*** Settings ***
Documentation    This resource contains all the keywords related to the browser library which interact with CSX application.

Library    Browser
Library    OperatingSystem
Library    Collections
Library    DateTime
Library    String

Resource   variables.resource
Resource   db.resource

*** Keywords ***
Open Login Page
    [Arguments]    ${LOGIN_URL}
    Open Url    ${LOGIN_URL}
    Login Page Should Be Loaded    ${LOGIN_TITLE}

Open Url
    [Arguments]    ${url}
    New Context
    New Page    ${url}
    Set Viewport Size   1920    1080
    
Login Page Should Be Loaded
    [Arguments]    ${expected_title}
    Wait For Elements State    ${LOGIN_PAGE_ELEMENT}    visible
    Expected Title    ${expected_title}

Expected Title
    [Arguments]    ${expected_title}
    ${title}=    Get Title
    Should Be Equal    ${title}    ${expected_title}

Input Login Valid Credentials
    [Arguments]    ${username}    ${password}
    Input Username Login/Logoff    ${username}
    Input Password Login/Logoff   ${password}
    Click Submit Button
    Role&Position Page Should Be Open    ${MAIN_TITLE}

Input Username Login/Logoff
    [Arguments]    ${username}
    Wait For Elements State    ${INPUT_LOGIN_USERNAME}    visible
    Click    ${INPUT_LOGIN_USERNAME}
    Fill Text    ${INPUT_LOGIN_USERNAME}    ${EMPTY}
    Fill Text    ${INPUT_LOGIN_USERNAME}    ${username}

Input Password Login/Logoff
    [Arguments]    ${password}
    Wait For Elements State    ${INPUT_LOGIN_PASSWORD}    visible
    Click    ${INPUT_LOGIN_PASSWORD}
    Fill Text    ${INPUT_LOGIN_PASSWORD}    ${EMPTY}
    Fill Text    ${INPUT_LOGIN_PASSWORD}    ${password}

Click Submit Button
    Wait For Elements State    ${INPUT_LOGIN_SUBMIT}    visible
    Click    ${INPUT_LOGIN_SUBMIT}

Role&Position Page Should Be Open
    [Arguments]    ${expected_title}
    Wait For Elements State       ${IX-BLIND_ROLE&POSITION}    visible
    Expected Title    ${expected_title}

Select Role And Position
    [Arguments]    ${role}    ${position}    ${HOS}
    Select A Role    ${role}
    Select A Position    ${position}
    Run Keyword If    ${HOS} == True    Set Hour Of Service
    Start Session  
    Main Page Should Be Open    ${MAIN_TITLE}

Select A Role    
    [Arguments]    ${role} 
    Wait For Elements State    ${IX-SELECT_ROLE}    
    Click    ${IX-SELECT_ROLE}
    ${IXL-SELECT-ITEM_ROLE} =   Get Selector For IX-SELECT-ITEM_ROLE    ${role}
    Wait For Elements State    ${IXL-SELECT-ITEM_ROLE}    visible
    Click    ${IXL-SELECT-ITEM_ROLE}

Select A Position
    [Arguments]    ${position}
    Wait For Elements State    ${IX-SELECT_POSITION}
    Click    ${IX-SELECT_POSITION}
    ${IXL-SELECT-ITEM_POSITION} =  Get Selector For IX-SELECT-ITEM_POSITION    ${position}
    Wait For Elements State    ${IXL-SELECT-ITEM_POSITION}    visible
    Click    ${IXL-SELECT-ITEM_POSITION}

Start Session
    Wait For Elements State    ${START_SESSION_BUTTON}    visible
    Click    ${START_SESSION_BUTTON} 
    
Main Page Should Be Open
    [Arguments]    ${expected_title}
    Wait For Elements State    ${MAIN_PAGE_ELEMENT}    visible
    Expected Title    ${expected_title}

Click Logoff Button
    Wait For Elements State    ${LOGOFF_BUTTON}    visible
    Click    ${LOGOFF_BUTTON}

Logoff
    [Arguments]    ${HOS}
    Click Logoff Button
    Wait For Elements State    ${CONTINUE_LOGOFF}    visible    
    IF    ${HOS} == True
        Open HOS Logoff Window
        Input Password Login/Logoff    ${VALID_PASSWORD}          
        Click Submit Button
    ELSE
        Click    ${CONTINUE_LOGOFF}
    END    
    Login Page Should Be Loaded    ${LOGIN_TITLE}

Click Continue Logoff Button
    Wait For Elements State    ${CONTINUE_LOGOFF}    visible
    Click    ${CONTINUE_LOGOFF}

Cancel Logoff
    [Arguments]    ${HOS}=False    ${Mode}="Cancel Logoff Window"
    Click Logoff Button
    Run Keyword If    ${HOS} == False and ${Mode} == "Cancel Logoff Window"    Cancel Logoff Window Mode
    ...    ELSE IF    ${HOS} == False and ${Mode} == "Close Logoff Window"    close Logoff Window Mode
    ...    ELSE IF    ${HOS} == True and ${Mode} == "Incorrect Password Logoff HOS"    Incorrect Password Logoff HOS
    ...    ELSE IF    ${HOS} == True and ${Mode} == "Close HOS Logoff Window"    Close HOS Logoff Window Mode
    ...    ELSE                                                            Cancel Logoff Window Mode      

Cancel Logoff Window Mode
    Click Cancel Logoff Window Button
    Main Page Should Be Open    ${MAIN_TITLE}

Click Cancel Logoff Window Button
    Wait For Elements State    ${LOGOUT_CANCEL}    visible
    Click    ${LOGOUT_CANCEL}

Close Logoff Window Mode    
    Click Close Logoff Window Button
    Main Page Should Be Open    ${MAIN_TITLE}

Click Close Logoff Window Button
    Wait For Elements State    ${CLOSE_BUTTON_LOGOFF_WINDOW}    visible
    Click    ${CLOSE_BUTTON_LOGOFF_WINDOW}

Incorrect Password Logoff HOS
    Open HOS Logoff Window
    Input Password Login/Logoff    ${INVALID_PASSWORD}          
    Click Submit Button
    Wait For Elements State    span#input-error    visible
    Close Page

Close HOS Logoff Window Mode
    Open HOS Logoff Window
    Close Page

Set Hour Of Service
    Click HOS Calendar Button
    Click Today Item In HOS Calendar
    ${hour}=    Get Current Date Hour
    ${minute}=    Get Current Date Minute
    ${delay_hour}=    Evaluate    ${hour} - 1
    Set HOS Hour And Minute    ${delay_hour}    ${minute}
    Click HOS Done Button
    
Click HOS Calendar Button
    Wait For Elements State    ${HOS_CALENDAR_BUTTON}    visible
    Click    ${HOS_CALENDAR_BUTTON}

Click Today Item In HOS Calendar
    Wait For Elements State    ${HOS_CALENDAR_TODAY_ITEM}    visible
    Click    ${HOS_CALENDAR_TODAY_ITEM}

Get Current Date Hour
    ${current_hour}=    Get Current Date    result_format=%H
    ${hour}=    Convert To Integer    ${current_hour}
    RETURN    ${hour}

Get Current Date Minute
    ${current_minute}=    Get Current Date    result_format=%M
    ${minute}=    Convert To Integer    ${current_minute}
    RETURN    ${current_minute}

Set HOS Hour And Minute
    [Arguments]    ${hour}    ${minute}
    Wait For Elements State    ${HOS_INPUT_HOUR}    visible
    Fill Text    ${HOS_INPUT_HOUR}    ${hour}
    Wait For Elements State    ${HOS_INPUT_MINUTE}    visible
    Fill Text    ${HOS_INPUT_MINUTE}    ${minute}

Click HOS Done Button
    Wait For Elements State    ${HOS_DONE_BUTTON}     visible
    Click    ${HOS_DONE_BUTTON}

New Page Should Be Open
    [Arguments]    @{previous_pages}
    @{current_pages}=    Get Page Ids
    ${new_page}=        Evaluate    list(set(${current_pages}) - set(${previous_pages}))[0]
    Run Keyword If    '${new_page}' != 'None'    Switch Page    ${new_page}
    
Open HOS Logoff Window
    @{previous_pages} =    Get Page Ids
    Click    ${CONTINUE_LOGOFF}
    @{current_pages}=    Get Page Ids
    Wait Until Keyword Succeeds    10s    1s    New Page Should Be Open    @{previous_pages}


Input Login Incorrect Credentials
    [Arguments]    ${Mode}="Incorrect Password"
    Run Keyword If    ${Mode} == "Incorrect Password"    Incorrect Password Login
    ...    ELSE IF    ${Mode} == "Incorrect Username"    Incorrect Username Login

Incorrect Password Login
    Input Username Login/Logoff    ${VALID_USERNAME}
    Input Password Login/Logoff   invalid
    Click Submit Button
    Wait For Elements State    span#input-error    visible

Incorrect Username Login
    Input Username Login/Logoff    invalid
    Input Password Login/Logoff   ${VALID_PASSWORD}
    Click Submit Button
    Wait For Elements State    span#input-error    visible

Check Usersession Cookie
    ${UserSessionCookie}=   Retrieve Usersession Cookie
    ${query_result}=    Check Usersession Cookie BBDD
    Should Be Equal    ${UserSessionCookie}    ${query_result}

Retrieve Usersession Cookie
    @{cookies}=    Get Cookies
    FOR    ${cookie}    IN    @{cookies}
        IF    $cookie["name"] == "CSSID"
            RETURN    ${cookie}[value]    
        END
    END

Delete Usersession Cookie
    Delete All Cookies
    Login Page Should Be Loaded    expected_title=${LOGIN_TITLE}

Open Manage User Session Window
    Click Supervisor Avatar
    Click Manage Users Sessions

Click Supervisor Avatar
    Wait For Elements State    button#ix-menu-avatar-id
    Click    button#ix-menu-avatar-id

Click Manage Users Sessions
    Wait For Elements State    ix-menu-avatar-item[ng-reflect-label="Manage users sessions"]
    Click    ix-menu-avatar-item[ng-reflect-label="Manage users sessions"]
