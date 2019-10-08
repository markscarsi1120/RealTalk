//
//  SignUpVC.swift
//  RealTalk
//
//  Created by Mark Scarsi on 9/24/19.
//  Copyright © 2019 RealTalk. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var feelings: [String] = ["Anxious", "Depressed", "Additction"]
    var selectedTraits: [String] = []
    var db = Firestore.firestore()
    var email: String?
    var username: String?
    var date: Date?
    var user: User?
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var feelingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feelingTableView.dataSource = self
        self.feelingTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func submit(_ sender: Any) {
        var error: String = ""
        if(usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            error += "All Fields Must Be Filled In"
        }
        if (selectedTraits.count == 0){
            error += "; Please Select One or More Symptoms"
        }
        email = emailTextField.text!
        username = usernameTextField.text!
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for i in querySnapshot!.documents {
                    print ("________")
                    print (i.data()["username"] as! String)
                    print (self.username!)
                    print ("---------")
                    if ((i.data()["username"] as! String) == self.username!){
                        print ("SAMESIES")
                        error += "Username Already Exists"
                        print (error)
                    }
                }
            }
            if (error == ""){
                Auth.auth().createUser(withEmail: self.email!, password: self.passwordTextField.text!) { authResult, error in
                    if (error != nil){
                    print (error as Any)
                    }
                    else {
                        self.date = Date()
                        print(authResult?.additionalUserInfo as Any)
                        self.db.collection("users").document(self.email!).setData(["email":self.email!,"username": self.username!, "symptoms": self.selectedTraits, "gAssigned": "0", "currGID": "", "numberOfChats": 0, "recentUpdate": self.date as Any])
                        self.user = User(email: self.email!, username: self.username!, groupAssigned: false, groupUID: "", symptoms: self.selectedTraits, numberOfChats: 0, recentClick: self.date!)
                        self.performSegue(withIdentifier: "SignUpToSuccess", sender: self)
                    }
                }
            }
            else {
                let alertController = UIAlertController(title: "Input Error", message:
                error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    func adjust(op: String, item: String) -> Void{
        if (op == "Add"){
            selectedTraits.append(item)
        }
        else {
            var i: Int = 0
            while i < selectedTraits.count{
                if (selectedTraits[i] == item){
                    selectedTraits.remove(at: i)
                }
                i += 1
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feelings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feelingCell", for: indexPath ) as! FeelingTableViewCell
        cell.vc = self
        cell.label.text = feelings[indexPath.row]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SignUpToSuccess"){
            let displayVC = segue.destination as! SuccessVC
            displayVC.user = self.user!
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        return true
    }
}
