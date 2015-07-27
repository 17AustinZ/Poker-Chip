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
    
    enum Button {
        case Raise
        case Call
        case Fold
        case Check
    }
    
    var gameMode = ""
    
    var rotateView : UIView?
    @IBOutlet weak var raiseButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var foldButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBAction func raise(sender: AnyObject) {
    }
    @IBAction func call(sender: AnyObject) {
    }
    @IBAction func fold(sender: AnyObject) {
    }
    @IBOutlet var mainView: UIView!
    
    var radialMenu : ALRadialMenu = ALRadialMenu()
    var numPlayers : Int? = 6
    var buttons : [ALRadialMenuButton] = []
    var playerNames : [String] = []
    var players : [Player] = []
    var currentPlayer : Player?
    var activePlayers : [Player] = []
    func generateButtons() -> [ALRadialMenuButton] {
        
        var buttons = [ALRadialMenuButton]()
        for i in 0..<players.count {
            let button = ALRadialMenuButton(frame: CGRectMake(0, 0, 44, 44))
            button.setImage(UIImage(named: "icon\(i+1)"), forState: UIControlState.Normal)
            button.setPlayer(players[i])
            buttons.append(button)
        }
        
        self.buttons = buttons
        return buttons
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPlayer = players[0]
        
        rotateView = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.width / 2 - 150, (UIScreen.mainScreen().bounds.height * 3 / 5) - 150, 300, 300))
        rotateView?.backgroundColor = UIColor.whiteColor()        
        view.addSubview(rotateView!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        generateButtons()
        showMenu()
    }
    
    var buttonIndex = 0
    var colorIndex = 0
    var initImage : UIImage?
    
    @IBAction func testButton(sender: AnyObject) {
        //radialMenu.tester(rotateView!)
        
        sender.setTitle("asdf", forState: UIControlState.Normal)
        label()
    }
    
    @IBAction func testButton2(sender: AnyObject) {
        radialMenu.rotate(view)
    }
    
    func label(){
     
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.titleLabel?.textAlignment = NSTextAlignment.Center
            button.setTitle("\(button.player!.name!)\n\n\nA", forState: UIControlState.Normal)
//            button.sizeToFit()
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.setBackgroundImage(button.imageView?.image, forState: UIControlState.Normal)
            button.setImage(nil, forState: UIControlState.Normal)
            button.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            button.titleLabel?.numberOfLines = 0;
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//            button.titleEdgeInsets = UIEdgeInsetsMake( 0, 0, buttons[0].imageView!.image!.size.height, 0)
            button.titleEdgeInsets = UIEdgeInsetsMake( 0, 0, 0, 0)

        }
        
    }
    
    func showMenu() {
        var midScreen = CGPoint(x: UIScreen.mainScreen().bounds.width / 2, y: UIScreen.mainScreen().bounds.height * 3 / 5)
        var buttons = [ALRadialMenuButton]()
//            ALRadialMenu()
//                .setButtons(buttons)
//                .setAnimationOrigin(sender.locationInView(view))
//                .presentInView(view)
        
        radialMenu = ALRadialMenu().setButtons(generateButtons()).setAnimationOrigin(midScreen)
        radialMenu.setRadius(150)
        radialMenu.setDismissOnOverlayTap(false)
        radialMenu.presentInView(rotateView!)

        
    }
    
    func bet(action : Button){
        switch action{
        case .Raise:
            println("raise")
        case .Call:
            println("call")
        case .Fold:
            println("fold")
        case .Check:
            println("check")
            
        }

        
    }
}