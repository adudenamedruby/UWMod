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
    
    var firstNight:                         Bool
    var currentNight:                       Int
    var currentDay:                         Int
    var nighttimeEliminations:              Int
    var daytimeEliminations:                Int
    
    /// Player & roles before they are assigned
    var availableRoster:                    [Role]
    var availablePlayers:                   [Player]
    
    var playersEliminatedThisPhase:         String
    var playersProtectedThisPhase:          String
    var daytimeInfoCards:                   [DaytimeCardType]
    var nightActors:                        [Player]
    var livingActors:                       [Player]
    var playersToBeEliminated:              [Player]
    var deadActors:                         [Player]
    var teams:                              [UWTeam: [Player]]
    var areThereDeadPlayers:                Bool
    var werewolfEliminationsPerNight:       Int
    
    init(availableRoster: [Role], availablePlayers: [Player]) {
        // Sort the roles by the role priority. This makes it easier to present the 
        // player list in some semblance of a correct order.
        self.availablePlayers               = availablePlayers.sorted(by: { ($0.name) < ($1.name) })
        self.availableRoster                = availableRoster.sorted(by: { ($0.priority) < ($1.priority) })

        self.firstNight                     = true
        self.areThereDeadPlayers            = false
        self.currentNight                   = 1
        self.currentDay                     = 1
        self.nighttimeEliminations          = 1
        self.daytimeEliminations            = 1
        self.nightActors                    = []
        self.livingActors                   = []
        self.playersToBeEliminated          = []
        self.deadActors                     = []
        self.playersEliminatedThisPhase     = ""
        self.playersProtectedThisPhase      = ""
        self.teams                          = [:]
        self.daytimeInfoCards               = []
        self.werewolfEliminationsPerNight   = 0
    }

    
    // MARK: - Game setup & teardown
    
    // Game settings will be added in a later version.
    func startWithSettings() {
        
    }
    
    func endGameAndReset() {
        GAME = Game(availableRoster: [], availablePlayers: [])
    }
    
    
    // MARK: - Player-related functions
    
    func addPlayerToLivingActors(player: Player) {
        livingActors.append(player)
    }
    
    func assignInfoCardsToPlayers() {
        for actor in livingActors {
            actor.determineDaytimeInfoCardForPlayer()
        }
    }
    
    func prepareToEliminatePlayer(victim: Player) {
        if !self.playersToBeEliminated.contains(where: { $0 === victim }) {
            playersToBeEliminated.append(victim)
        }
    }
    
    func eliminatePlayers() {
        
        for victim in playersToBeEliminated {
            if !victim.isProtected {
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
            } else if victim.isProtected {
                addToPhaseReport(player: victim)
            }
        }
        
        playersToBeEliminated.removeAll()
    }
    
    func addToPhaseReport(player: Player) {
        let textToAdd = retrievePlayerNameWithRole(player: player)
        
        if player.isProtected {
            playersProtectedThisPhase = playersProtectedThisPhase + textToAdd
        } else {
            playersEliminatedThisPhase = playersEliminatedThisPhase + textToAdd
        }
    }
    
    
    // MARK: - Player name retrieval functions for various uses
    
    // This fetches all players in a list and returns the appropriate string
    
    func fetchPlayersWithTeamType(fromList: [Player], ofTeamType: UWTeam, withRole: Bool = false, separatedByComma: Bool = false) -> String {
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
    
    func fetchPlayersWithRoleType(fromList: [Player], ofRoleType: RoleType, withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            if player.roleType() == ofRoleType {
                let temp = fetchSinglePlayer(player: player, withRole: withRole, separatedByComma: separatedByComma)
                players = players + temp
            }
        }
        
        return players
    }
    
    func fetchAllPlayers(fromList: [Player], withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            let temp = fetchSinglePlayer(player: player, withRole: withRole, separatedByComma: separatedByComma)
            players = players + temp
        }
        
        return players
    }
    
    func fetchSinglePlayer(player: Player, withRole: Bool, separatedByComma: Bool = false) -> String {
        var temp: String
        
        if withRole {
            temp = retrievePlayerNameWithRole(player: player, separatedByComma: separatedByComma)
        } else {
            temp = retrievePlayerNameWithoutRole(player: player, separatedByComma: separatedByComma)
        }
        
        return temp
    
    }

    func retrievePlayerNameWithRole(player: Player, separatedByComma: Bool = false) -> String {
        var separator = "\n"
        if separatedByComma {
            separator = ", "
        }
        
        return "\(player.name) (\(player.roleName()))\(separator)"
    }
    
    func retrievePlayerNameWithoutRole(player: Player, separatedByComma: Bool = false) -> String {
        var separator = "\n"
        if separatedByComma {
            separator = ", "
        }
        
        return "\(player.name)\(separator)"
    }
    
    func clearPhaseReport() {
        playersEliminatedThisPhase = ""
        playersProtectedThisPhase = ""
    }
    
    
    // MARK: - Night functions
    
    func finishNight() {
        
        if firstNight {
            firstNight = false
            populateNightActors()
        }
        
        clearPhaseReport()
        determineNumberOfWerewolfEliminations()  // Figure out where this goes in order
        assignInfoCardsToPlayers()
        eliminatePlayers()
        evaluateNightActorsOrder()
        setDeadPlayerCheck()
        setupInfoCards()
        
        currentNight += 1
    }
    
    // MARK: - Day functions
    
    func finishDay() {
        
        clearPhaseReport()
        determineNumberOfWerewolfEliminations() // figure out where whis goes in order
        assignInfoCardsToPlayers()
        eliminatePlayers()
        evaluateNightActorsOrder()
        setDeadPlayerCheck()
        
        currentDay += 1
    }
    
    func setDeadPlayerCheck() {
        if !areThereDeadPlayers {
            if deadActors.count > 0 {
                areThereDeadPlayers = true
            }
        }
    }
    
    
    // MARK: - General game functions
    
    func setupInfoCards() {
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
    
    func determineNumberOfWerewolfEliminations() {
        werewolfEliminationsPerNight = 1
    }
    
    func evaluateNightActorsOrder() {
        self.nightActors.sort(by: { $0.rolePriority() < $1.rolePriority()})
    }
    
    func populateNightActors() {
        for actor in self.livingActors {
            if actor.isNightActivePlayer {
                nightActors.append(actor)
            }
        }
    }
}
