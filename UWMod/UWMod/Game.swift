//
//  Game.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-25.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

class Game {
    
    var firstNight: Bool
    var currentNight: Int
    var currentDay: Int
    var nighttimeEliminations: Int
    var daytimeEliminations: Int
    
    /// Player names before they are assigned
    var availableRoster: [String]
    var availablePlayers: [Player]
    var playersEliminatedThisPhase: String
    var playersProtectedThisPhase: String
    var daytimeInfoCards: [DaytimeCardType]
    var nightActors: [Player]
    var livingActors: [Player]
    var playersToBeEliminated: [Player]
    var deadActors: [Player]
    var teams: [UWTeam: [Player]]
    var areThereDeadPlayers: Bool
    
    init(availableRoster: [String], availablePlayers: [Player]) {
        // Sort the roles by the role priority. This makes it easier to present the 
        // player list in some semblance of a correct order.
        self.availablePlayers = availablePlayers.sorted(by: { ($0.role.priority) > ($1.role.priority) })
        self.availableRoster = availableRoster

        self.firstNight = true
        self.areThereDeadPlayers = false
        self.currentNight = 1
        self.currentDay = 1
        self.nighttimeEliminations = 1
        self.daytimeEliminations = 1
        self.nightActors = []
        self.livingActors = []
        self.playersToBeEliminated = []
        self.deadActors = []
        self.playersEliminatedThisPhase = ""
        self.playersProtectedThisPhase = ""
        self.teams = [:]
        self.daytimeInfoCards = []
    }

    
    // MARK: - Game setup
    
    // Game settings will be added in a later iteration.
    func startWithSettings() {
        
    }
    
    
    // MARK: - Player-related functions
    
    func assignRoles(player: Player, name: String) {
        player.name = name
        player.playerAssigned = true
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
                    
                    if let tempIndex = self.livingActors.index(where: { $0 === victim }) {
                        self.livingActors.remove(at: tempIndex)
                    }
                    
                    if let tempIndex = self.nightActors.index(where: { $0 === victim }) {
                        self.nightActors.remove(at: tempIndex)
                    }

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
    
    func evaluateNightActorsOrder() {
        self.nightActors.sort(by: { $0.role.priority < $1.role.priority})
    }
    
    // MARK: - Player name retrieval functions for various uses
    
    // THis fetches all players in a list and returns the appropriate string
    func fetchPlayers(fromList: [Player], withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            var temp: String
            
            if withRole {
                temp = retrievePlayerNameWithRole(player: player, separatedByComma: separatedByComma)
            } else {
                temp = retrievePlayerNameWithoutRole(player: player, separatedByComma: separatedByComma)
            }
            
            players = players + temp
        }
        
        return players
    }

    func retrievePlayerNameWithRole(player: Player, separatedByComma: Bool = false) -> String {
        var separator = "\n"
        if separatedByComma {
            separator = ", "
        }
        
        return "\(player.name) (\(player.role.name))\(separator)"
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
            livingActors = availablePlayers
            nightActors = availablePlayers
        }
        
        clearPhaseReport()
        eliminatePlayers()
        evaluateNightActorsOrder()
        setDeadPlayerCheck()
        setupInfoCards()
        
        currentNight += 1
    }
    
    // MARK: - Day functions
    
    func finishDay() {
        
        clearPhaseReport()
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
    
    func setupInfoCards() {
        var tempArray: [DaytimeCardType] = [.GeneralInfoCard]
        
        for player in livingActors {
            let daytimeCardInfo = player.role.daytimeInfoCard
            for cardType in daytimeCardInfo {
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
    
}
