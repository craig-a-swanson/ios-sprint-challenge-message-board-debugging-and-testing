//
//  Message_BoardUITests.swift
//  Message BoardUITests
//
//  Created by Spencer Curtis on 9/14/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest

class Message_BoardUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        
        // NOTE: Keep this setup as is for UI Testing
        app.launchArguments = ["UITesting"]
        app.launch()
    }
    
    // Tap existing thread in table view and verify navigation to the detail table view for that thread.
    func testShowThreadDetail() {
        app.tables.cells.staticTexts["Testing again"].tap()
        XCTAssertTrue(app.navigationBars["Testing again"].exists)
        
    }
    
    func testPopViewFromNavigationStack() {
        app.navigationBars["Testing again"].buttons["λ Message Board"].tap()
        XCTAssertTrue(app.navigationBars["λ Message Board"].exists)
    }
    
    // create a new thread from the table view and verify it populated a cell.
    func testCreateMessageThread() {
        let messageTextField = app.tables.textFields["Create a new thread:"]
        messageTextField.tap()
        messageTextField.typeText("Typing real text.")
        app.keyboards.buttons["Return"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["Typing real text."].exists)
        
    }
    
    // Tap on a thread to go to detail table view; tap on add button; create new message and verify it saved to the thread.
    func testCreateMessageFromThread() {
         app.tables.cells.staticTexts["Testing again"].tap()
    
        app.navigationBars["Testing again"].buttons["Add"].tap()
        
        let nameTextField = app.textFields["Enter your name:"]
        nameTextField.tap()
        nameTextField.typeText("Bethany MacDonald")
        
        let messageTextView = app.textViews.element
        XCTAssert(messageTextView.exists)
        messageTextView.tap()
        messageTextView.typeText("With what then will thou goest?")
        
        app.navigationBars["New Message"].buttons["Send"].tap()

        XCTAssertTrue(app.tables.staticTexts["With what then will thou goest?"].exists)
    }
    
}
