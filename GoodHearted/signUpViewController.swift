//
//  signUpViewController.swift
//  GoodHearted
//
//  Created by Ali Ma on 4/22/21.
//

import UIKit
import Parse

private let reuseIdentifier = "Cell"

class signUpViewController: UIViewController {

    
    @IBOutlet weak var userFullNameField: UITextField!
    @IBOutlet weak var userEmailField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var userPhoneNumberField: UITextField!
    @IBOutlet weak var agreeTerms: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        // Configure the cell
//
//        return cell
//    }
//
//    // MARK: UICollectionViewDelegate
//
//    /*
//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//    }
//    */
//
}
