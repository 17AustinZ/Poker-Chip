//
//  PlayerCell.swift
//  ChipManager
//
//  Created by Austin Zhang on 8/9/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
class PlayerCell : UITableViewCell{

    @IBOutlet weak var chipNumber: UILabel!

    @IBOutlet weak var nameLabel: UILabel!

    var player : Player? {
        didSet{
            if let player = player, chipNumber = chipNumber, nameLabel = nameLabel{
                self.chipNumber.text = String(player.chips!)
                self.nameLabel.text = player.name!
            }
        }
    }

}