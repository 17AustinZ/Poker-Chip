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
    
    enum bettingLimit{
        case Fixed
        case Spread
        case Pot
        case None
    }


     //MARK: Class variables
    ////////////////////////////////////////////////////////////////////////////
    var lastBet : Int = 0 //Check memory
    var gameMode = ""
    var rotateView : UIView? //Radial Menu container
    var radialMenu : ALRadialMenu = ALRadialMenu() //Radial menu
    
    var buttons : [ALRadialMenuButton] = []
    
    var players : [Player] = [] {
        didSet{
            for player in players {
                print(String(player.chips!) + " ")
            }
        }
    }

    var poolLabel : UILabel? //Pot count label
    var pool : Int = 0 //

    var limit : bettingLimit!

    var checkCount : Int = 0

     //MARK: Button handles
    ////////////////////////////////////////////////////////////////////////////
    @IBOutlet weak var CheckCallButton: UIButton!
    @IBOutlet weak var BetRaiseButton: UIButton!
    @IBOutlet weak var FoldButton: UIButton!
    
     //MARK: Betting Functionality
    ////////////////////////////////////////////////////////////////////////////



    @IBAction func CheckCall(sender: AnyObject) {
        self.pool += lastBet
        //        self.players[self.currentPlayerIndex!].chips! -= lastBet
        self.players[0].chips! -= lastBet
        checkCount++
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
            textField.placeholder = "Number of Chips"
        }
        raisePopup.addAction(SimpleAlert.Action(title: "OK", style: .Default) { action in
            //Setup
            var raiseCount = raisePopup.textFields[0].text.toInt()
            
            //Manipulates pool + chip counts
            if raiseCount != nil {
                var betAmount = raiseCount
                self.lastBet = betAmount!
//                if (betAmount > self.players[self.currentPlayerIndex!].chips! ){
                if (betAmount > self.buttons[0].player!.chips!){
                    //[CODE]
                    println("not enough chips")
                } else {
                    self.pool += betAmount!
//                    self.players[self.currentPlayerIndex!].chips! -= betAmount!
                    self.buttons[0].player!.chips! -= betAmount!
                }
            } else {
                //CODE
                println("failed")
            }
            
            //Cleanup + Exit
            self.radialMenu.presentInView(self.view)
            //Pauses thread to stagger animations
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "nextTurnTrue", userInfo: nil, repeats: false)
        })
        self.presentViewController(raisePopup, animated: true, completion: {})
    }
    
    ///[Button] Folds
    @IBAction func Fold(sender: AnyObject) {
        println(players[0].name!)
        players.removeAtIndex(0)
        radialMenu.dismiss()
        radialMenu.setButtons(generateButtons())
        showMenu()
        label()
        println(players[0].name!)
        nextTurn(false)
        buttons = buttons.rotate(-1)
        players = players.rotate(-1)
    }
    
    
    ///Handles transition to next turn
    func nextTurn(rotate : Bool){
//        testButton(self)
        poolLabel?.text = String(pool)
        buttons = buttons.rotate(1)
        players = players.rotate(1)
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
            println(button.player!.chips!)
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
        var midScreen = CGPoint(x: UIScreen.mainScreen().bounds.width / 2, y: UIScreen.mainScreen().bounds.height * 3 / 5)
        radialMenu.setButtons(buttons)
        radialMenu = ALRadialMenu().setButtons(generateButtons()).setAnimationOrigin(midScreen)
        //[ADD] Dynamic resizing?
        radialMenu.setRadius(150)
        radialMenu.setDismissOnOverlayTap(false)
        //[BUG] Likely Cause of Bug BUG[001]
        radialMenu.presentInView(rotateView!)
//        println(buttons.count)
    }
    
    ///Generates buttons - Modifies buttons[Button]
    func generateButtons() -> [ALRadialMenuButton] {
        buttons = []
//        println(players.count)
        for i in 0..<players.count {
            let button = ALRadialMenuButton(frame: CGRectMake(0, 0, 44, 44))
            //color
            //[ADD] Change to background image?
            button.setImage(UIImage(named: "icon\(players[i].color!)"), forState: UIControlState.Normal)
            button.setPlayer(players[i])
            buttons.append(button)
        }
        return buttons
    }

    ///Starts showdown - Prompts to select winner(s)
    func showdown(){
        radialMenu.dismiss()
        var showdownPopup = SimpleAlert.Controller(title: "Decide Winner(s)", message: "", style: SimpleAlert.Controller.Style.Alert)

        for var i : Int = 0; i < buttons.count - 1; i++ {
            showdownPopup.addAction(SimpleAlert.Action(title: "\(buttons[i].player!.name!)", style: .Default) { action in

                println(i)
                println(showdownPopup.actions)
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

    func nextTurnTrue(){
        nextTurn(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        currentPlayerIndex = 0

        rotateView = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.width / 2 - 150, (UIScreen.mainScreen().bounds.height * 3 / 5) - 150, 300, 300))
        
        //[ADD] Alpha
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
//        println("asdf2")
        radialMenu.dismiss()
        radialMenu.removeFromSuperview()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        println("asdf")
        radialMenu.dismiss()
        radialMenu.removeFromSuperview()
        if segue.identifier == "toShowdown" {
            var showdownVC = segue.destinationViewController as! ShowdownViewController
            showdownVC.bettingVC = self
        }

        
    }
    
     //MARK: Testing Functions
    ////////////////////////////////////////////////////////////////////////////


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