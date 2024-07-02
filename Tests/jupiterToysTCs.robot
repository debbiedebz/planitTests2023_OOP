*** Settings ***
Documentation   These contain test cases made for Planit's Automation Lead application
Resource  ../Resources/Common.robot  # necessary for Setup & Teardown
Resource  ../Resources/JupiterToys.robot  # necessary for lower level keywords in test cases
Test Setup  Begin Web Test
Test Teardown  End Web Test

#Run the tests: robot -d results Tests/jupiterToysTCs.robot

*** Variables ***


*** Test Cases ***
Test Case 1: Contacts page - Validate error messages
    [Documentation]     Step1 Homepage to Contact Page
    [tags]              1 contacts  errorMessages
    JupiterToys.Click Contact Page
    JupiterToys.Click Submit
    JupiterToys.Verify Error Messages
    JupiterToys.Populate Mandatory Fields
    JupiterToys.Validate Errors are Gone

Test Case 2: Contacts page - 5 Successful Submissions
    [Documentation]     Test Case2: Create contact and submit successfully 5x
    [tags]              2 contacts  submissions
    JupiterToys.Click Contact Page
    JupiterToys.Populate Mandatory Fields
    JupiterToys.Click Submit
    JupiterToys.Validate Success
    JupiterToys.Submit 5X

Test Case 3: Cart page - Check the number of purchased items and prices
    [Documentation]     Test Case3: Shop Toys
    [tags]              3 shop  cart
    JupiterToys.Shop
    JupiterToys.Buy Stuffed Toys
    JupiterToys.Open Cart
    JupiterToys.Verify the Quantity
    JupiterToys.Verify the Price
    JupiterToys.Verify the Subtotal
    JupiterToys.Verify the Total