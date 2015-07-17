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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        super.prepareForSegue(segue, sender: sender)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


    @IBAction func changeBettingStructure(sender: AnyObject) {
        let CBSAlert = SimpleAlert.Controller(title: "Betting Structure", message: "", style: .Alert)
        CBSAlert.addAction(SimpleAlert.Action(title: "OK", style: .Default) { action in
            println("No Limit")
            })
        CBSAlert.addAction(SimpleAlert.Action(title: "Set Limit", style: .Default) { action : <#((SimpleAlert.Action!) -> Void)?##(SimpleAlert.Action!) -> Void#>))
        
//        
//        CBSAlert.addAction(SimpleAlert.Controller(title: "No Limit",
//            style: .Default ,
//            handler: {(alert: UIAlertAction!) in println("Foo")}))
//        
        
        
        
        presentViewController(CBSAlert, animated: true, completion: nil)
    }
    
}
