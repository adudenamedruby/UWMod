//
//  Roles.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

class Role {
    var name: String
    var description: String
    var impact: Int
    var priority: Int
    var powerChoice: Bool
    
    init(name: String, description: String, impact: Int, priority: Int, powerChoice: Bool) {
        self.name = name
        self.description = description
        self.impact = impact
        self.priority = priority
        self.powerChoice = powerChoice
    }
}

class Witch: Role {
    var playerToPoison = Player()
    var playerToSave = Player()
}
