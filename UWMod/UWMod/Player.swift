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
    var role: Role?
    var alive: Bool
    var team: [UWTeam]
    var mute: Bool
    var canVote: Bool
    var nightActivePlayer: Bool
    
    // Role affected states
    var protected: Bool
    var hynotized: Bool
    var canBeSavedByLeprechaun: Bool
    var canBeSavedByWitch: Bool
    var canBeChosenByMentalist: Bool
    var canBeChosenByOldHag: Bool
    var canBeMutedBySpellcaster: Bool
    var hasBrains: Bool
    
    init (name: String) {
        self.name = name
        self.alive = true
        self.team = [.UnknownTeam]
        self.mute = false
        self.canVote = true
        self.nightActivePlayer = true
        
        self.protected = false
        self.hynotized = false
        self.canBeSavedByLeprechaun = true
        self.canBeSavedByWitch = true
        self.canBeChosenByMentalist = true
        self.canBeChosenByOldHag = true
        self.canBeMutedBySpellcaster = true
        self.hasBrains = true
    }
    
    func assignRole(role: Role) {
        self.role = role
        self.team.removeFirst()
        addToTeam(team: role.team)
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
}
