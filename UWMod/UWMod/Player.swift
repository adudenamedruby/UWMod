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
    var team: [UWTeam]
    var mute: Bool
    var canVote: Bool
    var playerAssigned: Bool
    
    // Role affected states
    var isProtected: Bool
    var isHynotized: Bool
    var canBeSavedByLeprechaun: Bool
    var canBeSavedByWitch: Bool
    var canBeChosenByMentalist: Bool
    var canBeChosenByOldHag: Bool
    var canBeMutedBySpellcaster: Bool
    var hasBrains: Bool
    var isNightActivePlayer: Bool
    
    init (name: String, role: Role) {
        self.name = name
        self.role = role
        self.team = [role.team]

        self.alive = true
        self.mute = false
        self.canVote = true
        self.playerAssigned = false
        self.isNightActivePlayer = role.isNightActiveRole.currentStatus
        
        self.isProtected = false
        self.isHynotized = false
        self.canBeSavedByLeprechaun = true
        self.canBeSavedByWitch = true
        self.canBeChosenByMentalist = true
        self.canBeChosenByOldHag = true
        self.canBeMutedBySpellcaster = true
        self.hasBrains = true
        
    }
    
    func assignPlayer(playerName: String) {
        self.name = playerName
    }
    
    func addToTeam(team: UWTeam) {
        self.team.append(team)
    }
    
    func switchTeam(from: UWTeam, to:UWTeam) {
        if self.team.contains(from) {
            if let teamIndex = self.team.index(of: from) {
                self.team.remove(at: teamIndex)
            }
            addToTeam(team: to)
        }
    }
    
    func reconcileDeath() {
        role.reconcileDeath()
    }
}
