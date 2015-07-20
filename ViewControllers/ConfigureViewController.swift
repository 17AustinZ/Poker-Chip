//
//  ConfigureController.swift
//  Poker Chip App
//
//  Created by Austin Zhang on 7/15/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation

import SimpleAlert
import UIKit
//import DKDropMenu
//import CZPicker
//import CZPickerView
//import CZViewController



class ConfigureViewController: UIViewController{
    
    var betStructure = bettingStructure.NoLimit

    enum bettingStructure {
        case NoLimit
        case FixedLimit
        case PotLimit
        case SpreadLimit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        super.prepareForSegue(segue, sender: sender)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBOutlet weak var bettingStructureDisplay: UILabel!

    @IBAction func changeBettingStructure(sender: AnyObject) {
        let CBSAlert = SimpleAlert.Controller(title: "Betting Structure", message: "", style: .Alert)

        
        CBSAlert.addAction(SimpleAlert.Action(title: "No Limit", style: SimpleAlert.Action.Style.Default , handler: {(alertAction : SimpleAlert.Action!) -> Void in
            self.betStructure = .NoLimit
        }))
        
        CBSAlert.addAction(SimpleAlert.Action(title: "Fixed Limit", style: .Default , handler: {(alertAction : SimpleAlert.Action!) -> Void in
            self.betStructure = .FixedLimit
        }))
        
        CBSAlert.addAction(SimpleAlert.Action(title: "Pot Limit", style: .Default , handler: {(alertAction : SimpleAlert.Action!) -> Void in
            self.betStructure = .PotLimit
        }))
        
        CBSAlert.addAction(SimpleAlert.Action(title: "Spread Limit", style: .Default , handler: {(alertAction : SimpleAlert.Action!) -> Void in
            self.betStructure = .SpreadLimit
        }))
        switch betStructure{
        case .FixedLimit:
            self.bettingStructureDisplay.text = "Fixed Limit"
        case .NoLimit:
            self.bettingStructureDisplay.text = "No Limit"
        case .PotLimit:
            self.bettingStructureDisplay.text = "Pot Limit"
        case .SpreadLimit:
            self.bettingStructureDisplay.text = "Spread Limit"
        }
        
        presentViewController(CBSAlert, animated: true, completion: nil)
    }
    
    
    
}
