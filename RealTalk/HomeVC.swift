//
//  HomeVC.swift
//  RealTalk
//
//  Created by Mark Scarsi on 9/24/19.
//  Copyright © 2019 RealTalk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class HomeVC: UIViewController {
    var firstEver: Int = 0
    var user: User?
    var db = Firestore.firestore()
    var groups: [String: Double] = [:]
    @IBOutlet weak var seeChatsButton: UIButton!
    
    @IBOutlet weak var groupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("groups").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if (querySnapshot!.documents.count == 0){
                    self.firstEver = 1
                }
                else {
                    var smallestGroupMembers: Int = 5
                    for i in querySnapshot!.documents {
                        if ((i.data()["symptoms"] as! [String] == self.user!.symptoms) && ((i.data()["members"] as! Int) < smallestGroupMembers)){
                            smallestGroupMembers = i.data()["members"] as! Int
                        }
                    }
                    for document in querySnapshot!.documents {
                        print (document.data())
                        print (document.data()["symptoms"] as! [String])
                        print ("PENIS")
                        print (self.user!.symptoms)
                        if ((document.data()["members"] as! Int) == smallestGroupMembers && smallestGroupMembers < 5 && document.data()["symptoms"] as! [String] == self.user!.symptoms){
                            var score: Double = 0.0
                            score += ((((document.data()["lastUpdated"] as! Timestamp).dateValue() ).timeIntervalSinceNow) * -1)
                            self.groups[document.documentID ] = score
                            print ("HERE")
                        }
                    }
                }
                
            }
        }
        if (user!.numberOfChats > 0){
            seeChatsButton.alpha = 1.0
        }
        if (user?.groupAssigned == true){
            groupButton.setTitle("Leave Group", for: .normal)
        }
        else{
            groupButton.setTitle("Join New Group", for: .normal)
        }
        
    }
    
    @IBAction func seeChats(_ sender: Any) {
        if (user!.numberOfChats > 0){
            self.performSegue(withIdentifier: "HomeToChat", sender: self)
        }
    }
    @IBAction func joinleaveGroup(_ sender: Any) {
        if (groupButton.titleLabel!.text == "Leave Group"){
            //alert goes here that are you sure?
            db.collection("groups").document(user!.groupUID).updateData(["names": FieldValue.arrayRemove([user?.username]), "members":  FieldValue.increment(Int64(-1))])
            groupButton.setTitle("Join New Group", for: .normal)
            db.collection("users").document(user!.email).updateData(["currGID": ""])
        }
        else {
            var smallestScore: Double = -1.0
            print ("&*&*&*&*&*&*&*&*&*&*&*")
            print ("FIRST EVER IS:")
            print(firstEver)
            print ("&*&*&*&*&*&*&*&*&*&*&*")
            print ("%^%^%^%^%^%^%^%^%^%^%^")
            print ("GROUPS COUNT IS:")
            print (groups.count)
            print ("%^%^%^%^%^%^%^%^%^%^%^")
            
            if (firstEver != 1 && groups.count != 0){
                var smallestUID: String = ""
                for (id, score) in groups{
                    if (score < smallestScore || smallestScore < 0){
                        print ("HERE INNER")
                        print ("WeeNIE")
                        print (score)
                        print (id)
                        print ("WEENIS")
                        smallestScore = score
                        smallestUID = id
                    }
                }
                self.user?.groupUID = smallestUID
                db.collection("groups").document(smallestUID).updateData(["names": FieldValue.arrayUnion([user?.username]), "members":  FieldValue.increment(Int64(1))])
                db.collection("users").document(user!.email).updateData(["currGID": smallestUID, "numberOfChats": FieldValue.increment(Int64(1))])
            }
            else{
                var nameArr: [String] = []
                nameArr.append(self.user!.username)
                let newCityRef = db.collection("groups").document()
                newCityRef.setData( [
                    "members":1,
                    "symptoms":user?.symptoms,
                    "names": nameArr,
                    "lastUpdated": Date()
                    
                ])
                print (newCityRef.documentID)
                self.user?.groupUID = newCityRef.documentID
            }
        }
        let docRefUser = db.collection("users").document(user!.email)

        docRefUser.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!["numberOfChats"] as! Int
                if (dataDescription > 0){
                    self.seeChatsButton.alpha = 1.0
                    print ("seeCHATSBUTTON ALPHA SHOULD BE FUCKING 1")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "HomeToChat"){
            let displayVC = segue.destination as! ChatVC
            displayVC.user = self.user!
        }
    }
}
