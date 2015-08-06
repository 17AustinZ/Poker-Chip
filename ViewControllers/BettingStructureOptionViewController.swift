//
//  BettingStructureOptionViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 7/29/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import SimpleAlert

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

        if (index == 0){ //Fixed Limit
            var fixedPopup = SimpleAlert.Controller(title: "Fixed Limits", message: "", style: SimpleAlert.Controller.Style.Alert)
            fixedPopup.addTextFieldWithConfigurationHandler() { textField in
                textField.frame.size.height = 30
                textField.backgroundColor = nil
                textField.layer.borderColor = nil
                textField.layer.borderWidth = 0
                textField.placeholder = "Limit before first draw"
                textField.borderStyle = UITextBorderStyle.Line
            }

            fixedPopup.addTextFieldWithConfigurationHandler() { textField in
                textField.frame.size.height = 30
                textField.backgroundColor = nil
                textField.layer.borderColor = nil
                textField.layer.borderWidth = 0
                textField.placeholder = "Limit after first draw"
                textField.borderStyle = UITextBorderStyle.Line

            }
            self.presentViewController(fixedPopup, animated: true, completion: {})

            fixedPopup.addAction(SimpleAlert.Action(title: "OK", style: .Default) { action in
                //Setup
                var beforeLimit = fixedPopup.textFields[0].text.toInt()
                var afterLimit = fixedPopup.textFields[1].text.toInt()

                if (beforeLimit != nil && afterLimit != nil){
                    println()
                }
                self.ConfigVC?.selectedStructure  = BettingViewController.bettingLimit.Fixed
            })

        } else if (index == 1){ //Spread Limit

        } else if (index == 2){ //Pot Limit

        } else if (index == 3){ //No Limit

        }
        
        tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.Checkmark
//        tableView.cellForRowAtIndexPath(indexPath)?.detailTextLabel?.text = "asdf"
        //        tableView.cellForRowAtIndexPath(indexPath)?.setNeedsLayout()
        //        tableView.cellForRowAtIndexPath(indexPath)?.setNeedsDisplay()
    }
    
    
}