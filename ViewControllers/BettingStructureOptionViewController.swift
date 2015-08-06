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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected")
        println(indexPath)
        println(indexPath.indexAtPosition(1))
        
        var oldPath = ConfigVC?.selectedStructurePath
        if oldPath != nil{
            tableView.cellForRowAtIndexPath(oldPath!)!.accessoryType = UITableViewCellAccessoryType.None
            
        }
        var index : Int = indexPath.indexAtPosition(1)
        ConfigVC?.selectedStructurePath = indexPath
        
        
        tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.Checkmark
//        tableView.cellForRowAtIndexPath(indexPath)?.detailTextLabel?.text = "asdf"
        //        tableView.cellForRowAtIndexPath(indexPath)?.setNeedsLayout()
        //        tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()
    }
    
    
}