//
//  BettingStructureCell.swift
//  ChipManager
//
//  Created by Austin Zhang on 7/28/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import Bohr


class BettingStructureCell : BOChoiceTableViewCell{
    var BettingStructureOptions : ConfigureTableViewController?
    
    override func wasSelectedFromViewController(viewController: BOTableViewController!) {
        self.detailTextLabel?.text = "asdf"
        self.textLabel?.text = "asdf"
        self.settingValueDidChange()
        println("check")
        
    }
    
}