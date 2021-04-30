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
    }
    
    @IBAction func messageSwitch(_ sender: Any) {
    }
    @IBAction func callSwitch(_ sender: Any) {
    }
    @IBAction func addButton(_ sender: Any) {
        var arrayName = [String]()
        var arrayPhone = [String]()
        
        do {
            arrayName.append(ecFullNameField.text ?? "String")
            arrayPhone.append(ecPhoneField.text ?? "String")
            
            let currentUser = PFUser.current()
            print(currentUser?.username ?? "String")
            
            currentUser?.setValue(arrayName, forKey: "contactName")
            currentUser?.setValue(arrayPhone, forKey: "contactPhone")
            
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
