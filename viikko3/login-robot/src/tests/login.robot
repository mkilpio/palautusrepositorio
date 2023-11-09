*** Settings ***
Resource  resource.robot

*** Test Cases ***
Login With Correct Credentials
    Input New Command
    Input Credentials  kalle  kalle123
    Input Login Command
    Input Credentials  kalle  kalle123
    Output Should Contain  Logged in

Login With Incorrect Password
    Input New Command
    Input Credentials  kalle  kalle123
    Input Login Command
    Input Credentials  kalle  kalle124
    Output Should Contain  Invalid username or password

Login With Nonexistent Username
    Input New Command
    Input Credentials  kalle  kalle123
    Input Login Command
    Input Credentials  kale  kalle123
    Output Should Contain  Invalid username or password

Register With Valid Username And Password
    Input New Command
    Input Credentials  kalle  kalle123
    Output Should Contain  New user registered

Register With Already Taken Username And Valid Password
    Input New Command
    Input Credentials  kalle  kalle123
    Input New Command
    Input Credentials  kalle  kalle123
    Output Should Contain  User with username kalle already exists

Register With Too Short Username And Valid Password
    Input New Command
    Input Credentials  ka  kalle123
    Output Should Contain  Username is too short

Register With Enough Long But Invald Username And Valid Password
    Input New Command
    Input Credentials  ka54  kalle123
    Output Should Contain  Only letter a to z are allowed in username

Register With Valid Username And Too Short Password
    Input New Command
    Input Credentials  kalle  kalle1
    Output Should Contain  Password is too short

Register With Valid Username And Long Enough Password Containing Only Letters
    Input New Command
    Input Credentials  kalle  kallekalle
    Output Should Contain  Pasword with only letters a-z in invalid

