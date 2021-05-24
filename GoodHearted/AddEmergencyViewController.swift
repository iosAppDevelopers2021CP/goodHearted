//
//  AddEmergencyViewController.swift
//  GoodHearted
//
//  Created by Truc Phan on 4/20/21.
//

import UIKit
import Parse

class AddEmergencyViewController: UIViewController {
    @IBOutlet weak var ecFullNameField: UITextField!
    @IBOutlet weak var ecEmailField: UITextField!
    @IBOutlet weak var ecPhoneField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func addButton(_ sender: Any) {
        var arrayName = [String]()
        var arrayPhone = [String]()
        var arrayEmail = [String]()
        
        do {
            arrayName.append(ecFullNameField.text ?? "String")
            arrayPhone.append(ecPhoneField.text ?? "String")
            arrayEmail.append(ecEmailField.text ?? "String")
            
            let currentUser = PFUser.current()
            print(currentUser?.username ?? "String")
            
            currentUser?.setValue(arrayName, forKey: "contactName")
            currentUser?.setValue(arrayPhone, forKey: "contactPhone")
            currentUser?.setValue(arrayEmail, forKey: "contactEmail")
            
            currentUser?.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("object has been saved!")
                } else {
                    print("error!")
                }
            }
            
            self.performSegue(withIdentifier: "addContactSegue", sender: nil)
        }
    }
    @IBAction func laterButton(_ sender: Any) {
        self.performSegue(withIdentifier: "addContactSegue", sender: nil)
    }
}
