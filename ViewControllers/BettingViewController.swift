//
//  Betting.swift
//  Poker Chip App
//
//  Created by Austin Zhang on 7/15/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import UIKit

class BettingViewController: UIViewController{
    var gameMode = ""
    var numPlayers : Int? = 8
    var buttons : [ALRadialMenuButton]?
    
    func generateButtons() -> [ALRadialMenuButton] {
        
        var buttons = [ALRadialMenuButton]()
        
        for i in 0..<numPlayers! {
            let button = ALRadialMenuButton(frame: CGRectMake(0, 0, 44, 44))
            button.setImage(UIImage(named: "icon\(i+1)"), forState: UIControlState.Normal)
            buttons.append(button)
        }
        
        self.buttons = buttons
        return buttons
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMenu()
    }
    
    @IBAction func testButton(sender: AnyObject) {
        showMenu()
    }
    
    func showMenu() {
        var midScreen = CGPoint(x: UIScreen.mainScreen().bounds.width / 2, y: UIScreen.mainScreen().bounds.height / 2)
        var buttons = [ALRadialMenuButton]()
//            ALRadialMenu()
//                .setButtons(buttons)
//                .setAnimationOrigin(sender.locationInView(view))
//                .presentInView(view)
        
        ALRadialMenu().setButtons(generateButtons()).setAnimationOrigin(midScreen).presentInView(view)
        
    }
}