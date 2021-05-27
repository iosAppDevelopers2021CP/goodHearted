//
//  EditContactViewController.swift
//  GoodHearted
//
//  Created by Truc Phan on 5/16/21.
//

import UIKit
import Parse
import AlamofireImage

class EditContactViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactPhone: UITextField!
    @IBOutlet weak var contactEmail: UITextField!
    
    let user = PFUser.current()
    var image = UIImageView()
    var name = String()
    var phone = String()
    var email = String()
    
    var arrayName = [String]()
    var arrayPhone = [String]()
    var arrayEmail = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        contactName.text = name
        contactPhone.text = phone
        contactEmail.text = email
        
        self.arrayName = user?["contactName"] as! [String]
        self.arrayPhone = user?["contactPhone"] as! [String]
        self.arrayEmail = user?["contactEmail"] as! [String]
    }
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true

        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.sourceType = .camera
        }

        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 200, height: 200)
        let scaledImage = image.af_imageAspectScaled(toFit: size)
        
        profileImage.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveContactInfo(_ sender: Any) {
        let index = find(value: email, in: arrayEmail)
        arrayName[index!] = contactName.text!
        arrayPhone[index!] = contactPhone.text!
        arrayEmail[index!] = contactEmail.text!
        
        user?.setValue(arrayName, forKey: "contactName")
        user?.setValue(arrayPhone, forKey: "contactPhone")
        user?.setValue(arrayEmail, forKey: "contactEmail")
        
        // Alert
        let optionMenu = UIAlertController(title: nil, message: "Information has been saved!", preferredStyle: .alert)
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler:
                nil)
            optionMenu.addAction(cancelAction)
        // Display the menu
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func find(value searchValue: String, in array: [String]) -> Int?
    {
        for (index, value) in array.enumerated()
        {
            if value == searchValue {
                return index
            }
        }
        return nil
    }
}
