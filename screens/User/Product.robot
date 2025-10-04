*** Settings ***
Library     AppiumLibrary

*** Variables ***
${AddedToCart}                     accessibility_id=Added to cart!

*** Keywords ***
Add product to wishlist
    Swipe By Percent    50    80    50    20    500
    Wait Until Keyword Succeeds    20s    1s    Click Element    android=new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().descriptionContains("Add to Wish List"))
    Go Back

Add product to cart
    Swipe By Percent    50    70    50    40    400
    Wait Until Keyword Succeeds    20s    1s    Click Element    android=new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().descriptionContains("Add to Cart"))
    Wait Until Keyword Succeeds  15  0.5  Page Should Contain Element     ${AddedToCart}
    Go Back
    