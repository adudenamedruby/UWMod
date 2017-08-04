//
//  Roles.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

enum RoleType {
    case Seer
    case Villager
    case Werewolf
}

class Role {
    let name: String
    let type: RoleType
    let description: String
    let roleExplanation: String
    let notes: String?
    let impact: Int
    let priority: Int
    let image: UIImage
    
    var wakeTime: [UWNights]
    var canWake: Bool
    var powerChoice: Bool
    var powerUsed: Bool
    var team: UWTeam
    
    init(name: String, type: RoleType, description: String, roleExplanation: String, impact: Int, priority: Int, powerChoice: Bool, team: UWTeam, wakeTime: [UWNights], image: UIImage, notes: String = "") {
        self.name = name
        self.type = type
        self.description = description
        self.roleExplanation = roleExplanation
        self.notes = notes
        self.impact = impact
        self.priority = priority
        self.image = image
        
        self.team = team
        self.wakeTime = wakeTime
        self.powerChoice = powerChoice
        self.powerUsed = false
        self.canWake = true
    }
    
    func reconcileDeath() {
        
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
