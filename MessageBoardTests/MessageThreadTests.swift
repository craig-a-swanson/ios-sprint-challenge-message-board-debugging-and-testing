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
    //
}
