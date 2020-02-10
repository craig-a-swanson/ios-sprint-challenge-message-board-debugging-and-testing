//
//  MessageThread.swift
//  Message Board
//
//  Created by Spencer Curtis on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {

    let title: String
    var messages: [MessageThread.Message]
    let identifier: String

    init(title: String, messages: [MessageThread.Message] = [], identifier: String = UUID().uuidString) {
        self.title = title
        self.messages = messages
        self.identifier = identifier
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case messages
        case identifier
        
        enum MessageKeys: String, CodingKey {
            case text
            case sender
            case timestamp
        }
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        
//        let messagesKeyedContainer = try container.nestedContainer(keyedBy: CodingKeys.MessageKeys.self, forKey: .messages)
//
//
//        var messageList: [MessageThread.Message] = []
//        for key in messagesKeyedContainer.allKeys {
//            let messagesContainer = try messagesKeyedContainer.nestedContainer(keyedBy: CodingKeys.MessageKeys.self, forKey: key)
//        let text = try messagesContainer.decode(String.self, forKey: .text)
//        let sender = try messagesContainer.decode(String.self, forKey: .sender)
//        let timestamp = try messagesContainer.decode(Date.self, forKey: .timestamp)
//
//            let newMessage = Message(text: text, sender: sender, timestamp: timestamp)
//            messageList.append(newMessage)
//        }
//        self.messages = messageList

        
        
//        // ORIGINAL
        // FIXED: Changed data type to a dictionary of type [String:Message], then for our model we pull out just the values of the dictionary.
        let messages = try container.decodeIfPresent([String : Message].self, forKey: .messages) ?? [:]
        self.messages = Array(messages.values)
        self.title = title
        self.identifier = identifier
    }

    
    struct Message: Codable, Equatable {
        
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
    }
    
    static func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
}
