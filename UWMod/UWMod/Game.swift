//
//  Game.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-25.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

enum GamePhase {
    case NightPhase
    case DayPhase
}

class Game {
    
    private var _currentNight:              Int
    private var _currentDay:                Int
    private var _firstNight:                Bool
    private var _nightActors:               [Player]
    private var _consolidatedNightActors:   [Player]
    private var _rolesInTheGame:            [RoleType]
    
    var currentNight: Int {
        get { return _currentNight }
    }
    var currentDay: Int {
        get { return _currentDay }
    }
    
    var firstNight: Bool {
        get { return _firstNight }
    }
    
    var nightActors: [Player] {
        get {
            
            if _consolidatedNightActors.count > 0 {
                return _consolidatedNightActors
            }
            
            return _nightActors
        }
    }
    
    /// Player & roles before they are assigned to each other.
    var availableRoster:                    [Role]
    var availablePlayers:                   [Player]
    
    var livingActors:                       [Player]
    var playersToBeEliminated:              [Player]
    var deadActors:                         [Player]
    
    var settings:                           GameSettings
    
    var nighttimeEliminations:              Int
    var daytimeEliminations:                Int
    var playersEliminatedThisPhase:         String
    var playersProtectedThisPhase:          String
    var daytimeInfoCards:                   [DaytimeCardType]
    var areThereDeadPlayers:                Bool
    var werewolfEliminationsPerNight:       Int
    
    // Role specific variables for game state
    var aWerewolfHasBeenSlain:              Bool
    
    init(availableRoster: [Role], availablePlayers: [Player], withSettings: GameSettings = GameSettings()) {
        // Sort the roles by the role priority. This makes it easier to present the 
        // player list in some semblance of a correct order.
        self.availablePlayers               = availablePlayers.sorted(by: { ($0.name) < ($1.name) })
        self.availableRoster                = availableRoster.sorted(by: { ($0.priority) < ($1.priority) })

        self._firstNight                    = true
        self._currentNight                  = 1
        self._currentDay                    = 1
        self._nightActors                   = []
        self._consolidatedNightActors       = []
        self._rolesInTheGame                = []
        
        self.settings                       = withSettings
        
        
        self.areThereDeadPlayers            = false
        self.nighttimeEliminations          = 1
        self.daytimeEliminations            = 1
        self.livingActors                   = []
        self.playersToBeEliminated          = []
        self.deadActors                     = []
        self.playersEliminatedThisPhase     = ""
        self.playersProtectedThisPhase      = ""
        self.daytimeInfoCards               = []
        self.werewolfEliminationsPerNight   = 0
        
        self.aWerewolfHasBeenSlain          = false
    }

    
    // MARK: - Game setup & teardown
    
    public func endGameAndReset() {
        GAME = Game(availableRoster: [], availablePlayers: [])
    }
    
    
    // MARK: - Player-related functions
    
    public func addPlayerToLivingActors(player: Player) {
        livingActors.append(player)
    }
    
    private func assignInfoCardsToPlayers() {
        for actor in livingActors {
            actor.determineDaytimeInfoCardForActor()
        }
    }
    
    
    // Player elimination should happen at the END of each round after effects have been
    // applied by the different roles in order to accout for effects taking.... effect.
    public func prepareToEliminatePlayer(victim: Player) {
        if !self.playersToBeEliminated.contains(where: { $0 === victim }) {
            playersToBeEliminated.append(victim)
        }
    }
    
    private func eliminatePlayers() {
        
        for victim in playersToBeEliminated {
            if !victim.isAffectedBy(condition: .Protection) {
                if self.livingActors.contains(where: { $0 === victim }) {
                    addToPhaseReport(player: victim)
                    self.deadActors.append(victim)
                    victim.isAlive = false
                    
                    if let tempIndex = self.livingActors.index(where: { $0 === victim }) {
                        self.livingActors.remove(at: tempIndex)
                    }
                    
                    // Do not remove players from the nightActor's list to prevent role reveal
//                    if let tempIndex = self.nightActors.index(where: { $0 === victim }) {
//                        self.nightActors.remove(at: tempIndex)
//                    }

                }
            } else {
                addToPhaseReport(player: victim)
            }
        }
        
        playersToBeEliminated.removeAll()
    }
    
