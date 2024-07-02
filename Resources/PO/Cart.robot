*** Settings ***
Library  SeleniumLibrary

*** Variables ***
@{StuffedFrog_unitPrice_expected} =  $10.99
@{StuffedFrog_unitPrice_actual} =  xpath://tr[1]/td[2]
#@{StuffedFrog_subtotal_expected} =    Evaluate    @{StuffedFrog_unitPrice_expected * @{numberOfStuffedFrogOrdered} will not work
#since one is a string and the other is a number/integer. Will have to cut the dollar sign first and convert data type before
#we can process this
@{StuffedFrog_subtotal_actual} =  xpath://tr[1]/td[4]
# TODO: Add a function later to convert dollar values to integer and add them for subtotal and total computation

@{FluffyBunny_unitPrice_actual} =  xpath://tr[2]/td[2]
@{FluffyBunny_unitPrice_expected} =  $9.99
@{FluffyBunny_subtotal_actual} =  xpath://tr[2]/td[4]

@{ValentineBear__unitPrice_actual} =  xpath://tr[3]/td[2]
@{ValentineBear__unitPrice_expected} = 	$14.99
#I wanted to name my variable as "ValentineBear_unitPrice" with one underscore for easy understanding but it seems
#this is treated as a reserved word, so I just named it as "ValentineBear__unitPrice" instead
@{ValentineBear_subtotal_actual} =  xpath://tr[3]/td[4]

@{CartTotal_actual} =  xpath://tfoot/tr[1]/td/strong

*** Keywords ***
Open Cart
    #add some wait time for tapping the buy button to sync up before checking total items in cart
    Sleep                   3s
    Log                     Go to Cart page
    Click element           xpath://*[@id="nav-cart"]/a
    Wait Until Element Is Visible     //thead/tr/th[4]
    #Subtotal

#TODO: Improve later by using a function to check purchases per row: name, price, and subtotal

Verify the Quantity
    #Added this validation to check if the number displayed matches those of how much you really
    #bough
    Log                             Checking ordered quantities are correct
    #STUFFED FROGS
    Log                             Check the Stuffed Frog quantity is correct
    ${numberOfStuffedFrogOrdered}   Get Value    xpath://tr[1]/td[3]/input
    Run Keyword If                  '${numberOfStuffedFrogOrdered}=2'== 'TRUE'  Run Keywords    log The number of Stuffed Frogs ordered are correct

    #FLUFFY BUNNIES
    Log                             Check the Fluffy Bunny quantity is correct
    ${numberOfStuffedFluffyBunniesOrdered}   Get Value    xpath://tr[2]/td[3]/input
    Run Keyword If                  '${numberOfStuffedFluffyBunniesOrdered}=5'== 'TRUE'  Run Keywords    log The number of Fluffy Bunnies ordered are correct

    #VALENTINE BEARS
    Log                             Check the Valentine Bears quantity is correct
    ${numberOfStuffedValentineBearsOrdered}   Get Value    xpath://tr[3]/td[3]/input
    Run Keyword If                  '${numberOfStuffedValentineBearsOrdered}=2'== 'TRUE'  Run Keywords    log The number of Valentine Bears ordered are correct

Verify the Price
    Log                             Checking if the individual prices are correct
    #STUFFED FROGS
    Log                             Check the Stuffed Frog individual price is correct
    Element Text Should be  	    @{StuffedFrog_unitPrice_actual}            @{StuffedFrog_unitPrice_expected}

    #FLUFFY BUNNIES
    Log                             Check the Fluffy Bunnies's individual prices are correct
    Element Text Should be  	    @{FluffyBunny_unitPrice_actual}            @{FluffyBunny_unitPrice_expected}

    #VALENTINE BEARS
    Log                             Check the Valentine Bear individual prices are correct
    Element Text Should be  	    @{ValentineBear__unitPrice_actual}         @{ValentineBear__unitPrice_expected}

Verify the Subtotal
    Log                                Verifying Subtotals...
    Verify Subtotals - Stuffed Frog
    Verify Subtotals - Fluffy Bunnies
    Verify Subtotals - Valentine Bears

Verify Subtotals - Stuffed Frog
    #STUFFED FROGS
    Log                     Check the Stuffed Frog subtotal is correct
    #${stuffedFrogSubtotal}   Get Text  xpath://html/body/div[2]/div/form/table/tbody/tr[1]/td[4]
    #Computation Reference: stuffedFrogSubtotal_expected}=  2*10.99 = 21.98
    Element Text Should be  	@{StuffedFrog_subtotal_actual}  $21.98

Verify Subtotals - Fluffy Bunnies
    #FLUFFY BUNNIES
    Log                     Check the Fluffy Bunny subtotal is correct
    #Computation Reference: 5*9.99 = 21.98
    Element Text Should be  	@{FluffyBunny_subtotal_actual}  $49.95

Verify Subtotals - Valentine Bears
    #VALENTINE BEARS
    Log                     Check the Valentine Bears subtotal is correct
    #Computation Reference: 3*14.99 = 29.98
    Element Text Should be  	@{ValentineBear_subtotal_actual}  $44.97

Verify the Total
    Log                     Check the Total Cost is correct
    #Computation Reference: 21.98+49.95+44.97 = 116.9
    Element Text Should be            @{CartTotal_actual}    Total: 116.9