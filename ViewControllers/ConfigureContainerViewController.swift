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
        } else if segue.identifier == "embedConfig" {
            configVC  = segue.destinationViewController as! PlayerListViewController
        }

        
        
    }
}