//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Spencer Curtis on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    // MARK: - Properties

    // FIXED: Removed static let
    let baseURL = URL(string: "https://kidsfly-43b49.firebaseio.com/")!
    var messageThreads: [MessageThread] = []
    
    
    // MARK: - Fetch from Server
    func fetchMessageThreads(completion: @escaping () -> Void) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        // This if statement and the code inside it is used for UI Testing. Disregard this when debugging.
        if isUITesting {
            fetchLocalMessageThreads(completion: completion)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching message threads: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(); return }
            
            do {
                
                // FIXED: changed decoding format into a dictionary and then pulled out the values (MessageThreads)
                let messages = try JSONDecoder().decode([String : MessageThread].self, from: data).map() { $0.value }
                self.messageThreads = messages
            } catch {
                self.messageThreads = []
                NSLog("Error decoding message threads from JSON data: \(error)")
            }
            
            completion()
            
            // FIXED: added .resume() command
        }.resume()
    }
    
    // MARK: - Create Message Thread
    func createMessageThread(with title: String, completion: @escaping () -> Void) {
        
        // This if statement and the code inside it is used for UI Testing. Disregard this when debugging.
        if isUITesting {
            createLocalMessageThread(with: title, completion: completion)
            return
        }
        
        let thread = MessageThread(title: title)
        
        let requestURL = baseURL.appendingPathComponent(thread.identifier).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(thread)
        } catch {
            NSLog("Error encoding thread to JSON: \(error)")
            
            // FIXED: add return
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error with message thread creation data task: \(error)")
                completion()
                return
            }
            
            self.messageThreads.append(thread)
            completion()
            
        }.resume()
    }
    
    // MARK: - New Message in Thread
    func createMessage(in messageThread: MessageThread, withText text: String, sender: String, completion: @escaping () -> Void) {
        
        // This if statement and the code inside it is used for UI Testing. Disregard this when debugging.
        if isUITesting {
            createLocalMessage(in: messageThread, withText: text, sender: sender, completion: completion)
            return
        }
        
        guard let index = messageThreads.index(of: messageThread) else { completion(); return }
        
        let message = MessageThread.Message(text: text, sender: sender)
        messageThreads[index].messages.append(message)
        
        let requestURL = baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            NSLog("Error encoding message to JSON: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error with message thread creation data task: \(error)")
                completion()
                return
            }
            
            completion()
            
        }.resume()
    }
    
    // MARK: - Delete from Server
    func deleteEntryFromServer(_ messageThread: MessageThread, completion: @escaping (Error?) -> Void = {_ in }) {
        let identifier = messageThread.identifier
        
        let requestURL = baseURL.appendingPathComponent(identifier).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            guard error == nil else {
                print("Error deleting task: \(error!)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
        
    }


}
