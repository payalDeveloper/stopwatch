//
//  LapTableViewCell.swift
//  Stopwatch
//
//  Created by payal on 11/02/18.
//  Copyright © 2018 payal. All rights reserved.
//

import UIKit

class LapTableViewCell: UITableViewCell {

    @IBOutlet weak var lapLabel: UILabel!
    @IBOutlet weak var cellTimerHourLabel: UILabel!
    @IBOutlet weak var cellTimerMinLabel: UILabel!
    @IBOutlet weak var cellTimerSecLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
