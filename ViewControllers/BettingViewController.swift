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
import LGPlusButtonsView
import ActionButton
import Mixpanel




class BettingViewController: UIViewController{
    var mixpanel = Mixpanel.sharedInstance()



     //MARK: Class variables
    ////////////////////////////////////////////////////////////////////////////
    var lastBet : Int = 0 //Check memory
    var gameMode = ""
    var rotateView : UIView? //Radial Menu container
    var radialMenu : ALRadialMenu = ALRadialMenu() //Radial menu
    
    var buttons : [ALRadialMenuButton] = []
    
    var players : [Player] = [] {
        didSet{
            Universal.sharedInstance.playersList = players
        }
    }

    var actionButton : ActionButton?
    var poolLabel : UILabel? //Pot count label
    var pool : Int = 0 //
    var checkCount : Int = 0




     //MARK: Betting Functionality
    ////////////////////////////////////////////////////////////////////////////



    func CheckCall(sender: AnyObject) {

        if lastBet != 0{
            self.pool += lastBet
            self.players[0].chips! -= lastBet
            nextTurn(true)
        }

    }
    
    //[Button] Bets/Raises by the specified amount
    //Specified amount is specified via
    func BetRaise(sender: AnyObject) {
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
            textField.placeholder = "Number of Chips"
            textField.delegate = self
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        raisePopup.addAction(SimpleAlert.Action(title: "OK", style: .Default) { action in
            //Setup
            var raiseCount = raisePopup.textFields[0].text.toInt()
            
            //Manipulates pool + chip counts
            if raiseCount != nil {
                var betAmount = raiseCount
                self.lastBet = betAmount!
                if (betAmount > self.buttons[0].player!.chips!){
                    self.pool += self.buttons[0].player!.chips!
                    self.buttons[0].player!.chips! = 0
                } else {
                    self.pool += betAmount!
                    self.buttons[0].player!.chips! -= betAmount!
                    self.lastBet = betAmount!
                }
            } else {
                return
            }
            
            //Cleanup + Exit
            self.radialMenu.presentInView(self.view)
            //Pauses thread to stagger animations
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "nextTurnTrue", userInfo: nil, repeats: false)
        })
        self.presentViewController(raisePopup, animated: true, completion: {})
    }
    
    ///[Button] Folds
     func Fold(sender: AnyObject) {
//        players.removeAtIndex(0)
        players[0].active = false

        radialMenu.dismiss()
        radialMenu.setButtons(generateButtons())
        showMenu()
        label()
        nextTurn(false)
    }
    
    
    ///Handles transition to next turn
    func nextTurn(rotate : Bool){
//        testButton(self)
        poolLabel?.text = String(pool)
        buttons = buttons.rotate(1)
        players = players.rotate(1)
        rotateToNext()
        //Rotates radial menu
        if rotate {radialMenu.rotate(view)}
        label()


    }
    
    ///Generates labels for each button
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



    //[ADD] Optimization to remove redundant recalculation
    ///Displays the radial menu
    func showMenu() {
        var midScreen = CGPoint(x: UIScreen.mainScreen().bounds.width / 2, y: UIScreen.mainScreen().bounds.height * 2 / 5)
        radialMenu = ALRadialMenu().setButtons(generateButtons()).setAnimationOrigin(midScreen)
        //[ADD] Dynamic resizing?
        radialMenu.setRadius(Double(UIScreen.mainScreen().bounds.width) / 2 - 50)
        radialMenu.setDismissOnOverlayTap(false)
        //[BUG] Likely Cause of Bug BUG[001]
        radialMenu.presentInView(rotateView!)

    }
    
    ///Generates buttons - Modifies buttons[Button]
    func generateButtons() -> [ALRadialMenuButton] {
        buttons = []
        for i in 0..<players.count {
            if players[i].active {
                let button = ALRadialMenuButton(frame: CGRectMake(0, 0, 44, 44))
                //color
                //[ADD] Change to background image?
                button.setImage(UIImage(named: "icon\(players[i].color!)"), forState: UIControlState.Normal)
                button.setPlayer(players[i])
                buttons.append(button)
            }
        }
        return buttons
    }

    ///Starts showdown - Prompts to select winner(s)
    func showdown(){
        radialMenu.dismiss()
        var showdownPopup = SimpleAlert.Controller(title: "Decide Winner(s)", message: "", style: SimpleAlert.Controller.Style.Alert)

        for var i : Int = 0; i < buttons.count - 1; i++ {
            showdownPopup.addAction(SimpleAlert.Action(title: "\(buttons[i].player!.name!)", style: .Default) { action in

                showdownPopup.actions[i].button.titleLabel?.text = "ASDF"
                //Cleanup + Exit
                self.radialMenu.presentInView(self.view)
                //Pauses thread to stagger animations
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "nextTurnTrue", userInfo: nil, repeats: false)
                })

        }

        self.presentViewController(showdownPopup, animated: true, completion: {})
    }

     //MARK: Backend
    ////////////////////////////////////////////////////////////////////////////

    //EXP
    func nextTurnTrue(){
        nextTurn(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        currentPlayerIndex = 0
        players = Universal.sharedInstance.playersList
        rotateView = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.width / 2 - 150, (UIScreen.mainScreen().bounds.height * 2 / 5) - 150, 300, 300))
        
        //[ADD] Alpha
        rotateView?.backgroundColor = UIColor.whiteColor()        
        view.addSubview(rotateView!)

        mixpanel.track("Opened View Controller", properties: ["View Controller" : "Betting"])



    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        showMenu()
        label()
        poolLabel = UILabel(frame: CGRectMake((UIScreen.mainScreen().bounds.width / 2) - 20, (UIScreen.mainScreen().bounds.height * 2 / 5) - 20 , 40, 40))
        view.addSubview(poolLabel!)
        poolLabel?.textAlignment = NSTextAlignment.Center
        poolLabel?.text = String(pool)
        view.bringSubviewToFront(poolLabel!)

        let icon1 = UIImage(named: "icon1.png")!
        let icon2 = UIImage(named: "icon2.png")!
        let icon3 = UIImage(named: "icon3.png")!
        let icon4 = UIImage(named: "icon4.png")!

        let bet = ActionButtonItem(title: "Bet", image: icon1)
        bet.action = {item in self.BetRaise(self)}

        let fold = ActionButtonItem(title: "Fold", image: icon2)
        fold.action = {item in
            if self.buttons.count > 1 {
                self.Fold(self)
            }
        }

        let check = ActionButtonItem(title: "Check", image: icon3)
        check.action = {item in self.CheckCall(self)}

        let showdown = ActionButtonItem(title: "Showdown", image: icon4)
        showdown.action = {item in

            self.performSegueWithIdentifier("toWinners", sender: self)

        }

        actionButton = ActionButton(attachedToView: view, items: [bet, fold, check, showdown])
        actionButton!.action = { button in button.toggleMenu() }
        view.bringSubviewToFront(actionButton!.contentView!)
        

    }
    
    override func viewWillDisappear(animated: Bool) {
        radialMenu.dismiss()
        radialMenu.removeFromSuperview()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        radialMenu.dismiss()
        radialMenu.removeFromSuperview()
        if segue.identifier == "toWinners" {
            var showdownVC = segue.destinationViewController as! ShowdownContainerViewController
            showdownVC.bettingVC = self
        }

        
    }
    
     //MARK: Testing Functions
    ////////////////////////////////////////////////////////////////////////////

    func rotateToNext(){
        while !players[0].active{
            players.rotate(1)
            buttons.rotate(1)
        }
    }

}
extension Array {
    func rotate(shift:Int) -> Array {
        var array = Array()
        if (self.count > 0) {
            array = self
            if (shift > 0) {
                for i in 1...shift {
                    array.append(array.removeAtIndex(0))
                }
            }
            else if (shift < 0) {
                for i in 1...abs(shift) {
                    array.insert(array.removeAtIndex(array.count-1),atIndex:0)
                }
            }
        }
        return array
    }
}
extension BettingViewController : LGPlusButtonsViewDelegate {
    func plusButtonsView(plusButtonsView: LGPlusButtonsView, buttonPressedWithTitle title: String, description: String, index: UInt) {

    }

    func plusButtonsViewPlusButtonPressed(plusButtonsView: LGPlusButtonsView) {

    }

}

extension BettingViewController : UITextFieldDelegate{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            for chr in string {
                if (!(chr >= "0" && chr <= "9")) {
                    return false
                }
            }
        return true
    }
    
}