//
//  Roles.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

class Role {
    let name: String
    let description: String
    let impact: Int
    let priority: Int
    let groupTogether: Bool
    
    var powerChoice: Bool
    var team: UWTeam
    
    init(name: String, description: String, impact: Int, priority: Int, groupWithLikeRoles: Bool?, powerChoice: Bool, team: UWTeam) {
        self.name = name
        self.description = description
        self.impact = impact
        self.priority = priority
        self.groupTogether = groupWithLikeRoles ?? false
        self.powerChoice = powerChoice
        self.team = team
    }
}

class Witch: Role {
    var playerToPoison: Player?
    var playerToSave: Player?
    
    init(name: String, description: String, impact: Int, priority: Int, groupWithLikeRoles: Bool?, powerChoice: Bool, team: UWTeam, playerToPoison: Player?, playerToSave: Player?) {
        super.init(name: name, description: description, impact: impact, priority: priority, groupWithLikeRoles: groupWithLikeRoles, powerChoice: powerChoice, team: team)

        self.playerToPoison = playerToPoison
        self.playerToSave = playerToSave
    }
}
