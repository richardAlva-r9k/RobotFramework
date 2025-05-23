*** Settings ***
Documentation    This resource contains the keywords to access to CSX main page and also to log in the user

Library    Browser
Library    OperatingSystem
Library    Collections
Library    DateTime

Resource   variables.resource

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
    ${title}=    Get Title
    Should Be Equal    ${title}    ${expected_title}

Input Login Valid Credentials
    [Arguments]    ${username}    ${password}
    Fill Text    ${INPUT_LOGIN_USERNAME}    ${username}
    Fill Text    ${INPUT_LOGIN_PASSWORD}    ${password}
    Click    ${INPUT_LOGIN_SUBMIT}
    Role&Position Page Should Be Open    ${MAIN_TITLE}

Role&Position Page Should Be Open
    [Arguments]    ${expected_title}
    Wait For Elements State       ${IX-BLIND_ROLE&POSITION}    visible
    ${title}=    Get Title
    Should Be Equal    ${title}    ${expected_title}

Select Role And Position
    [Arguments]    ${role}    ${position}    ${HOS}
    Wait For Elements State    ${IX-SELECT_ROLE}    
    Click    ${IX-SELECT_ROLE}
    ${IXL-SELECT-ITEM_ROLE} =   Get Selector For IX-SELECT-ITEM_ROLE    ${role}
    Wait For Elements State    ${IXL-SELECT-ITEM_ROLE}    visible
    Click    ${IXL-SELECT-ITEM_ROLE}
    Wait For Elements State    ${IX-SELECT_POSITION}
    Click    ${IX-SELECT_POSITION}
    ${IXL-SELECT-ITEM_POSITION} =  Get Selector For IX-SELECT-ITEM_POSITION    ${position}
    Wait For Elements State    ${IXL-SELECT-ITEM_POSITION}    visible
    Click    ${IXL-SELECT-ITEM_POSITION}
    IF    '${HOS}' == 'True'
        Set Hour Of Service
    END
    Wait For Elements State    ${START_SESSION_BUTTON}    visible
    Click    ${START_SESSION_BUTTON} 
    Main Page Should Be Open    ${MAIN_TITLE}

Main Page Should Be Open
    [Arguments]    ${expected_title}
    Wait For Elements State    ${MAIN_PAGE_ELEMENT}    visible
    ${title}=    Get Title
    Should Be Equal    ${title}    ${expected_title}

Start Logoff
    Wait For Elements State    ${LOGOUT_BUTTON}    visible
    Click    ${LOGOUT_BUTTON}

Confirm Logoff
    Start Logoff
    Wait For Elements State    ${LOGOUT_CONFIRMATION}    visible    
    Login Page Should Be Loaded    ${LOGIN_TITLE}

Cancel Logoff
    Start Logoff    
    Wait For Elements State    ${LOGOUT_CANCEL}    visible
    Click    ${LOGOUT_CANCEL}
    Main Page Should Be Open    ${MAIN_TITLE}

Set Hour Of Service
    Wait For Elements State    ${HOS_CALENDAR_BUTTON}    visible   
    Click    ${HOS_CALENDAR_BUTTON}
    Wait For Elements State    ${HOS_CALENDAR_TODAY_ITEM}    visible
    Click    ${HOS_CALENDAR_TODAY_ITEM}
    ${current_hour}=    Get Current Date    result_format=%H
    ${current_minute}=    Get Current Date    result_format=%M
    ${hour}=    Convert To Integer    ${current_hour}
    ${minute}=    Convert To Integer    ${current_minute}
    ${delay_hour}=    Evaluate    ${hour} - 1
    Wait For Elements State    ${HOS_INPUT_HOUR}    visible
    Fill Text    ${HOS_INPUT_HOUR}    ${delay_hour}
    Wait For Elements State    ${HOS_INPUT_MINUTE}    visible
    Fill Text    ${HOS_INPUT_MINUTE}    ${minute}
    Wait For Elements State    ${HOS_DONE_BUTTON}     visible
    Click    ${HOS_DONE_BUTTON} 