    private func addToPhaseReport(player: Player) {
        let textToAdd = retrievePlayerNameWithRole(player: player)
        
        if player.isAffectedBy(condition: .Protection) {
            playersProtectedThisPhase = playersProtectedThisPhase + textToAdd
        } else {
            playersEliminatedThisPhase = playersEliminatedThisPhase + textToAdd
        }
    }
    
    
    // MARK: - Player name retrieval functions for various uses
    
    // This fetches all players in a list and returns the appropriate string
    
    public func fetchPlayersWithTeamType(fromList: [Player], ofTeamType: UWTeam, withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            for teamType in player.team {
                if teamType == ofTeamType {
                    let temp = fetchSinglePlayer(player: player, withRole: withRole, separatedByComma: separatedByComma)
                    players = players + temp
                }
            }
        }
        
        return players
    }
    
    public func fetchPlayersWithRoleType(fromList: [Player], ofRoleType: RoleType, withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            if player.roleType() == ofRoleType {
                let temp = fetchSinglePlayer(player: player, withRole: withRole, separatedByComma: separatedByComma)
                players = players + temp
            }
        }
        
        return players
    }
    
    public func fetchAllPlayers(fromList: [Player], withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            let temp = fetchSinglePlayer(player: player, withRole: withRole, separatedByComma: separatedByComma)
            players = players + temp
        }
        
        return players
    }
    
    public func fetchSinglePlayer(player: Player, withRole: Bool, separatedByComma: Bool = false) -> String {
        var temp: String
        
        if withRole {
            temp = retrievePlayerNameWithRole(player: player, separatedByComma: separatedByComma)
        } else {
            temp = retrievePlayerNameWithoutRole(player: player, separatedByComma: separatedByComma)
        }
        
        return temp
    
    }

    private func retrievePlayerNameWithRole(player: Player, separatedByComma: Bool = false) -> String {
        var separator = "\n"
        if separatedByComma {
            separator = ", "
        }
        
        return "\(player.name) (\(player.roleName()))\(separator)"
    }
    
    private func retrievePlayerNameWithoutRole(player: Player, separatedByComma: Bool = false) -> String {
        var separator = "\n"
        if separatedByComma {
            separator = ", "
        }
        
        return "\(player.name)\(separator)"
    }
    
    private func clearPhaseReport() {
        playersEliminatedThisPhase = ""
        playersProtectedThisPhase = ""
    }
    
    
    // MARK: - Night functions
    
    public func finishNight() {
        
        if firstNight {
            _firstNight = false
            availablePlayers.removeAll()
            availablePlayers = livingActors
            determineRolesInTheGame()
        }
        
        resetPlayerNightActions()
        clearPhaseReport()
        determineNumberOfWerewolfEliminations()  // Figure out where this goes in order
        assignInfoCardsToPlayers()
        eliminatePlayers()
        evaluateNightActorsOrder()
        determineNightActors()
        setDeadPlayerCheck()
        setupInfoCards()
        
        _currentNight += 1
    }
    
    public func finishDay() {
        
        resetPlayerDayActions()
        clearPhaseReport()
        determineNumberOfWerewolfEliminations() // figure out where whis goes in order
        assignInfoCardsToPlayers()
        eliminatePlayers()
        evaluateNightActorsOrder()
        determineNightActors()
        setDeadPlayerCheck()
        
        _currentDay += 1
    }
    
    private func resetPlayerNightActions() {
        for player in livingActors {
            player.hasActedTonight = false
            player.cleanupAfterRound(nightRound: true)
        }
    }
    
    private func resetPlayerDayActions() {
        for player in livingActors {
            player.hasActedToday = false
            player.cleanupAfterRound(nightRound: false)
        }
    }
    
    private func setDeadPlayerCheck() {
        if !areThereDeadPlayers {
            if deadActors.count > 0 {
                areThereDeadPlayers = true
            }
        }
    }
    
    
    // MARK: - General game functions
    
    private func setupInfoCards() {
        var tempArray: [DaytimeCardType] = [.GeneralInfoCard]
        
        for player in livingActors {
            let daytimeInfoCards = player.daytimeInfoCards
            for cardType in daytimeInfoCards {
                if !tempArray.contains(cardType) {
                    tempArray.append(cardType)
                }
            }
        }
        
        if areThereDeadPlayers {
            tempArray.append(.GraveyardCard)
        }
        
        self.daytimeInfoCards.removeAll()
        self.daytimeInfoCards = tempArray
    }
    
    private func determineNumberOfWerewolfEliminations() {
        werewolfEliminationsPerNight = 1
    }
    
    private func evaluateNightActorsOrder() {
        self._nightActors = _nightActors.sorted(by: { $0.rolePriority() < $1.rolePriority()})
    }
    
    private func determineRolesInTheGame() {
        for player in availablePlayers {
            if !_rolesInTheGame.contains(player.roleType()) {
                _rolesInTheGame.append(player.roleType())
            }
        }
    }
    
    private func determineNightActors() {
        regularNightActorFill()
        consolidateNightActors()
    }
    
    private func consolidateNightActors() {
        
        var consolidatedPlayers: [Player] = []
        
        var werewolves = 0
        let consolidatedWolves: [RoleType] = [.Werewolf]
        
        var vampires = 0
        let consolidatedVampires: [RoleType] = [.Vampire]
        
        for player in livingActors {
            
            let playerRole = player.roleType()
            if consolidatedWolves.contains(playerRole) {
                werewolves += 1
            } else if consolidatedVampires.contains(playerRole) {
                vampires += 1
            }
        }
        
        // Create a Werewolf Team PLayer to present as a card.
        var didNotAddWerewolfTeamCard           = true
        var werewolfName                        = ""
        let werewolfTeamPlayer: Player          = Player(name: werewolfName)
        if werewolves >= 2 {
            for player in livingActors {
                if consolidatedWolves.contains(player.roleType()) {
                    let nameToAdd = fetchSinglePlayer(player: player, withRole: false, separatedByComma: true)
                    werewolfName = werewolfName + nameToAdd
                }
            }
        }
        if werewolfName != "" {
            let truncatedWolf = werewolfName.substring(to: werewolfName.index(werewolfName.endIndex, offsetBy: -2))
            werewolfTeamPlayer.name = truncatedWolf
        }
        werewolfTeamPlayer.assignRole(role: WEREWOLF_TEAM)
        
        
        
        // UNCOMMENT WHEN VAMPIRES ARE ADDED!
        // Create a Vampire Team players to present as a card
//        var didNotAddVampireTeamCard            = true
//        var vampireName                         = ""
//        let vampireTeamPlayer: Player           = Player(name: vampireName)
//        
//        if vampires >= 2 {
//            for player in livingActors {
//                if consolidatedVampires.contains(player.roleType()) {
//                    let nameToAdd = fetchSinglePlayer(player: player, withRole: false, separatedByComma: true)
//                    vampireName =  vampireName + nameToAdd
//                }
//            }
//        }
//        if vapireName != "" {
//            let truncatedVamp = werewolfName.substring(to: werewolfName.index(werewolfName.endIndex, offsetBy: -2))
//            vampireTeamPlayer.name = truncatedVamp
//        }
//        vampireTeamPlayer.assignRole(role: addARoleHere)
        
        // Only create consolidated players if there is a need.
        if werewolves >= 2 || vampires >= 2 {
            for player in availablePlayers {
                if player.isNightActivePlayer {
                    let playerRole = player.roleType()
                    if consolidatedWolves.contains(playerRole) {
                        if didNotAddWerewolfTeamCard {
                            consolidatedPlayers.append(werewolfTeamPlayer)
                            didNotAddWerewolfTeamCard = false
                        }
                        
        //            } else if consolidatedVampires.contains(playerRole) {
        //                if didNotAddVampireTeamCard {
        //                    consolidatedPlayers.append(vampireTeamPlayer)
        //                    didNotAddVampireTeamCard = false
        //                }
                        
                    } else {
                        consolidatedPlayers.append(player)
                    }
                }
            }
            
            consolidatedPlayers.sort(by: { ($0.rolePriority()) < ($1.rolePriority()) })
        }
        
        _consolidatedNightActors.removeAll()
        _consolidatedNightActors = consolidatedPlayers
    }
    
    private func regularNightActorFill() {
        _nightActors.removeAll()
        for actor in self.availablePlayers {
            if actor.isNightActivePlayer {
                if actor.roleType() == .Werewolf {
                    if actor.isAlive {
                        _nightActors.append(actor)
                    }
                    
                } else {
                    _nightActors.append(actor)
                }
            }
        }
        
        _nightActors.sort(by: { ($0.rolePriority()) < ($1.rolePriority()) })
    }
}
