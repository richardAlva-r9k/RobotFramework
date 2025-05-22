*** Variables ***

#{ Variables for browser initialization }
${LOGIN_URL}    http://127.0.0.1.nip.io/
${BROWSER}    Chromium
${HEADLESS}    false
${SLOWMO}    0.5

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
${START_SESSION_BUTTON}    text=Start session
${LOGOUT_BUTTON}    ix-menu-item[label="Logout"]
${LOGOUT_CONFIRMATION}    text=" Continue"
${LOGOUT_CANCEL}    text=" Cancel"

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
