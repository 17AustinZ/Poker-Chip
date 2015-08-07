//
//  ConfigureTableViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 7/29/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import Bohr
class ConfigureTableViewController: BOTableViewController{
  

    var selectedStructurePath : NSIndexPath?
    var selectedStructureIndex : Int?
    var selectedStructure : BettingViewController.bettingLimit?

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath)
    }

    override func setup() {

    }
    
    override func viewDidLoad() {
        navigationController?.navigationBarHidden = true
        selectedStructureIndex = selectedStructurePath!.indexAtPosition(1)

    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toStructureSelection" {
            var destVC = segue.destinationViewController as! BettingStructureOptionViewController
            destVC.ConfigVC = self
        }
    }
}

