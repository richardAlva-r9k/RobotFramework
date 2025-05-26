*** Variables ***

#{ Variables for browser initialization }
${LOGIN_URL}    http://127.0.0.1.nip.io/
${BROWSER}    Chromium
${HEADLESS}    false
${SLOWMO}    0.5

#{ Variables for login credentials }
${VALID_USERNAME}    supervisor
${VALID_PASSWORD}    supervisor
${INVALID_USERNAME}    invalid
${INVALID_PASSWORD}    invalid

#{ Variables for html frontend elements }
${LOGIN_TITLE}    Sign in to CSX CoreSystem
${MAIN_TITLE}    Core System
${LOGIN_PAGE_ELEMENT}    div.login-pf-page
${MAIN_PAGE_ELEMENT}    gridster-item#DashBoard_mainCanvas
${INPUT_LOGIN_USERNAME}    input[name="username"]
${INPUT_LOGIN_PASSWORD}    input[name="password"]
${INPUT_LOGIN_SUBMIT}    input#kc-login
${IX-BLIND_ROLE&POSITION}    ix-blind.rootPane.blind-outline.hydrated
${IX-SELECT_ROLE}    ix-select >> nth=0
${IX-SELECT_POSITION}    ix-select >> nth=1
${START_SESSION_BUTTON}    text="Start session"
${LOGOFF_BUTTON}    ix-menu-item[label="Logout"]
${CONTINUE_LOGOFF}    text=" Continue"
${LOGOUT_CANCEL}    text=" Cancel"
${HOS_CALENDAR_BUTTON}    button[aria-label="Calendar"]
${HOS_CALENDAR_TODAY_ITEM}    div.calendar-item.today.selected
${HOS_INPUT_HOUR}    input[name="hour"]
${HOS_INPUT_MINUTE}    input[name="minute"]
${HOS_DONE_BUTTON}    div.btn-select-date-container >> ix-button:has-text("Done")
${CLOSE_BUTTON_LOGOFF_WINDOW}    ix-modal-header[ng-reflect-icon="log-out"] >> button[aria-label="Close"]

*** Keywords ***

# GET keywords to select role and position
Get Selector For IX-SELECT-ITEM_ROLE
    [Arguments]    ${role}
    ${selector}=    Set Variable    ix-select-item[ng-reflect-value="${role}"]
    RETURN    ${selector}

Get Selector For IX-SELECT-ITEM_POSITION
    [Arguments]    ${position}
    ${selector}=    Set Variable    ix-select-item[ng-reflect-value="${position}"]
    RETURN    ${selector}
