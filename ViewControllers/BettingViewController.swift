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
    
    var rotateView : UIView?
    @IBOutlet weak var raiseButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var foldButton: UIButton!
    
    
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
        
        rotateView = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.width / 2 - 150, (UIScreen.mainScreen().bounds.height * 3 / 5) - 150, 300, 300))
        rotateView?.backgroundColor = UIColor.blueColor()
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
    
    
    @IBAction func testButton(sender: AnyObject) {
//        buttons[2].setImage(UIImage(named: "icon1"), forState: UIControlState.Normal)
//        radialMenu.setButtons(buttons)
//        radialMenu.refreshButtons(view)
        
//        - (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
//        {
//            CABasicAnimation* rotationAnimation;
//            rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
//            rotationAnimation.duration = duration;
//            rotationAnimation.cumulative = YES;
//            rotationAnimation.repeatCount = repeat;
//            
//            [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//        }
        

        
        
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
}