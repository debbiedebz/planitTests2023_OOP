*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Go to Shop
    Home.Click Start Shopping
    Wait Until Page Contains    Teddy Bear
    #just to make sure that shop items are already displayed before proceeding to next steps

#TODO: Improve later by using a function to enter what animal to buy and how much quantity
Stuffed Frogs
    Log                     Buy 2 Stuffed Frogs
    Page Should Contain     Stuffed Frog
    #Set Focus To Element    id=product-2
    FOR    ${index}    IN RANGE     (2)
    Click Link              xpath://*[@id="product-2"]/div/p/a
    Sleep                   2s
    END

Fluffy Bunnies
    Log                     Buy 5 Fluffy Bunnies
    Page Should Contain     Fluffy Bunny
    FOR    ${index}    IN RANGE     (5)
    Click Link              xpath://*[@id="product-4"]/div/p/a
    Sleep                   2s
    END

Valentine Bears
    Log                     Buy 3 Valentine Bears
    Page Should Contain     Valentine Bear
    FOR    ${index}    IN RANGE     (3)
    Click Link              xpath://*[@id="product-7"]/div/p/a
    Sleep                   2s
    END