//
//  signUpViewController.swift
//  GoodHearted
//
//  Created by Ali Ma on 4/22/21.
//

import UIKit
import Parse

private let reuseIdentifier = "Cell"

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class signUpViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var userFullNameField: UITextField!
    @IBOutlet weak var userEmailField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var userPhoneNumberField: UITextField!
    @IBOutlet weak var agreeTerms: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        agreeTerms.isOn = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    @IBAction func backFromSignUpButton(_ sender: Any) {
    }
    @IBAction func submitSignUpButton(_ sender: Any) {
        if !userFullNameField.hasText || !userEmailField.hasText ||
            !userNameField.hasText || !userPasswordField.hasText ||
            !userPhoneNumberField.hasText {
            // Alert
            let optionMenu = UIAlertController(title: nil, message: "Fields cannot be left blank!", preferredStyle: .alert)
            // Add actions to the menu
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler:
                    nil)
                optionMenu.addAction(cancelAction)
            // Display the menu
            self.present(optionMenu, animated: true, completion: nil)
        }
        
        if (!agreeTerms.isOn) {
            // Alert
            let optionMenu = UIAlertController(title: nil, message: "Please agree to Terms and Conditions to successfully sign up!", preferredStyle: .alert)
            // Add actions to the menu
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler:
                    nil)
                optionMenu.addAction(cancelAction)
            // Display the menu
            self.present(optionMenu, animated: true, completion: nil)
        }
        
        else {
            let user = PFUser()
            user.username = userNameField.text!
            user.password = userPasswordField.text!
            user.email = userEmailField.text!
            // other fields can be set just like with PFObject
            user["phone"] = userPhoneNumberField.text
            user["fullName"] = userFullNameField.text!
        
            user.signUpInBackground{(success, error) in
                if success{
                    self.performSegue(withIdentifier: "signUpSegue", sender: nil)
                } else {
                    print("Error: signUpNotSuccessful")
                }
            
            }
        }
        
    }
    
    func showResponseAlert(title:String?,message:String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alert, animated: true, completion: nil)
         }
    }
}
