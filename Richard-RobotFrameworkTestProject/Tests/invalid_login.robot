*** Settings ***
Documentation    A test suite with different test cases depending on
...              the credentials used to login. All of them are incorrect
...              or empty.
Resource    ../Resources/resource.resource
Suite Teardown    Close Browser
Metadata         Version    0.1
Test Template    Login With Invalid Credentials Should Fail

*** Test Cases ***               USERNAME               PASSWORD
Invalid Username                 ${INVALID_USERNAME}    ${VALID_PASSWORD}
Invalid Password                 ${VALID_USERNAME}      ${INVALID_PASSWORD}
Invalid Username and Password    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
Empty Username                   ${EMPTY}               ${VALID_PASSWORD}
Empty Password                   ${VALID_USERNAME}      ${EMPTY}
Empty Username and Password      ${EMPTY}               ${EMPTY}
