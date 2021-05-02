//
//  EditProfileViewController.swift
//  GoodHearted
//
//  Created by Le Thuy on 4/27/21.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    
    var user = PFUser.current()
    let friend = PFObject(className: "User")
    
    
    @IBAction func editProfileImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.sourceType = .camera
        }
        else
        {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 200, height: 200)
        let scaledImage = image.af_imageAspectScaled(toFit: size)
        
        userImage.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Save(_ sender: Any) {
        if (!(userName.text!).isEmpty && !(userEmail.text!).isEmpty && !(userPhone.text!).isEmpty)
        {
            user?.setValue(userPhone.text!, forKey: "phone")
            user?.setValue(userName.text!, forKey: "fullName")
            user?.setValue(userEmail.text!, forKey: "email")
            
            let imageData = userImage.image!.pngData()
            let file = PFFileObject(name: "profileImage.png", data: imageData!)
            user?.setValue(file, forKey: "profileImage")
            
            user?.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                self.dismiss(animated: true, completion: nil)
                print("object has been saved!")
                let alertController = UIAlertController (title: "GoodHearted", message: "Your Profile Has Been Updated!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
              }
              else {
                print("object has not been saved! Error!")
                // There was a problem, check error.description
              }
            }
        }
        else
        {
            print("Error Saving")
            let alertController = UIAlertController (title: "GoodHearted", message: "Cannot Leave Any Field Blank!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = user!["fullName"] as? String
        userEmail.text = user!.email
        userPhone.text = user!["phone"] as? String
        let imageFile = user!["profileImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL (string: urlString)!
        userImage.af_setImage(withURL: url)
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.contentMode = .scaleAspectFill
        // Do any additional setup after loading the view.
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
