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
            

//            bettingVC.players = Universal.sharedInstance.playersList
//            bettingVC.players = [
//                Player(name: "1", startChips: 100, color: 1),
//                Player(name: "2", startChips: 100, color: 2),
//                Player(name: "3", startChips: 100, color: 3),
//                Player(name: "4", startChips: 100, color: 4),
//                Player(name: "5", startChips: 100, color: 5),
//                Player(name: "6", startChips: 100, color: 6),
//                Player(name: "7", startChips: 100, color: 7)
//            ]


            //            var splitSwitch = configVC.tableView.cellForRowAtIndexPath(NSIndexPath(indexes: [0,0], length: 2))vi as! BOSwitchTableViewCell
//            splitPot = splitSwitch.toggleSwitch.on
//

        } else if segue.identifier == "embedConfig" {
            configVC  = segue.destinationViewController as! PlayerListViewController
        }

        
        
    }
}