*** Settings ***
Resource  resource.robot
Suite Setup  Open And Configure Browser
Suite Teardown  Close Browser
Test Setup  Create User And Go To Login Page

*** Test Cases ***
Login With Correct Credentials
    Set Username  kalle
    Set Password  kalle123
    Submit Credentials
    Login Should Succeed

Login With Incorrect Password
    Set Username  kalle
    Set Password  kalle456
    Submit Credentials
    Login Should Fail With Message  Invalid username or password

Login With Nonexistent Username
    Reset Application
    Go To Login Page
    Set Username  eiole
    Set Password  olemassa
    Submit Credentials
    Login Should Fail With Message  Invalid username or password

Register With Valid Username And Password
    Reset Application
    Go To Register Page
    Set Username  kalle
    Set Password  kalle123
    Set Password Confirmation  kalle123
    Submit Register
    Register Should Succeed

Register With Too Short Username And Valid Password
    Reset Application
    Go To Register Page
    Set Username  ka
    Set Password  kalle123
    Set Password Confirmation  kalle123
    Submit Register
    Register Should Fail With Message  Username is too short

Register With Valid Username And Invalid Password
    Reset Application
    Go To Register Page
    Set Username  kalle
    Set Password  kallekalle
    Set Password Confirmation  kallekalle
    Submit Register
    Register Should Fail With Message  Password is NOT valid!!!

Register With Nonmatching Password And Password Confirmation
    Reset Application
    Go To Register Page
    Set Username  kalle
    Set Password  kalle123
    Set Password Confirmation  kalle456
    Submit Register
    Register Should Fail With Message  Password and confirmation need to match

Login After Successful Registration
    Reset Application
    Go To Register Page
    Set Username  kalle
    Set Password  kalle123
    Set Password Confirmation  kalle123
    Submit Register
    Register Should Succeed
    Go To Login Page
    Set Username  kalle
    Set Password  kalle123
    Submit Credentials
    Login Should Succeed

Login After Failed Registration
    Reset Application
    Go To Register Page
    Set Username  kalle
    Set Password  kalle123
    Set Password Confirmation  kalle456
    Submit Register
    Register Should Fail With Message  Password and confirmation need to match
    Go To Login Page
    Set Username  kalle
    Set Password  kalle123
    Submit Credentials
    Login Should Fail With Message  Invalid username or password

    
*** Keywords ***
Login Should Succeed
    Main Page Should Be Open

Register Should Succeed
    App Page Should Be Open

Login Should Fail With Message
    [Arguments]  ${message}
    Login Page Should Be Open
    Page Should Contain  ${message}

Register Should Fail With Message
    [Arguments]  ${message}
    Register Page Should Be Open
    Page Should Contain  ${message}

Submit Credentials
    Click Button  Login

Submit Register
    Click Button  Register

Set Username
    [Arguments]  ${username}
    Input Text  username  ${username}

Set Password
    [Arguments]  ${password}
    Input Password  password  ${password}

Set Password Confirmation
    [Arguments]  ${password}
    Input Password  password_confirmation  ${password}

Create User And Go To Login Page
    Create User  kalle  kalle123
    Go To Login Page
    Login Page Should Be Open

	    