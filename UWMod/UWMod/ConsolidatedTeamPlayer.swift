//
//  File.swift
//  UWMod
//
//  Created by roux buciu on 2017-08-08.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

class Team: Player {
    
    override init(name: String) {
        super.init(name: name)
        
        self.role               = WEREWOLF_TEAM
        self.isAssigned         = true
    }
    
    
}

let WEREWOLF_TEAM = Role(name: "Werewolves", type: .Werewolf, description: "All werewolves wake up and choose a player to eliminate.", roleExplanation: "The Werewolf team members learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: 0, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)
