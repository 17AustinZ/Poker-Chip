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
  
    
    @IBOutlet weak var structureOptions: BOChoiceTableViewCell!
    var selectedStructure : Int = -1
    override func setup() {
        structureOptions.options = ["Option 1", "Option 2", "Option 3"]
        structureOptions.textLabel?.textAlignment = NSTextAlignment.Center
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBarHidden = true
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