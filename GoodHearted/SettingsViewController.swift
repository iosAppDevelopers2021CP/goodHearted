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
        PFUser.logOut()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
