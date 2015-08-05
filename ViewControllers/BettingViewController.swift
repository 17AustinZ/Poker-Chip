//
//  Betting.swift
//  Poker Chip App
//
//  Created by Austin Zhang on 7/15/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import UIKit
import SimpleAlert

class BettingViewController: UIViewController{
    
    enum Button {
        case Raise
        case Call
        case Fold
        case Check
    }
    
     //Class variables
    ////////////////////////////////////////////////////////////////////////////
    var lastBet : Int = 0 //Check memory
    var gameMode = ""
    var rotateView : UIView? //Radial Menu container
    var radialMenu : ALRadialMenu = ALRadialMenu() //Radial menu
    
    var buttons : [ALRadialMenuButton] = []
    var players : [Player] = []
    
    var currentPlayerIndex : Int?
    var activePlayers : [Player] = []
    
    var poolLabel : UILabel? //Pot count label
    var pool : Int = 0 //
    
     //Button handles
    ////////////////////////////////////////////////////////////////////////////
    @IBOutlet weak var CheckCallButton: UIButton!
    @IBOutlet weak var BetRaiseButton: UIButton!
    @IBOutlet weak var FoldButton: UIButton!
    
     //Betting Functionality
    ////////////////////////////////////////////////////////////////////////////
    
    @IBAction func CheckCall(sender: AnyObject) {
        self.pool += lastBet
        self.players[self.currentPlayerIndex!].chips! -= lastBet
    }
    //[Button] Bets/Raises by the specified amount
    //Specified amount is specified via
    
    @IBAction func BetRaise(sender: AnyObject) {
        //[Workaround]
        //BUG[001]
        //Reasoning: SimpleAlert shows up underneath the radialMenu
        radialMenu.dismiss()
        
        //SimpleAlert that asks how much the user wants to bet
        var raisePopup = SimpleAlert.Controller(title: "Bet Amount", message: "", style: SimpleAlert.Controller.Style.Alert)
        raisePopup.addTextFieldWithConfigurationHandler() { textField in
            textField.frame.size.height = 30
            textField.backgroundColor = nil
            textField.layer.borderColor = nil
            textField.layer.borderWidth = 0
        }
        raisePopup.addAction(SimpleAlert.Action(title: "OK", style: .Default) { action in
            //Setup
            var raiseCount = raisePopup.textFields[0].text.toInt()
            
            //Manipulates pool + chip counts
            if raiseCount != nil {
                var betAmount = raiseCount
                self.lastBet = betAmount!
                if (betAmount > self.players[self.currentPlayerIndex!].chips! ){
                    //[CODE]
                    println("not enough chips")
                } else {
                    self.pool += betAmount!
                    self.players[self.currentPlayerIndex!].chips! -= betAmount!
                }
            } else {
                //CODE
                println("failed")
            }
            
            //Cleanup + Exit
            self.radialMenu.presentInView(self.view)
            //Pauses thread to stagger animations
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "nextTurn", userInfo: nil, repeats: false)
        })
        self.presentViewController(raisePopup, animated: true, completion: {})
    }
    
    //[Button] Folds
    @IBAction func Fold(sender: AnyObject) {
        
        players.removeAtIndex(currentPlayerIndex!)
        radialMenu.dismiss()
        radialMenu.setButtons(generateButtons())
        showMenu()
        label()
        nextTurn()
    }

    //Handles transition to next turn
    func nextTurn(){
        poolLabel?.text = String(pool)
        
        //Increments current player index
        currentPlayerIndex = currentPlayerIndex! + 1
        
        //Restarts from 0 after the last player
        if currentPlayerIndex! > players.count {
            currentPlayerIndex = 0
        }
        
        //Rotates radial menu
        radialMenu.rotate(view)
        label()
//        println(buttons[currentPlayerIndex!].player!.name!)
    }
    
    //Generates labels for each button
    func label(){
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.titleLabel?.textAlignment = NSTextAlignment.Center
            button.setTitle("\(button.player!.name!)\n\n\n\n\(button.player!.chips!)", forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.setBackgroundImage(button.imageView?.image, forState: UIControlState.Normal)
            button.setImage(nil, forState: UIControlState.Normal)
            button.titleLabel?.numberOfLines = 0;
            button.titleLabel?.font = UIFont.systemFontOfSize(12)
        }
    }
    
    //Displays the radial menu
    func showMenu() {
        var midScreen = CGPoint(x: UIScreen.mainScreen().bounds.width / 2, y: UIScreen.mainScreen().bounds.height * 3 / 5)
        radialMenu = ALRadialMenu().setButtons(generateButtons()).setAnimationOrigin(midScreen)
        radialMenu.setRadius(150)
        radialMenu.setDismissOnOverlayTap(false)
        //[BUG] Likely Cause of Bug BUG[001]
        radialMenu.presentInView(rotateView!)
        println(buttons.count)
    }
    
    //Generates buttons - Modifies buttons[Button]
    func generateButtons() -> [ALRadialMenuButton] {
        buttons = []
        println(players.count)
        for i in 0..<players.count {
            let button = ALRadialMenuButton(frame: CGRectMake(0, 0, 44, 44))
            button.setImage(UIImage(named: "icon\(players[i].color!)"), forState: UIControlState.Normal)
            button.setPlayer(players[i])
            buttons.append(button)
        }
        return buttons
    }

     //Backend
    ////////////////////////////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        currentPlayerIndex = 0
        
        rotateView = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.width / 2 - 150, (UIScreen.mainScreen().bounds.height * 3 / 5) - 150, 300, 300))
        
        rotateView?.backgroundColor = UIColor.whiteColor()        
        view.addSubview(rotateView!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        showMenu()
        label()
        poolLabel = UILabel(frame: CGRectMake((UIScreen.mainScreen().bounds.width / 2) - 20, (UIScreen.mainScreen().bounds.height * 3 / 5) - 20 , 40, 40))
        view.addSubview(poolLabel!)
        poolLabel?.textAlignment = NSTextAlignment.Center
        poolLabel?.text = String(pool)
        view.bringSubviewToFront(poolLabel!)

    }
    
    override func viewWillDisappear(animated: Bool) {
        println("asdf2")
        radialMenu.dismiss()
        radialMenu.removeFromSuperview()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("asdf")
        radialMenu.dismiss()
        radialMenu.removeFromSuperview()
        
    }
    
     //Testing Functions
    ////////////////////////////////////////////////////////////////////////////
    @IBAction func testButton(sender: AnyObject) {
        for i in players {println("\(i.active)\t\(i.name!)\t\(i.chips!)")}
    }
    
    @IBAction func testButton2(sender: AnyObject) {
        radialMenu.rotate(view)
    }
    

}