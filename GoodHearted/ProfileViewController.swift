//
//  ProfileViewController.swift
//  GoodHearted
//
//  Created by Le Thuy on 4/21/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var user = PFUser()
    var contactNames = [String] ()
    var contactPhones = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        displayInfor()
        self.contactNames =  user["contactName"] as! [String]
        self.contactPhones = user["contactPhone"] as! [String]
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayInfor()
    }

    func displayInfor() {
        self.user = PFUser.current()!
        userName.text = user["fullName"] as? String
        userEmail.text = user.email
        userPhone.text = user["phone"] as? String
        let imageFile = user["profileImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL (string: urlString)!
        profileImage.af_setImage(withURL: url)
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.contentMode = .scaleAspectFill
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyContactCell") as! EmergencyContactCell

        print(contactNames)
        print(contactPhones)
        cell.contactName?.text = contactNames[indexPath.row]
        cell.contactPhone?.text = contactPhones[indexPath.row]
        
        return cell
    }
}
