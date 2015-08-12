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

        let twitterImage = UIImage(named: "twitter_icon.png")!
        let plusImage = UIImage(named: "googleplus_icon.png")!

        let twitter = ActionButtonItem(title: "Twitter", image: twitterImage)
        twitter.action = { item in println("Twitter...") }

        let google = ActionButtonItem(title: "Google Plus", image: plusImage)
        google.action = { item in println("Google Plus...") }

        actionButton = ActionButton(attachedToView: self.view, items: [twitter, google])
        actionButton.action = { button in button.toggleMenu() }

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "showdownEmbed" {
            showdownVC = segue.destinationViewController as? ShowdownViewController
            showdownVC!.bettingVC = self.bettingVC
        }


    }
}
