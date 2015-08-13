//
//  ShowdownContainerViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 8/10/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import ActionButton

class ShowdownContainerViewController : UIViewController{

    var bettingVC : BettingViewController?
    var showdownVC : ShowdownViewController?
    var actionButton: ActionButton!
    @IBAction func showdownDone(sender: AnyObject) {
        var pool = bettingVC?.pool
        println(pool)
        showdownVC?.getWinners()
        if let winners = showdownVC?.winners!{
            for player in winners{
                player.chips! += (pool! / winners.count)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "showdownEmbed" {
            println("showdowncalled")
            println(self.bettingVC)
            showdownVC = segue.destinationViewController as? ShowdownViewController
            showdownVC!.bettingVC = self.bettingVC
        }


    }
}
