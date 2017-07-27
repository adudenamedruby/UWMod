//
//  Player.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-25.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

class Player {
    var name: String
    var role: Role
    var alive: Bool
    var team: UWTeam
    
    init (name: String, role: Role) {
        self.name = name
        self.role = role
        self.alive = true
        self.team = role.team
    }
}
