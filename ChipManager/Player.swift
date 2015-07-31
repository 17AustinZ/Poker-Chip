//
//  Player.swift
//  ChipManager
//
//  Created by Austin Zhang on 7/22/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation

class Player {
    var name : String?
    var active : Bool = true
    var chips : Int?
    var color : Int?
    
    init(name : String, startChips : Int, color: Int){
        self.name = name
        chips = startChips
        self.color = color
    }
}
