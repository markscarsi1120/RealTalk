//
//  ChatVC.swift
//  RealTalk
//
//  Created by Mark Scarsi on 10/6/19.
//  Copyright © 2019 RealTalk. All rights reserved.
//

import UIKit
import MessageKit
import FirebaseFirestore

class ChatVC: MessagesViewController {
    var db = Firestore.firestore()
    var groupID: String = ""
    var user: User?
    var messages: [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self as? MessagesDataSource
        messagesCollectionView.messagesLayoutDelegate = self as? MessagesLayoutDelegate
        messagesCollectionView.messagesDisplayDelegate = self as? MessagesDisplayDelegate
        db.collection("groups").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for i in querySnapshot!.documents {
                    if (i.documentID == self.user!.groupUID){
                        self.messages = i.data()["messages"] as! [[String : Any]]
                       
                    }
                }
            }
            
        }
        for i in messages{
            print (i)
        }
    }

}
