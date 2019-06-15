//
//  localFileMemeTableViewCell.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/15.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit

class localFileMemeTableViewCell: UITableViewCell {
    @IBOutlet weak var memeTitleLabel: UILabel!
    @IBOutlet weak var userTextLabel: UILabel!
    @IBOutlet weak var memePreview: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
