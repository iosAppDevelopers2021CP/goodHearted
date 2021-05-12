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
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        if !usernameField.hasText || !userPasswordField.hasText {
            // Alert
            let optionMenu = UIAlertController(title: nil, message: "Fields cannot be left blank!", preferredStyle: .alert)
            // Add actions to the menu
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:
                    nil)
                optionMenu.addAction(cancelAction)
            // Display the menu
            self.present(optionMenu, animated: true, completion: nil)
        }
        
        let username = usernameField.text!
        let password = userPasswordField.text!
        
        UserDefaults.standard.set(true, forKey: "userLoggedIn")
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                let optionMenu = UIAlertController(title: nil, message: "Invalid username or password!", preferredStyle: .alert)
                // Add actions to the menu
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:
                        nil)
                    optionMenu.addAction(cancelAction)
                // Display the menu
                self.present(optionMenu, animated: true, completion: nil)
                print(error!)
            }
        }
    }
    
}
