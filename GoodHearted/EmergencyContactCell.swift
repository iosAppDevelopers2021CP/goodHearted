//
//  EmergencyContactCell.swift
//  GoodHearted
//
//  Created by Le Thuy on 4/27/21.
//

import UIKit

class EmergencyContactCell: UITableViewCell {

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var contactPhone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
