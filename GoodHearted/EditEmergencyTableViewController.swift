//
//  EditEmergencyTableViewController.swift
//  GoodHearted
//
//  Created by Truc Phan on 4/27/21.
//

import UIKit
import Parse
import AlamofireImage

class EditEmergencyTableViewController: UITableViewController {
    @IBOutlet var emergencyList: UITableView! {
        didSet {
            emergencyList.dataSource = self
            emergencyList.delegate = self
        }
    }
    var arrayName = [String]()
    var arrayPhone = [String]()
    let user = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
            self.refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        
        let userId = user!.objectId!
        print("Here \(userId)")
        self.arrayName = user?["contactName"] as! [String]
        self.arrayPhone = user?["contactPhone"] as! [String]
        self.emergencyList.reloadData()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refreshControl = UIRefreshControl()
            self.refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        
        let userId = user!.objectId!
        print("Here \(userId)")
        self.arrayName = user?["contactName"] as! [String]
        self.arrayPhone = user?["contactPhone"] as! [String]
        self.emergencyList.reloadData()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        self.refreshControl!.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = emergencyList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditEmergencyContactCell
        cell.contactNameField.text = arrayName[indexPath.row]
        cell.contactPhoneField.text = arrayPhone[indexPath.row]
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            arrayName.remove(at: indexPath.row)
            arrayPhone.remove(at: indexPath.row)
            user?.setValue(arrayName, forKey: "contactName")
            user?.setValue(arrayPhone, forKey: "contactPhone")
            user?.saveInBackground()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            self.emergencyList.reloadData()
        }
    }
}
