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
    let notes: String
    let impact: Int
    let priority: Int
    
    var wakeTime: UWNights
    var powerChoice: Bool
    var powerUsed: Bool
    var team: UWTeam
    
    init(name: String, description: String, notes: String, impact: Int, priority: Int, powerChoice: Bool, team: UWTeam, wakeTime: UWNights) {
        self.name = name
        self.description = description
        self.notes = notes
        self.impact = impact
        self.priority = priority
        
        self.team = team
        self.wakeTime = wakeTime
        self.powerChoice = powerChoice
        self.powerUsed = false
    }
}

//class Witch: Role {
//    var playerToPoison: Player?
//    var playerToSave: Player?
//    
//    init(name: String, description: String, impact: Int, priority: Int, powerChoice: Bool, team: UWTeam, numberOfEliminations: Int, playerToPoison: Player?, playerToSave: Player?) {
//        super.init(name: name, description: description, impact: impact, priority: priority, powerChoice: powerChoice, team: team, numberOfEliminations: numberOfEliminations)
//
//        self.playerToPoison = playerToPoison
//        self.playerToSave = playerToSave
//    }
//}
