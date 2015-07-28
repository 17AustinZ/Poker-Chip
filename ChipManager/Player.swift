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
    
    init(name : String, startChips : Int){
        self.name = name
        chips = startChips
    }
}
