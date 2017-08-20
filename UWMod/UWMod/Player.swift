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
    private var _role:                      Role!
    private var _person:                    Person!
    private var _name:                      String!
    var gameID:                             Int
    var isAlive:                            Bool
    var team:                               [UWTeam]
    var daytimeInfoCards:                   [DaytimeCardType]
    var isMute:                             Bool
    var isAssigned:                         Bool
    var hasActedTonight:                    Bool
    var hasActedToday:                      Bool
    var isNightActivePlayer:                Bool
    var killedBy:                           RoleType?
    
    var name: String {
        get { return name }
    }
    
    // What conditions are currently afflicting the player and by who. Done in two
    // for easier logic checks... for me, really.
    var currentConditions:                  [PlayerEffects]
    var affectedByPlayers:                  [PlayerEffects:[Player]]
    // Who this player is currently affecting. Might be only one person at a time.
    var affectingPlayers:                   [PlayerEffects:[Player]]
    // Who this player can no longer affect. Might be one or many players due to rules.
    var playersIneligibleForEffect:         [PlayerEffects:[Player]]
    var rolesIneligibleToAffectPlayer:      [RoleType]
    
    init (withIdentity person: Person) {
        self._person                        = person
        self.gameID                         = 0
        self._name                          = setPlayerName()
        self.team                           = []
        self.daytimeInfoCards               = []

        self.isAlive                        = true
        self.isMute                         = false
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
        self._role                           = role
        self.isNightActivePlayer            = role.isNightActiveRole.currentStatus
        self.isAssigned                     = true
        
        for currentTeam in role.team {
            self.team.append(currentTeam)
        }
    }
    
    public func updateRole(withRole newRole: Role) {
        let oldRole                         = self._role
        
        self._role                          = newRole
        self.isNightActivePlayer            = newRole.isNightActiveRole.currentStatus
        self.isAssigned                     = true
        
        for currentRole in newRole.team {
            self.team.append(currentRole)
        }
        
        for teamX in self.team {
            if (oldRole?.team.contains(teamX))! {
                let indx = self.team.index(where: { $0 == teamX} )
                self.team.remove(at: indx!)
                break
            }
        }
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
    
    private func setPlayerName() {
        if gameID == 0 {
            _name           = "\(_person.firstName) \(_person.lastName[0])."
        } else {
            _name           = "\(_person.firstName) (\(gameID))"
        }
    }
    
    // MARK: - Info card related fuctions
    
    public func determineDaytimeInfoCardForActor() {
        
        determineTeamForPlayer()
        determineDaytimeInfoCardForTeam()
    }
    
    private func determineTeamForPlayer() {
        
        if currentConditions.contains(.Lovestruck) {
            addToTeam(team: .TeamLovebirds)
        }
        
        if currentConditions.contains(.Silence) {
            addAppropriateCard(daytimeCard: .SpellcasterSilenceCard)
        }
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
            } else if teamX == .TeamCult {
                addAppropriateCard(daytimeCard: .CultTeamCard)
            } else if teamX == .TeamLovebirds {
                addAppropriateCard(daytimeCard: .LovebirdTeamCard)
            }
        }
    }
    
    private func addAppropriateCard(daytimeCard: DaytimeCardType) {
        if !daytimeInfoCards.contains(daytimeCard) {
            daytimeInfoCards.append(daytimeCard)
        }
    }
    
    
    // MARK: - Player cleanup
    
    public func cleanupAfterRound(nightRound: Bool) {
        
        if nightRound {
            cleanupAfterNightRound()
        } else {
            cleanupAfterDayRound()
        }
    }
    
    private func cleanupAfterNightRound() {
        
        for effect in currentConditions {
            if effect == .Protection && affectedByPlayers[effect] != nil {
                for player in affectedByPlayers[effect]! {
                    player.stopAffectingAllOtherPlayer()
                    removeEffectFromPlayer(condition: effect, causedBy: player)
                }
                
            }
        }
    }
    
    private func cleanupAfterDayRound() {
        
        for effect in currentConditions {
            
            if effect == .Silence && affectedByPlayers[effect] != nil {
                for caster in affectedByPlayers[effect]! {
                    caster.stopAffectingAllOtherPlayer()
                    removeEffectFromPlayer(condition: .Silence, causedBy: caster)
                }
                
                if daytimeInfoCards.contains(.SpellcasterSilenceCard) {
                    let indx = daytimeInfoCards.index(where: { $0 == .SpellcasterSilenceCard } )
                    daytimeInfoCards.remove(at: indx!)
                }
            }
        }
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
    public func protect(playerToProtect: Player) {
        let kindOfRole = _role.type
        let effect: PlayerEffects = .Protection
        
        switch kindOfRole {
        case .Bodyguard:
            if canPerformEffect(condition: effect, player: playerToProtect) {
                
                // Keep track of a single protected target
                addTargetToSingularAffectingPlayerList(condition: effect,
                                                       affectedPlayer: playerToProtect)
                addTargetToSingularIneligibilityList(condition: effect,
                                                     playerToAdd: playerToProtect)
                
                playerToProtect.addEffectFromOtherPlayers(condition: effect,
                                                          causedBy: self)
                
            }
            
        case .Priest:
            if canPerformEffect(condition: effect, player: playerToProtect) {
                
                // Keep track of a single protected target
                addTargetToSingularAffectingPlayerList(condition: effect,
                                                       affectedPlayer: playerToProtect)
                addTargetToSingularIneligibilityList(condition: effect,
                                                     playerToAdd: playerToProtect)
                
                playerToProtect.addEffectFromOtherPlayers(condition: effect,
                                                          causedBy: self)
                
            }
            
        default: break
            // Do nothing
        }
        
    }
    
    /// Apply the link effect to players
    public func linkPlayers(playerToLink: Player) {
        
        let kindOfRole = _role.type
        
        switch kindOfRole {
        case .Cupid:
            
            addTargetToPluralAffectingPlayerList(condition: .Lovestruck,
                                                 affectedPlayer: playerToLink)
            addTargetToPluralIneligibilityList(condition: .Lovestruck,
                                               playerToAdd: playerToLink)
            
            playerToLink.addEffectFromOtherPlayers(condition: .Lovestruck,
                                                   causedBy: self)
            
        case .VirginiaWoolf:
            break
            
        default: break
        }
        
    }
    
    /// Apply the Lobotomy effect to other players
    public func eatBrains(ofVictim victim: Player) {
        
        let effect: PlayerEffects = .Lobotomy
        
        if self._role.type == .Zombie {
            
            if canPerformEffect(condition: effect, player: victim) {
                
                addTargetToPluralAffectingPlayerList(condition: effect,
                                                     affectedPlayer: victim)
                addTargetToPluralIneligibilityList(condition: effect,
                                                   playerToAdd: victim)
                
                victim.addEffectFromOtherPlayers(condition: effect,
                                                 causedBy: self)
            }
        }
    }
    
    /// Apply the silence effect to players
    public func silence(playerToSilence: Player) {
        
        addTargetToSingularAffectingPlayerList(condition: .Silence,
                                               affectedPlayer: playerToSilence)
        addTargetToPluralIneligibilityList(condition: .Silence,
                                           playerToAdd: playerToSilence)
        
        playerToSilence.addEffectFromOtherPlayers(condition: .Silence,
                                                  causedBy: self)
        
    }
    
    
    // MARK: - Role abilities
    
    private func checkRoleForActivation() {
        _role.checkForActivation()
    }
    
    
    // MARK: - Role variable retrieval functions
    // This abstraction layer prevents views from having to reach into player and accessing
    // the Role object directly.
    
    func hasUsedOneTimePower() {
        self._role.powerUsed = true
    }
    
    var role: Role! {
        get { return _role }
    }
    
    var roleName: String {
        get { return _role.name }
    }

    var roleType: RoleType {
        get { return _role.type }
    }
    
    var roleDescription: String {
        get { return _role.description }
    }
    
    var roleExplanation: String {
        get { return _role.roleExplanation }
    }
    
    var roleNotes: String {
        get { return _role.notes }
    }
    
    var roleImpact: Int {
        get { return _role.impact }
    }
    
    var roleEffects: [PlayerEffects] {
        get { return _role.availableEffects }
    }
    
    var rolePriority: Int {
        get { return _role.priority }
    }
    
    var roleImage: UIImage {
        get { return _role.image }
    }
    
    var rolePowerUsed: Bool {
        get { return _role.powerUsed }
    }
}
