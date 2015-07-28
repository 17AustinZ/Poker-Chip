//
//  BOConfigureViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 7/28/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import Bohr

class BOConfigureViewController : BOTableViewController{
    
    @IBOutlet weak var bettingStructure: BOChoiceTableViewCell!
    
    override func setup() {
        bettingStructure.options = ["Option 1", "Option 2", "Option 3"]
        bettingStructure.settingValueDidChange()
    }
}