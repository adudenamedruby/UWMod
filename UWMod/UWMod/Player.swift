//
//  Player.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-25.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

class Player {
    var name:                               String
    var role:                               Role!
    var isAlive:                            Bool
    var team:                               [UWTeam]
    var daytimeInfoCards:                   [DaytimeCardType]
    var isMute:                             Bool
    var canVote:                            Bool
    var isAssigned:                         Bool
    
    // Role affected states
    var isProtected:                        Bool
    var isHynotized:                        Bool
    var canBeSavedByLeprechaun:             Bool
    var canBeSavedByWitch:                  Bool
    var canBeChosenByMentalist:             Bool
    var canBeChosenByOldHag:                Bool
    var canBeMutedBySpellcaster:            Bool
    var hasBrains:                          Bool
    var isNightActivePlayer:                Bool
    
    init (name: String) {
        self.name                           = name
        self.team                           = []
        self.daytimeInfoCards               = []

        self.isAlive                        = true
        self.isMute                         = false
        self.canVote                        = true
        self.isAssigned                     = false
        self.isNightActivePlayer            = false
        
        self.isProtected                    = false
        self.isHynotized                    = false
        self.canBeSavedByLeprechaun         = true
        self.canBeSavedByWitch              = true
        self.canBeChosenByMentalist         = true
        self.canBeChosenByOldHag            = true
        self.canBeMutedBySpellcaster        = true
        self.hasBrains                      = true
        
    }
    
    func assignRole(role: Role) {
        self.role                           = role
        self.team                           = role.team
        self.isNightActivePlayer            = role.isNightActiveRole.currentStatus
        self.isAssigned                     = true
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
    
    func determineDaytimeInfoCardForPlayer() {
        
        for teamX in self.team {
            if teamX == .TeamWerewolf {
                addAppropriateCard(daytimeCard: .WerewolfTeamCard)
            } else if teamX == .TeamVillage {
                addAppropriateCard(daytimeCard: .VillageTeamCard)
            }
        }
    }
    
    func addAppropriateCard(daytimeCard: DaytimeCardType) {
        if !daytimeInfoCards.contains(daytimeCard) {
            daytimeInfoCards.append(daytimeCard)
        }
    }
}
