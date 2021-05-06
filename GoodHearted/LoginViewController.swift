//
//  LoginViewController.swift
//  GoodHearted
//
//  Created by Babu Rajendran on 4/22/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = userPasswordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error!)
            }
        }
    }
    
}
