//
//  ALRadialMenuButton.swift
//  ALRadialMenu
//
//  Created by Alex Littlejohn on 2015/04/26.
//  Copyright (c) 2015 zero. All rights reserved.
//

import UIKit

public typealias ALRadialMenuButtonAction = () -> Void

public class ALRadialMenuButton: UIButton {
    var player : Player?

    public var action: ALRadialMenuButtonAction? {
        didSet {
            configureAction()
        }
    }

    
    private func configureAction() {
        addTarget(self, action: "performAction", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    internal func performAction() {
        if let a = action {
            a()
        }
    }
    
    func setPlayer(player: Player){
        self.player = player
        self.setTitle("Player Name \n ASDF", forState: UIControlState.Normal)
        self.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.titleLabel?.numberOfLines = 2;
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
    }
}
