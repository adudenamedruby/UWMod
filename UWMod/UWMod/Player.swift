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
    var killedBy:                           RoleType?
    
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
        
        self.affectingPlayers               = [:]
        self.affectedByPlayers              = [:]
        self.playersIneligibleForEffect     = [:]
        self.currentConditions              = []
        self.rolesIneligibleToAffectPlayer  = []
    }
    
    
    // MARK: - General player functions
    
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
    
    
    // MARK: - Info card related fuctions
    
    public func determineDaytimeInfoCardForActor() {
        
        determineDaytimeInfoCardForTeam()
        determineDaytimeInfoCardForPlayer()
    }
    
    private func determineDaytimeInfoCardForTeam() {
        
        for teamX in self.team {
            if teamX == .TeamWerewolf {
                addAppropriateCard(daytimeCard: .WerewolfTeamCard)
            } else if teamX == .TeamVillage {
                addAppropriateCard(daytimeCard: .VillageTeamCard)
            } else if teamX == .TeamZombie {
                addAppropriateCard(daytimeCard: .ZombieTeamCard)
            } else if teamX == .TeamBlob {
                addAppropriateCard(daytimeCard: .BlobTeamCard)
            }
        }
    }
    
    private func determineDaytimeInfoCardForPlayer() {
        
        //let playerRole = role.type
        
    }
    
    private func addAppropriateCard(daytimeCard: DaytimeCardType) {
        if !daytimeInfoCards.contains(daytimeCard) {
            daytimeInfoCards.append(daytimeCard)
        }
    }
    
    
    // MARK: - Player cleanup
    
    public func cleanupAfterRound(nightRound: Bool) {
        
        if self.currentConditions.contains(.Lobotomy) {
            self.canVote = false
        }
        
        if nightRound {
            cleanupAfterNightRound()
        } else {
            cleanupAfterDayRound()
        }
    }
    
    private func cleanupAfterNightRound() {
        
        let avaliableEffects = role.availableEffects
        
        if avaliableEffects.count > 0 {
            for effect in avaliableEffects {
                
                if role.type == .Bodyguard && effect == .Protection {
                    if affectingPlayers[effect] != nil {
                        for player in affectingPlayers[effect]! {
                            player.removeEffectFromPlayer(condition: effect, causedBy: self)
                            stopAffectingAllOtherPlayer()
                        }
                    }
                
                } else if role.type == .Zombie {
                    // Zombie continues affecting players for the rest of the game.
                } else {
                
                    
                    // do stuff for other roles here
                }
            }
        }
    }
    
    private func cleanupAfterDayRound() {
        
    }
    
    
    // MARK: - Effect-related functions
    
    /// Check whether a player is affected by a certain effect.
    public func isAffectedBy(condition: PlayerEffects) -> Bool {
        if currentConditions.contains(condition) { return true }
        return false
    }
    
    /// Check whether the player is being affected by someone with a specific condition.
    public func isAffectedBy(currentPlayer affector: Player, forCondition effect: PlayerEffects) -> Bool {
        
        if playersIneligibleForEffect[effect] != nil {
            for player in playersIneligibleForEffect[effect]! {
                if player === affector { return true }
            }
        }
        
        return false
    }
    
    /// Check whether the checking player can affect the player with a condition.
    public func canAffect(player: Player, forCondition effect: PlayerEffects) -> Bool {
        
        if playersIneligibleForEffect[effect] != nil && (playersIneligibleForEffect[effect]?.count)! > 0 {
            if (playersIneligibleForEffect[effect]?.contains(where: { $0 === player }))! {
                return false
            }
        }
        
        return true
    }
    
    public func returnPlayersCausing(condition: PlayerEffects) -> [Player] {
        
        var tempPlayers: [Player] = []
        
        if isAffectedBy(condition: condition) {
            tempPlayers = affectedByPlayers[condition]!
        }
        
        return tempPlayers
    }
    
    
    // Deal with being affected from affects from other players
    
    /// This is for the victim to remove an effect from themselves.
    private func removeEffectFromPlayer(condition: PlayerEffects, causedBy: Player) {
        
        if isAffectedBy(condition: condition) {
            let indexOfAffectingPlayer = affectedByPlayers[condition]?.index(where: { $0 === causedBy})
            affectedByPlayers[condition]?.remove(at: indexOfAffectingPlayer!)
            
            if affectedByPlayers[condition]?.count == 0 {
                let indexOfCondition = currentConditions.index(of: condition)
                currentConditions.remove(at: indexOfCondition!)
            }
        }
    }
    
    /// This is so the victim adds an effect to themselves.
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
    
    /// Add a single player to the affectingList and only allow it to be populated by one player at a time
    private func addTargetToSingularAffectingPlayerList(condition: PlayerEffects, affectedPlayer: Player) {
        trackOtherPlayers(trackingList: .AffectingList, condition: condition, player: affectedPlayer, playersToTrack: .Single)
    }
    
    /// Add the player to the affectingList and allow multiple players for each effect.
    private func addTargetToPluralAffectingPlayerList(condition: PlayerEffects, affectedPlayer: Player) {
        trackOtherPlayers(trackingList: .AffectingList, condition: condition, player: affectedPlayer, playersToTrack: .Many)
    }
    
    private func stopAffectingAllOtherPlayer() {
        self.affectingPlayers = [:]
    }
    
    /// Add single player to ineligibleList and only allow one player to be ineligible at a time.
    private func addTargetToSingularIneligibilityList(condition: PlayerEffects, playerToAdd: Player) {
        trackOtherPlayers(trackingList: .IneligibilityList, condition: condition, player: playerToAdd, playersToTrack: .Single)
    }
    
    /// Add a player to the ineligibleList and allow multiple players to populate that list.
    private func addTargetToPluralIneligibilityList(condition: PlayerEffects, playerToAdd: Player) {
        trackOtherPlayers(trackingList: .IneligibilityList, condition: condition, player: playerToAdd, playersToTrack: .Many)
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
        
        return true
    }
    
    
    // MARK: - Role-related effect functions
    
    /// Apply the protect effect to other players.
    public func protect(playerToProtect: Player, protector: Player) {
        let kindOfRole = role.type
        let effect: PlayerEffects = .Protection
        
        switch kindOfRole {
        case .Bodyguard:
            
            if canPerformEffect(condition: effect, player: playerToProtect) {
                
                // Keep track of a single protected target
                addTargetToSingularAffectingPlayerList(condition: effect, affectedPlayer: playerToProtect)
                addTargetToSingularIneligibilityList(condition: effect, playerToAdd: playerToProtect)
                
                playerToProtect.addEffectFromOtherPlayers(condition: effect,
                                                          causedBy: protector)
            }
        default: break
            // Do nothing
        }
        
    }
    
    /// Apply the Lobotomy effect to other players
    public func eatBrains(ofVictim victim: Player, zombie: Player) {
        
        let effect: PlayerEffects = .Lobotomy
        
        if self.role.type == .Zombie {
            
            if canPerformEffect(condition: effect, player: victim) {
                
                addTargetToPluralAffectingPlayerList(condition: effect, affectedPlayer: victim)
                addTargetToPluralIneligibilityList(condition: effect, playerToAdd: victim)
                
                victim.addEffectFromOtherPlayers(condition: effect, causedBy: zombie)
            }
        }
    }
    
    
    // MARK: - Role abilities
    
    private func checkRoleForActivation() {
        role.checkForActivation()
    }
}

extension Player {
    
    // MARK: - Role variable retrieval functions
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
    
    func roleEffects() -> [PlayerEffects] {
        return role.availableEffects
    }
    
    func rolePriority() -> Int {
        return role.priority
    }
    
    func roleImage() -> UIImage {
        return role.image
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
