//
//  Lab3UITests.swift
//  Lab3UITests
//
//  Created by Ryan Boado on 2023-01-24.
//

import XCTest

final class Lab3UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharCount() throws {
        let app = XCUIApplication()
        let detailText = app.staticTexts["DetailText"]
        let detailTextEditor = app.textViews["DetailTextEditor"]
        let keyi = app.keys["i"]
        let keyH = app.keys["H"]
        
        app.launch() // Launch app
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        app.collectionViews.buttons.firstMatch.tap() // Tap on first entry
        XCTAssertEqual(detailText.label, "7 / 150") // Check 1
        detailTextEditor.tap() // Tap on text editor
        keyH.tap() // Tap on H key
        XCTAssertTrue(detailText.waitForExistence(timeout: 5))
        XCTAssertEqual(detailText.label, "8 / 150") // Check 2
        
        keyi.tap()
        XCTAssertEqual(detailText.label, "9 / 150") // Check 3
    }
    
    func testCharCount1() throws {
        let app = XCUIApplication()
        let keyi = app.keys["i"]
        let keyH = app.keys["H"]
        let detailTextEditor = app.textViews["DetailTextEditor"]
        let detailText = app.staticTexts["DetailText"]
        app.launch()
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        app.collectionViews.buttons.firstMatch.tap()
        XCTAssertEqual(detailText.label, "7 / 150")
        detailTextEditor.tap()
        keyH.tap()
        XCTAssertTrue(detailText.waitForExistence(timeout: 5))
        let values = 2...151
        for _ in values  {
            keyi.tap()
        }
        XCTAssertEqual(detailText.label, "150 / 150")
    }
    
    func test3() throws {
        let app = XCUIApplication()
        let detailTextEditor = app.textViews["DetailTextEditor"]
        let detailText = app.staticTexts["DetailText"]
//        let plusButton = app.buttons["PlusButton"]
        let backButton = app.buttons["Inventory"]
        let navigationButton = app.buttons["NavigationButton"]
        let keyH = app.keys["H"]
        let keyh = app.keys["h"]
        app.launch()
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()

       
        navigationButton.tap()
        
        var maxCharCount = 150
        var decCharCount = 150
        
        while(decCharCount > 10)
        {
            app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
            decCharCount-=10
        }
        
        app.terminate()
        app.launch()
        //XCTAssertEqual(detailText.label, "4 / 10")
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        app.collectionViews.buttons.firstMatch.tap()
        detailTextEditor.tap()
        
        let range = 1...20
        
        keyH.tap()
        for _ in range {
            keyh.tap()
        }
        
        var incCharCount = 0
        
        backButton.tap()
        navigationButton.tap()
        
        while(incCharCount < 320)
        {
            app.steppers["MaxCountStepper"].buttons["Increment"].tap()
            incCharCount+=10
        }
        
        var backToDefault = 0
        
        while (backToDefault != maxCharCount) {
            app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
            backToDefault += 10
        }
        
        navigationButton.tap()
        app.collectionViews.buttons.firstMatch.tap()
        
        XCTAssertEqual(detailText.label, "10 / 150")
    }
    
    func test4() throws {
        let app = XCUIApplication() // Access app
        let favouriteToggle = app.switches["FavouriteToggle"] // Access toggle
        let backButton = app.buttons["Inventory"] // Access back button
        
        // Launch app
        app.launch()
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        
        app.collectionViews.buttons.firstMatch.tap() // Tap on first entry
        favouriteToggle.tap() // Tap on toggle
        XCTAssertEqual(favouriteToggle.value as? String, "1") // Check if the toggle is disabled
       
        backButton.tap()  // Tap back button
        
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        app.collectionViews.buttons.firstMatch.tap()
        
        XCTAssertEqual(favouriteToggle.value as? String, "0") // Check if the toggle is enabled
        
        app.launch()
    }
    
    func test5() throws {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
    }
    
    func testItemDelete() throws {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        
        XCTAssertEqual(app.collectionViews.buttons.count, 1)
        
        app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
        app.collectionViews.buttons["Delete"].tap()
        
        XCTAssertEqual(app.collectionViews.buttons.count, 0)
    }
    
    func testLoadAndSave() throws {
        let app = XCUIApplication()
        let favouriteToggle = app.switches["FavouriteToggle"] // Access toggle
        let backButton = app.buttons["Inventory"]
        
        app.launch()
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        
        app.collectionViews.buttons.firstMatch.tap()
        favouriteToggle.tap()
        backButton.tap()
        app.collectionViews.buttons.firstMatch.tap()
        
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.terminate()
        app.launch()
        
        app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
        app.collectionViews.buttons["Delete"].tap()

        app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
        app.collectionViews.buttons["Delete"].tap()

        XCUIDevice.shared.press(.home)
        sleep(1)
        
        app.launch()
        XCTAssertEqual(app.collectionViews.buttons.count, 0)

        
    }
}
