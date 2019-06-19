//
//  rollTableView.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/19.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit

class rollTableView: UITableView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
