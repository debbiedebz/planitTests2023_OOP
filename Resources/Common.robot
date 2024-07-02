*** Settings ***
Library  SeleniumLibrary

*** Variables ***

*** Keywords ***
Begin Web Test
    Open Browser  about:blank  chrome

End Web Test
    Run Keyword If Test Failed    Capture Page Screenshot
    Close Browser