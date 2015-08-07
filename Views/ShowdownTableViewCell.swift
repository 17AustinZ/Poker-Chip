//
//  ShowdownTableViewCell.swift
//  ChipManager
//
//  Created by Austin Zhang on 8/7/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation

class ShowdownTableViewCell: UITableViewCell {

    var name : String? {
        didSet{
            if let name = name{
                playerName.text = name
            }

        }
    }

    @IBOutlet weak var playerName: UILabel!


  

}