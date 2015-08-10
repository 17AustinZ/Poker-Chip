//
//  ConfigureTableViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 7/29/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import Bohr
class ConfigureContainerViewController : UIViewController{

    var bettingStructure : BettingViewController.bettingLimit?
    var startingChips : Int? = 100
    var configVC : PlayerListViewController!
    var splitPot : Bool?
    override func viewDidLoad() {
        navigationController?.navigationBarHidden = false
    }
    
    @IBAction func addPlayer(sender: AnyObject) {
        configVC.addNewPlayer()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGame" {
            super.prepareForSegue(segue, sender: sender)
            var bettingVC : BettingViewController = segue.destinationViewController as! BettingViewController
            
            bettingVC.players = configVC.playerList
//            var splitSwitch = configVC.tableView.cellForRowAtIndexPath(NSIndexPath(indexes: [0,0], length: 2)) as! BOSwitchTableViewCell
//            splitPot = splitSwitch.toggleSwitch.on
//

        } else if segue.identifier == "embedConfig" {
            configVC  = segue.destinationViewController as! PlayerListViewController
        }

        
        
    }
}