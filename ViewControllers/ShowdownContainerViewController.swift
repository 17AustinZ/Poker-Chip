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
        showdownVC?.getWinners()

        var winnerCount : Int = 0;
        if let winners = bettingVC?.players{
            for player in winners{
                if player.winner {
                    winnerCount++
                }
            }
            for player in winners{
                player.chips! += (pool! / winnerCount)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "showdownEmbed" {
            showdownVC = segue.destinationViewController as? ShowdownViewController
            showdownVC!.bettingVC = self.bettingVC
        }


    }
}
