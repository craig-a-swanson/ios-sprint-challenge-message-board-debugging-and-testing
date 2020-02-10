//
//  MessageThreadTests.swift
//  MessageBoardTests
//
//  Created by Andrew R Madsen on 9/13/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
@testable import Message_Board

class MessageThreadTests: XCTestCase {
    
    // # cells equals message threads count
    // typing in text box and pressing enter adds a cell with that text
    // tapping on a cell brings the detail VC for that message thread
    // messages, if any, are cells in the detail VC
    // tapping back pops VC off stack
    // tapping plus adds new message view to stack
    // tapping send with empty fields should prevent creating a new message (it currently does not)
    // tapping send with populated fields creates a new message and pops the view off stack
    // the detail VC now has an additional cell with the new message
    // creating a new message does not throw an error

    var messageThreadController = MessageThreadController()
    
    // Fetch existing messages from server and make sure there is one or more.
    func testFetchMessages() {
        let expectation = self.expectation(description: "Fetching")
        
        self.messageThreadController.fetchMessageThreads {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(messageThreadController.messageThreads.count > 0)
    }
    
    // Create a new message and verify it is saved in the array
    func testCreateNewMessage() {
        let expectation = self.expectation(description: "NewMessage")
        
        self.messageThreadController.createMessageThread(with: "testing create new message for unit test") {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(self.messageThreadController.messageThreads.count == 1)
    }
    
    // Fetch the current messages, get the count, add a new message and check the new count.
    func testAddingNewMessageToArray() {
        var messagesCount = 0
        let expectationFetching = self.expectation(description: "Fetching")
        self.messageThreadController.fetchMessageThreads {
            expectationFetching.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        messagesCount = self.messageThreadController.messageThreads.count
        
        let expectationNewMessage = self.expectation(description: "NewMessage")
        
        self.messageThreadController.createMessageThread(with: "testing create new message for unit test") {
            expectationNewMessage.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(messagesCount + 1, self.messageThreadController.messageThreads.count)
    }
}
