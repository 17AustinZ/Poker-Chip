//
//  BettingStructureOptionViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 7/29/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation

class BettingStructureOptionViewController: UITableViewController{
    var ConfigVC : ConfigureTableViewController?
    
//    override func viewDidLoad() {
//        
//    }
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected")
        println(indexPath)
        println(indexPath.indexAtPosition(1))
    
    }
}