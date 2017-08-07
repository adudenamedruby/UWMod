//
//  Player.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-25.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

class Player {
    var name:                               String
    var role:                               Role!
    var isAlive:                            Bool
    var team:                               [UWTeam]
    var daytimeInfoCards:                   [DaytimeCardType]
    var isMute:                             Bool
    var canVote:                            Bool
    var isAssigned:                         Bool
    var hasActedTonight:                    Bool
    var isNightActivePlayer:                Bool
    var killedBy:                           String
    
    // Role affected states
    // Protection checks
//    var isProtected: Bool {
//        get {
//            if isProtectedByBodyguard {return true}
//            return false
//        }
//    }
//    var isProtectedByBodyguard:             Bool
    
    var affectingPlayers:                   [PlayerEffects:[Player]]
    var affectedByPlayers:                  [PlayerEffects:[Player]]
    var currentConditions:                  [PlayerEffects]
    
    var canBeSavedByLeprechaun:             Bool
    var canBeSavedByWitch:                  Bool
    var canBeChosenByMentalist:             Bool
    var canBeChosenByOldHag:                Bool
    var canBeMutedBySpellcaster:            Bool
    
    init (name: String) {
        self.name                           = name
        self.team                           = []
        self.daytimeInfoCards               = []

        self.isAlive                        = true
        self.isMute                         = false
        self.canVote                        = true
        self.isAssigned                     = false
        self.isNightActivePlayer            = false
        self.hasActedTonight                = false
        self.killedBy                       = ""
        
        //self.isProtectedByBodyguard         = false
        
        self.affectingPlayers               = [:]
        self.affectedByPlayers              = [:]
        self.currentConditions              = []
        
        self.canBeSavedByLeprechaun         = true
        self.canBeSavedByWitch              = true
        self.canBeChosenByMentalist         = true
        self.canBeChosenByOldHag            = true
        self.canBeMutedBySpellcaster        = true
        
    }
    
    // MARK: - General player specific functions
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
    
    
    // MARK: - Effect-related functions
    
    func isAffectedBy(condition: PlayerEffects) -> Bool {
        if self.currentConditions.contains(condition) {
            return true
        }
        
        return false
    }
    
    func returnPlayersCausing(condition: PlayerEffects) -> [Player] {
        
        var tempPlayers: [Player] = []
        
        if isAffectedBy(condition: condition) {
            tempPlayers = affectedByPlayers[condition]!
        }
        
        return tempPlayers
    }
    
    func removeEffect(condition: PlayerEffects, causedBy: Player) {
        
        if isAffectedBy(condition: condition) {
            let indexOfAffectingPlayer = affectedByPlayers[condition]?.index(where: { $0 === causedBy})
            affectedByPlayers[condition]?.remove(at: indexOfAffectingPlayer!)
            
            if affectedByPlayers[condition]?.count == 0 {
                let indexOfCondition = currentConditions.index(of: condition)
                currentConditions.remove(at: indexOfCondition!)
            }
        }
    }
    
    func addEffect(condition: PlayerEffects, causedBy: Player) {
        
        if isAffectedBy(condition: condition) {
            let indexOfAffectingPlayer = affectedByPlayers[condition]?.index(where: { $0 === causedBy})
            affectedByPlayers[condition]?.remove(at: indexOfAffectingPlayer!)
            
            if affectedByPlayers[condition]?.count == 0 {
                let indexOfCondition = currentConditions.index(of: condition)
                currentConditions.remove(at: indexOfCondition!)
            }
        } else {
            
        }
        
    }
    
    
    
    // MARK: - Role variable functions
    // This abstraction layer prevents views from reaching into player and accessing
    // the Role object directly.
    
    func roleName() -> String {
        return role.name
    }
    
    func roleType() -> RoleType {
        return role.type
    }
    
    func roleDescription() -> String {
        return role.description
    }
    
    func roleExplanation() -> String {
        return role.roleExplanation
    }
    
    func roleNotes() -> String {
        return role.notes
    }
    
    func roleImpact() -> Int {
        return role.impact
    }
    
    func rolePriority() -> Int {
        return role.priority
    }
    
    func roleImage() -> UIImage {
        return role.image
    }
    
    func roleWakeTime() -> [UWNights] {
        return role.wakeTime
    }
    
    func roleCanWake() -> Bool {
        return role.canWake
    }
    
    func rolePowerChoice() -> Bool {
        return role.powerChoice
    }
    
    func rolePowerUsed() -> Bool {
        return role.powerUsed
    }
    
    func roleIsNightActiveRole() -> NightActiveStatus {
        return role.isNightActiveRole
    }
    
    func roleIsActivated() -> Bool {
        return role.isActivated
    }
    
    
    // MARK: - Role abilities
    
    func checkRoleForActivation() {
        role.checkForActivation()
    }
    
    func protect(player: Player) {
        if role.type == .Bodyguard {
            if let tempRoleType = role as? Bodyguard {
                tempRoleType.protect(player: player)
            }
            
        }
    }
}
