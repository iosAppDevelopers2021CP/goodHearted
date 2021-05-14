//
//  EditEmergencyContactCell.swift
//  GoodHearted
//
//  Created by Truc Phan on 4/27/21.
//

import UIKit
import Parse
import AlamofireImage

class EditEmergencyContactCell: UITableViewCell, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    var user = PFUser.current()

    
    @IBOutlet weak var contactNameField: UITextField!
    @IBOutlet weak var contactPhoneField: UITextField!
    @IBOutlet weak var contactProfilePic: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }

}
