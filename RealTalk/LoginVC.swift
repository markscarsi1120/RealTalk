//
//  LoginVC.swift
//  RealTalk
//
//  Created by Mark Scarsi on 9/24/19.
//  Copyright © 2019 RealTalk. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func login(_ sender: Any) {
        if(usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            print( "Please fill in all fields")
        
        }
        else {
            let email: String = (usernameTextField.text)!
            let password: String = (passwordTextField.text)!
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil{
                    print(error)
                }
                else {
                    self.performSegue(withIdentifier: "LoginToSuccess", sender: self)
                }
            }
        }
    }
    
}
