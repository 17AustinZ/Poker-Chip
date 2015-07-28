//
//  BOContainerViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 7/28/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import Bohr

class BOContainerViewController : UIViewController{
    var betStructure : bettingStructure = .Default
    var config : BOConfigureViewController?
    enum bettingStructure {
        case Default
        case NoLimit
        case FixedLimit
        case PotLimit
        case SpreadLimit
    }
    var startingChips : Int? = 0
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "toGame" {
            super.prepareForSegue(segue, sender: sender)
            navigationController?.setNavigationBarHidden(false, animated: true)
            var bettingVC : BettingViewController = segue.destinationViewController as! BettingViewController
            bettingVC.players = [
                Player(name: "P01", startChips: startingChips!),
                Player(name: "P02", startChips: startingChips!),
                Player(name: "P03", startChips: startingChips!),
                Player(name: "P04", startChips: startingChips!),
                Player(name: "P05", startChips: startingChips!),
                Player(name: "P06", startChips: startingChips!),
                Player(name: "P07", startChips: startingChips!),
                Player(name: "P08", startChips: startingChips!)]
        } else if segue.identifier == "configureEmbed"{
            config = segue.destinationViewController as? BOConfigureViewController
        }
        
        
    }
}