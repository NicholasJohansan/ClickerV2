//
//  ScoreTableViewCell.swift
//  Clicker V2
//
//  Created by Johansan on 22/8/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var cpsLabel: UILabel!
    @IBOutlet weak var newView: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            timeView.backgroundColor = .systemBlue
            selectedBackgroundView?.backgroundColor = .white
        } else {
            timeView.backgroundColor = .systemGreen
        }
        
    }

}
