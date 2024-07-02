*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Load and Verify Page
    Load
    Verify Page Loaded

Load
    Go To  https://jupiter.cloud.planittesting.com/#/

Verify Page Loaded
    Wait Until Page Contains  Jupiter Toys

Click Start Shopping
    Log                         Click Start Shopping button
    Wait Until Page Contains    Start Shopping »
    Click Link                  //a[@href='#/shop']