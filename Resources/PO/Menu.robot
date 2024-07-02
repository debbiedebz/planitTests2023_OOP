*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Verify Home is Present
    Page Should Contain Element     xpath://li[@id="nav-contact"]/a[@href="#/home"]

Verify Shop is Present
    Page Should Contain Element     xpath://li[@id="nav-contact"]/a[@href="#/shop"]

Verify Contact is Present
    Page Should Contain Element     xpath://li[@id="nav-contact"]/a[@href="#/contact"]

Click Home
    Click Link                      Home

Click Contact
    Click Link                      Contact

Click Shop
    Click Link                      Shop

