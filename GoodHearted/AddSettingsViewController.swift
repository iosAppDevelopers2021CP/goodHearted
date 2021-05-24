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
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func addButton(_ sender: Any) {
        var arrayName = [String]()
        var arrayPhone = [String]()
        var arrayEmail = [String]()
        let user = PFUser.current()
        arrayName = user?["contactName"] as! [String]
        arrayPhone = user?["contactPhone"] as! [String]
        arrayEmail = user?["contactEmail"] as! [String]
        
        do {
            arrayName.append(ecFullNameField.text ?? "String")
            arrayPhone.append(ecPhoneField.text ?? "String")
            arrayEmail.append(ecEmailField.text ?? "String")
            
            print(user?.username ?? "String")
            
            user?.setValue(arrayName, forKey: "contactName")
            user?.setValue(arrayPhone, forKey: "contactPhone")
            user?.setValue(arrayEmail, forKey: "contactEmail")
            
            user?.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("object has been saved!")
                    self.showResponseAlert(title:"GoodHearted",message:"The Emergency Contact Has Been Added!")
                } else {
                    print("error!")
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
