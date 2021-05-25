//
//  SettingsViewController.swift
//  GoodHearted
//
//  Created by Ali Ma on 5/8/21.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {
   // let user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Are you sure you want to sign out?",
            message: "",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive) { (action) in
            // return
        }

        let confirmAction = UIAlertAction(
            title: "OK", style: .default) { (action) in
            PFUser.logOut()
            
            let main = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
            let delegate =  self.view.window?.windowScene?.delegate as! SceneDelegate
            UserDefaults.standard.set(false, forKey: "userLoggedIn")
            delegate.window?.rootViewController = loginViewController
        }

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
