//
//  AddEmergencyViewController.swift
//  GoodHearted
//
//  Created by Truc Phan on 4/20/21.
//

import UIKit
import Parse

class AddSettingsController: UIViewController {
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
        let user = PFUser.current()
        arrayName = user?["contactName"] as! [String]
        arrayPhone = user?["contactPhone"] as! [String]
        
        do {
            arrayName.append(ecFullNameField.text ?? "String")
            arrayPhone.append(ecPhoneField.text ?? "String")
            
            print(user?.username ?? "String")
            
            user?.setValue(arrayName, forKey: "contactName")
            user?.setValue(arrayPhone, forKey: "contactPhone")
            
            user?.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("object has been saved!")
                } else {
                    print("error!")
                }
            }
        }
    }
}
