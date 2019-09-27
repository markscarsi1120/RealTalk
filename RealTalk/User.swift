//
//  User.swift
//  RealTalk
//
//  Created by Mark Scarsi on 9/25/19.
//  Copyright © 2019 RealTalk. All rights reserved.
//

import Foundation

struct User {
    var email: String = ""
    var username: String = ""
    var groupAssigned: Bool = false
    var groupUID: String = ""
    var symptoms: [String] = []
    var numberOfChats: Int = 0
    var recentClick: Date = Date()
    init(email: String, username: String, groupAssigned: Bool, groupUID: String, symptoms: [String]?, numberOfChats: Int?, recentClick: Date) {
        self.email = email
        self.username = username
        self.groupAssigned = groupAssigned
        self.groupUID = groupUID
        self.symptoms = symptoms!
        self.numberOfChats = numberOfChats!
        self.recentClick = recentClick
    }
}
