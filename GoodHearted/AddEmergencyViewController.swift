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
        guard let user = PFUser.current() else {
            print("Fail to get user")
            return
        }
        do {
            user["fullName"] = ecFullNameField.text
            user.email = ecEmailField.text
            user["phone"] = ecPhoneField.text
            try user.save()
            self.performSegue(withIdentifier: "addContactSegue", sender: nil)
        } catch {
            print(error)
        }
    }
    @IBAction func laterButton(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil);
//        let vc = storyboard.instantiateViewController(withIdentifier: "HomeScreen");
//        self.present(vc, animated: true, completion: nil);
        self.performSegue(withIdentifier: "addContactSegue", sender: nil)
    }
}
