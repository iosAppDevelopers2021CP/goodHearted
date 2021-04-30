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
    @IBOutlet var emergencyList: UITableView!
    var arrayName = [String]()
    var arrayPhone = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()
        let query = PFQuery(className:"User")
        print("Here \(user?.objectId)")
        query.whereKey("objectId", equalTo:(user?.objectId!)!)
    
        query.getObjectInBackground(withId: (user?.objectId!)!) { object, error in
            if error == nil {
                print("Here2 \(object!)")
                self.arrayName = object?["contactName"] as! [String]
            }
            else {
                print("Here3 \(error!)")
            }
        }
        
        
        
        
//        query.getObjectInBackground(withId: user!["username"] as! String) { object, error in
//            if error == nil {
//                print(user?.username ?? "String")
//                self.arrayName = object?["contactName"] as! [String]
//            }
//            else {
//                print(error ?? "String")
//            }
//        }
//        let query1 = PFQuery(className:"User")
//        query1.getObjectInBackground(withId: user!["username"] as! String) { object, error in
//            if error == nil {
//                print(user?.username ?? "String")
//                self.arrayPhone = object?["contactPhone"] as! [String]
//            }
//            else {
//                print(error ?? "String")
//            }
//        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = emergencyList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let contact = arrayName[indexPath.row]
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
