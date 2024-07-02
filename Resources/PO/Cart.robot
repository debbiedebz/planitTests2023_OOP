*** Settings ***
Library  SeleniumLibrary
Library         String

*** Variables ***
@{StuffedFrog_unitPrice_expected} =  $10.99
@{StuffedFrog_unitPrice_actual} =  xpath://tr[1]/td[2]
#@{StuffedFrog_subtotal_expected} =    Evaluate    @{StuffedFrog_unitPrice_expected * @{numberOfStuffedFrogOrdered} will not work
#since one is a string and the other is a number/integer. Will have to cut the dollar sign first and convert data type before
#we can process this
@{StuffedFrog_subtotal_actual} =  xpath://tr[1]/td[4]

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
    Sleep                   10s
    Log                     Go to Cart page
    Click element           xpath://*[@id="nav-cart"]/a
    Wait Until Element Is Visible     //thead/tr/th[4]
    #Subtotal

#TODO: Improve later by using a function to check purchases per row: name, price, and subtotal as well as price in string to integer conversion.

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
    Log                     Check that the Total Cost is correct

    ${StuffedFrog_subtotal_text} =  Get Text        @{StuffedFrog_subtotal_actual}
    ${StuffedFrog_subtotal_numbers} =  Get Substring        ${StuffedFrog_subtotal_text}       1
    ${StuffedFrog_subtotal_int} =  Convert To Number     ${StuffedFrog_subtotal_numbers}

    ${FluffyBunny_subtotal_text} =  Get Text        @{FluffyBunny_subtotal_actual}
    ${FluffyBunny_subtotal_numbers} =  Get Substring        ${FluffyBunny_subtotal_text}       1
    ${FluffyBunny_subtotal_int} =  Convert To Number     ${FluffyBunny_subtotal_numbers}

    ${ValentineBear_subtotal_text} =  Get Text        @{ValentineBear_subtotal_actual}
    ${ValentineBear_subtotal_numbers} =  Get Substring        ${ValentineBear_subtotal_text}       1
    ${ValentineBear_subtotal_int} =  Convert To Number     ${ValentineBear_subtotal_numbers}

    #Computation Reference: 21.98+49.95+44.97 = 116.9
    ${StuffedToysSubTotals_computed} =  Evaluate     ${StuffedFrog_subtotal_int}+${FluffyBunny_subtotal_int}+${ValentineBear_subtotal_int}

    ${CartTotal_actual_text} =  Get Text        @{CartTotal_actual}
    ${CartTotal_actual_numbers} =  Get Substring        ${CartTotal_actual_text}       7
    ${CartTotal_actual_int} =  Convert To Number     ${CartTotal_actual_numbers}

    #Commented out, for debugging only
    #Log     Stuff Frog: ${StuffedFrog_subtotal_int}
    #Log     Fluffy Bunny: ${FluffyBunny_subtotal_int}
    #Log     Valentine Bear: ${ValentineBear_subtotal_int}
    #Log     Computed Stuffed Animal Subtotals: ${StuffedToysSubTotals_computed}
    #Log     Cart Total Display: ${CartTotal_actual_numbers}

    #Check to make sure both are equal
    Run Keyword If                  '${CartTotal_actual_numbers}=${StuffedToysSubTotals_computed}'== 'TRUE'  Run Keywords    Log    The Total displayed for all purchases are correct.
    Run Keyword If                  '${CartTotal_actual_numbers}=${StuffedToysSubTotals_computed}'== 'FALSE'  Run Keywords    Fail  Total displayed mismatches with Expected Total