//
//  ShowdownContainerViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 8/10/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
class ShowdownContainerViewController : UIViewController{

    var bettingVC : BettingViewController?

    @IBAction func showdownDone(sender: AnyObject) {
        var pool = bettingVC?.pool
    }

    override func viewDidLoad() {
        navigationController?.navigationBarHidden = true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "showdownEmbed" {
            var showdownVC = segue.destinationViewController as! ShowdownViewController
            showdownVC.bettingVC = self.bettingVC
        }


    }
}
