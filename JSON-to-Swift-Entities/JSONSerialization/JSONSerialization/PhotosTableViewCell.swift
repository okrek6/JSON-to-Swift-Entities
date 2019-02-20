//
//  PhotosTableViewCell.swift
//  JSONSerialization
//
//  Created by Brendan Krekeler on 2/20/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var photoName: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
