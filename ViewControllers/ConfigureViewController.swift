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
//import CZViewControlle


//
class ConfigureViewController: UIViewController{
    
    @IBOutlet weak var bettingStructureButton: UIButton!
    
    @IBOutlet weak var bettingStructureDisplay: UILabel!
    
    var betStructure : bettingStructure = .Default
    
    enum bettingStructure {
        case Default
        case NoLimit
        case FixedLimit
        case PotLimit
        case SpreadLimit
    }
    var startingChips : Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.setNavigationBarHidden(true, animated: true)
        bettingStructureDisplay.text = ""
        

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	


        
    }


    @IBAction func changeBettingStructure(sender: AnyObject) {
        let CBSAlert = SimpleAlert.Controller(title: "Betting Structure", message: "", style: .Alert)

        
        CBSAlert.addAction(SimpleAlert.Action(title: "No Limit", style: SimpleAlert.Action.Style.Default , handler: {(alertAction : SimpleAlert.Action!) -> Void in
            self.resolveOption(.NoLimit)
        }))
        
        CBSAlert.addAction(SimpleAlert.Action(title: "Fixed Limit", style: .Default , handler: {(alertAction : SimpleAlert.Action!) -> Void in
            self.resolveOption(.FixedLimit)
        }))
        
        CBSAlert.addAction(SimpleAlert.Action(title: "Pot Limit", style: .Default , handler: {(alertAction : SimpleAlert.Action!) -> Void in
            self.resolveOption(.PotLimit)
        }))
        
        CBSAlert.addAction(SimpleAlert.Action(title: "Spread Limit", style: .Default , handler: {(alertAction : SimpleAlert.Action!) -> Void in
            self.resolveOption(.SpreadLimit)
        }))
        
    
        
        
        presentViewController(CBSAlert, animated: true, completion: {})
        
        
    }
    
    func resolveOption(option: bettingStructure){
        switch option{
        case .Default:
            UIView.performWithoutAnimation({
                self.bettingStructureButton.setTitle("Betting Structure", forState: UIControlState.Normal)
                self.bettingStructureButton.layoutIfNeeded()
            })
        case .FixedLimit:
            UIView.performWithoutAnimation({
                self.bettingStructureButton.setTitle("Fixed Limit", forState: UIControlState.Normal)
                self.bettingStructureButton.layoutIfNeeded()
            })
            
        case .NoLimit:
            UIView.performWithoutAnimation({
                self.bettingStructureButton.setTitle("No Limit", forState: UIControlState.Normal)
                self.bettingStructureButton.layoutIfNeeded()
            })
        case .PotLimit:
            UIView.performWithoutAnimation({
                self.bettingStructureButton.setTitle("Pot Limit", forState: UIControlState.Normal)
                self.bettingStructureButton.layoutIfNeeded()
            })
        case .SpreadLimit:
            UIView.performWithoutAnimation({
                self.bettingStructureButton.setTitle("Spread Limit", forState: UIControlState.Normal)
                self.bettingStructureButton.layoutIfNeeded()
            })
        }
    }
    
    
    
}
