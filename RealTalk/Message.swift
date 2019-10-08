//
//  Message.swift
//  RealTalk
//
//  Created by Mark Scarsi on 10/6/19.
//  Copyright © 2019 RealTalk. All rights reserved.
//

import Foundation

struct Message {
    var messageText: String
    var sender: Sender
    var timestamp: Date
    init (messageText: String, sender: Sender, timestamp: Date){
        self.messageText = messageText
        self.sender = sender
        self.timestamp = timestamp
    }
}
