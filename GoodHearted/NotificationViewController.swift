//
//  NotificationViewController.swift
//  GoodHearted
//
//  Created by Le Thuy on 6/9/21.
//

import UIKit
import Parse

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var refreshControl: UIRefreshControl!
    var Notification = [PFObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 260
        // Do any additional setup after loading the view.
        
//        refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
//        tableView.insertSubview(refreshControl, at: 0)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Notification")
        query.includeKeys(["Author", "Message", "createdAt"])
        query.limit = 20
        
        query.findObjectsInBackground { (Notification, error) in
                if Notification != nil
                {
                    self.Notification = Notification!
                    print(Notification as Any)
                    self.tableView.reloadData()
                }
        }
    }
    
    @objc func onRefresh() {
        run(after: 2) {
               self.refreshControl.endRefreshing()
            }
    }

    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Notification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notification = Notification[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        let user = notification["Author"] as! PFUser
        cell.userName.text = user.username
        let imageFile = user["profileImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL (string: urlString)!
        cell.profileImage.af_setImage(withURL: url)
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
        cell.profileImage.contentMode = .scaleAspectFill
        cell.Message.text = notification["Message"] as? String
        let date = notification.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        cell.date.text = dateFormatter.string(from: date!)
        print(cell.date.text)
        return cell
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
