*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Happy Path
    Wait Until Contacts Load
    Populate Mandatory Fields
    Click Submit
    Validate Success
    #For reference: back button xpath://a[@ng-click="goBack()"] this needs to be clicked
    #first or you click Home menu. Otherwise, the form will not appear even if you click
    #contacts so it might not be a good idea to immediately use repeat keyword with tags
    #Repeat Keyword              5   Happy Path

Wait Until Contacts Load
    Log                         Waiting until contact page loads
    Wait Until Page Contains    We welcome your feedback

Click Submit
    Log                         Click Submit button
    Click Link                  Submit

Check Error Messages
    Log                         Check if all error messages are present
    Page Should Contain         Forename is required
    Page Should Contain         Email is required
    Page Should Contain         Message is required
    #if time permits, add validation as to the color of the error messages and field color

Populate Mandatory Fields
    Log                         Populate mandatory fields
    Input Text                  id=forename     Debz
    Input Text                  id=email        debra.bula@gmail.com
    Input Text                  id=message      This is just a test

Validate Errors are Gone
    Log                         Validate errors are gone
    Page Should not Contain     Forename is required
    Page Should not Contain     Email is required
    Page Should not Contain     Message is required

Validate Success
    Log                         Check that submission is successful
    Log                         Changing timeout to 20s
    Set Selenium Timeout        20s
    #extended time out just for this set since submission takes time
    Page Should Contain         Sending Feedback
    Wait Until Page Contains    Back
    Page Should Contain         Thanks Debz, we appreciate your feedback.

