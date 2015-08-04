//
//  ConfigureTableViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 7/29/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
class ConfigureContainerViewController : UIViewController{
    
    enum bettingStructure {
        case Default
        case NoLimit
        case FixedLimit
        case PotLimit
        case SpreadLimit
    }
    var startingChips : Int? = 100
    
    override func viewDidLoad() {
        navigationController?.navigationBarHidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "toGame" {
            super.prepareForSegue(segue, sender: sender)
            //            navigationController?.setNavigationBarHidden(false, animated: true)
            var bettingVC : BettingViewController = segue.destinationViewController as! BettingViewController
            bettingVC.players = [
                
                Player(name: "P01", startChips: startingChips!, color: 1),
                Player(name: "P02", startChips: startingChips!, color: 2),
                Player(name: "P03", startChips: startingChips!, color: 3),
                Player(name: "P04", startChips: startingChips!, color: 4),
                Player(name: "P05", startChips: startingChips!, color: 5),
                Player(name: "P06", startChips: startingChips!, color: 6),
                Player(name: "P07", startChips: startingChips!, color: 7),
                Player(name: "P08", startChips: startingChips!, color: 8)]
        }
        
        
    }
}