//
//  memeTableViewCell.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/12.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit

class memeTableViewCell: UITableViewCell {
    @IBOutlet weak var memePreview: UIImageView!
    @IBOutlet weak var memeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
