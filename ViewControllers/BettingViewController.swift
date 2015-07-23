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
    
    @IBOutlet weak var raiseButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var foldButton: UIButton!
    
    
    @IBAction func raise(sender: AnyObject) {
    }
    @IBAction func call(sender: AnyObject) {
    }
    @IBAction func fold(sender: AnyObject) {
    }
    var radialMenu : ALRadialMenu = ALRadialMenu()
    var numPlayers : Int? = 8
    var buttons : [ALRadialMenuButton] = []
    var playerNames : [String] = []
    var players : [Player] = []
    var currentPlayer : Player?
    func generateButtons() -> [ALRadialMenuButton] {
        
        var buttons = [ALRadialMenuButton]()
        for i in 0..<players.count {
            let button = ALRadialMenuButton(frame: CGRectMake(0, 0, 44, 44))
            button.setImage(UIImage(named: "icon\(i+1)"), forState: UIControlState.Normal)
            
            button.player = players[i]
            buttons.append(button)
        }
        
        self.buttons = buttons
        return buttons
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPlayer = players[0]
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        generateButtons()
        showMenu()
    }
    
    
    @IBAction func testButton(sender: AnyObject) {
        buttons[2].setImage(UIImage(named: "icon1"), forState: UIControlState.Normal)
        radialMenu.setButtons(buttons)
        radialMenu.refreshButtons(view)
        
        

        
    }
    
    func showMenu() {
        var midScreen = CGPoint(x: UIScreen.mainScreen().bounds.width / 2, y: UIScreen.mainScreen().bounds.height / 2)
        var buttons = [ALRadialMenuButton]()
//            ALRadialMenu()
//                .setButtons(buttons)
//                .setAnimationOrigin(sender.locationInView(view))
//                .presentInView(view)
        
        radialMenu = ALRadialMenu().setButtons(generateButtons()).setAnimationOrigin(midScreen)
        radialMenu.setRadius(150)
        radialMenu.setDismissOnOverlayTap(false)
        radialMenu.presentInView(view)

        
    }
}