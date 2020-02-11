//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Spencer Curtis on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    // MARK: - Actions
    
    @IBAction func sendMessage(_ sender: Any) {
        
        // FIXED: will not save if senderName or messageText (or both) are empty.
        guard let senderName = senderNameTextField.text,
            !senderName.isEmpty,
            let messageText = messageTextView.text,
            !messageText.isEmpty,
            let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(in: messageThread, withText: messageText, sender: senderName, completion: {
            
            // FIXED:  popped view controller after creating message.
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }

    // MARK: - Properties
    
    var messageThreadController: MessageThreadController?
    var messageThread: MessageThread?

    @IBOutlet weak var senderNameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
}
