//
//  DayTableViewCell.swift
//  ThoughtsLogger
//
//  Created by Nabil Baalbaki on 8/6/16.
//  Copyright © 2016 Nabil Baalbaki. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    // MARK: PROPERTIES
    @IBOutlet weak var fileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
