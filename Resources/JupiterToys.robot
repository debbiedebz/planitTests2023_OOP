*** Settings ***
Resource  ../Resources/PO/Cart.robot
Resource  ../Resources/PO/Contact.robot
Resource  ../Resources/PO/Home.robot
Resource  ../Resources/PO/Shop.robot
Resource  ../Resources/PO/Menu.robot
Resource  ../Resources/PO/SignIn.robot

*** Keywords ***
Click Contact Page
    Home.Load
    Home.Verify Page Loaded
    Menu.Verify Contact is Present
    Menu.Click Contact

Click Submit
    Contact.Wait Until Contacts Load
    Contact.Click Submit

Verify Error Messages
    Contact.Check Error Messages

Populate Mandatory Fields
    Contact.Wait Until Contacts Load
    Contact.Populate Mandatory Fields

Validate Errors are Gone
    Contact.Validate Errors are Gone

Validate Success
    Contact.Validate Success

Submit 5X
    log     Submitting Feedback 5X
    FOR    ${index}    IN RANGE     (5)
        Menu.Click Home
        Menu.Click Contact
        Contact.Happy Path
    END

Shop
    Home.Load and Verify Page
#    Home.Click Start Shopping
    Shop.Go to Shop

Buy Stuffed Toys
    Shop.Stuffed Frogs
    Shop.Fluffy Bunnies
    Shop.Valentine Bears

Open Cart
    Cart.Open Cart

Verify the Quantity
    Cart.Verify the Quantity

Verify the Price
    Cart.Verify the Price

Verify the Subtotal
    Cart.Verify the Subtotal

Verify the Total
    Cart.Verify the Total