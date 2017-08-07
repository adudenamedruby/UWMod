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
    var hasActedToday:                      Bool
    var isNightActivePlayer:                Bool
    var killedBy:                           String
    
    // What conditions are currently afflicting the player and by who. Done in two
    // for easier logic checks... for me, really.
    var currentConditions:                  [PlayerEffects]
    var affectedByPlayers:                  [PlayerEffects:[Player]]
    // Who this player is currently affecting. Might be only one person at a time.
    var affectingPlayers:                   [PlayerEffects:[Player]]
    // Who this player can no longer affect. Might be one or many players due to rules.
    var playersIneligibleForEffect:         [PlayerEffects:[Player]]
    var rolesIneligibleToAffectPlayer:      [RoleType]
    
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
        self.hasActedToday                  = false
        self.killedBy                       = ""
        
        self.affectingPlayers               = [:]
        self.affectedByPlayers              = [:]
        self.playersIneligibleForEffect     = [:]
        self.currentConditions              = []
        self.rolesIneligibleToAffectPlayer  = []
    }
    
    
    // MARK: - General player specific functions
    
    public func assignRole(role: Role) {
        self.role                           = role
        self.team                           = role.team
        self.isNightActivePlayer            = role.isNightActiveRole.currentStatus
        self.isAssigned                     = true
    }
    
    public func addToTeam(team: UWTeam) {
        self.team.append(team)
    }
    
    public func switchTeam(from: UWTeam, to:UWTeam) {
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
    
    public func addAppropriateCard(daytimeCard: DaytimeCardType) {
        if !daytimeInfoCards.contains(daytimeCard) {
            daytimeInfoCards.append(daytimeCard)
        }
    }
    
    
    // MARK: - Effect-related functions
    
    public func isAffectedBy(condition: PlayerEffects) -> Bool {
        if currentConditions.contains(condition) { return true }
        return false
    }
    
    public func isAffectedBy(player: Player) -> Bool {
        
        return false
    }
    
    public func isAffectedBy(role roleType: RoleType, forCondition effect: PlayerEffects) -> Bool {
        
        if playersIneligibleForEffect[effect] != nil {
            for player in playersIneligibleForEffect[effect]! {
                if player.role.type == roleType { return true }
            }
        }
        
        return false
    }
    
    public func returnPlayersCausing(condition: PlayerEffects) -> [Player] {
        
        var tempPlayers: [Player] = []
        
        if isAffectedBy(condition: condition) {
            tempPlayers = affectedByPlayers[condition]!
        }
        
        return tempPlayers
    }
    
    // Deal with being affected from affects from other players
    
    private func removeEffectFromOtherPlayers(condition: PlayerEffects, causedBy: Player) {
        
        if isAffectedBy(condition: condition) {
            let indexOfAffectingPlayer = affectedByPlayers[condition]?.index(where: { $0 === causedBy})
            affectedByPlayers[condition]?.remove(at: indexOfAffectingPlayer!)
            
            if affectedByPlayers[condition]?.count == 0 {
                let indexOfCondition = currentConditions.index(of: condition)
                currentConditions.remove(at: indexOfCondition!)
            }
        }
    }
    
    private func addEffectFromOtherPlayers(condition: PlayerEffects, causedBy: Player) {
        
        if isAffectedBy(condition: condition) {
            if !(affectedByPlayers[condition]?.contains(where: { $0 === causedBy}))! {
                affectedByPlayers[condition]?.append(causedBy)
            }
        } else {
            currentConditions.append(condition)

            if !(affectedByPlayers[condition] != nil) {
                affectedByPlayers[condition] = []
            }
            
            affectedByPlayers[condition]?.append(causedBy)
        }
    }
    
    
    // Track how you're affecting other players
    
    private func affectSinglePlayer(condition: PlayerEffects, player: Player) {
        trackOtherPlayers(trackingList: .AffectingList, condition: condition, player: player, playersToTrack: .Single)
    }
    
    private func addPlayerToAffectedPlayers(condition: PlayerEffects, player: Player) {
        trackOtherPlayers(trackingList: .AffectingList, condition: condition, player: player, playersToTrack: .Many)
    }
    
    private func stopAffectingAllOtherPlayer() {
        self.affectingPlayers = [:]
    }
    
    private func affectSingleTargetInIneligibleList(condition: PlayerEffects, player: Player) {
        trackOtherPlayers(trackingList: .IneligibilityList, condition: condition, player: player, playersToTrack: .Single)
    }
    
    private func addTargetToOthersInIneligibleList(condition: PlayerEffects, player: Player) {
        trackOtherPlayers(trackingList: .IneligibilityList, condition: condition, player: player, playersToTrack: .Many)
    }
    
    private func trackOtherPlayers(trackingList: PlayersToTrack, condition: PlayerEffects, player: Player, playersToTrack: PlayersToTrack) {
        
        if trackingList == .AffectingList {
            
            if !(affectingPlayers[condition] != nil) {
                affectingPlayers[condition] = []
            }
            
            if playersToTrack == .Single && (affectingPlayers[condition]?.count)! > 0 {
                affectingPlayers[condition]?.removeFirst()
            }
            
            affectingPlayers[condition]?.append(player)
            
        } else if trackingList == .IneligibilityList {
            
            if !(playersIneligibleForEffect[condition] != nil) {
                playersIneligibleForEffect[condition] = []
            }
            
            if playersToTrack == .Single && (playersIneligibleForEffect[condition]?.count)! > 0 {
                playersIneligibleForEffect[condition]?.removeFirst()
            }
            
            playersIneligibleForEffect[condition]?.append(player)
        }
    }
    
    private func canPerformEffect(condition: PlayerEffects, player: Player) -> Bool{
        if playersIneligibleForEffect.count == 0            { return true }
        
        if !(playersIneligibleForEffect[condition] != nil)  { return true }
        
        if (playersIneligibleForEffect[condition]?.contains(where: { $0 === player }))! {
            return false
        }
        
        // This return should NEVER be reached
        return false
    }
    
    // MARK: - Role abilities
    
    func checkRoleForActivation() {
        role.checkForActivation()
    }
    
    // Protection
    public func protect(playerToProtect: Player, protector: Player) {
        let kindOfRole = role.type
        let effect: PlayerEffects = .Protection
        
        switch kindOfRole {
        case .Bodyguard:
            
            if canPerformEffect(condition: effect, player: playerToProtect) {
                
                // Keep track of a single protected target
                affectSinglePlayer(condition: effect, player: playerToProtect)
                affectSingleTargetInIneligibleList(condition: effect, player: playerToProtect)
                
                playerToProtect.addEffectFromOtherPlayers(condition: effect,
                                                          causedBy: protector)
            }
        default: break
            // Do nothing
        }
        
    }
    
}

extension Player {
    
    // MARK: - Role variable functions
    // This abstraction layer prevents views from having to reach into player and accessing
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
}
