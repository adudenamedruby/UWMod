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
    var nightActors: [Player]
    var livingActors: [Player]
    var playersToBeEliminated: [Player]
    var deadActors: [Player]
    var teams: [UWTeam: [Player]]
    
    init(availableRoster: [String], availablePlayers: [Player]) {
        // Sort the roles by the role priority. This makes it easier to present the 
        // player list in some semblance of a correct order.
        self.availablePlayers = availablePlayers.sorted(by: { ($0.role.priority) > ($1.role.priority) })
        self.availableRoster = availableRoster

        self.firstNight = true
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
    }

    
    // MARK: - Game setup
    
    // Game settings will be added in a later iteration.
    func startWithSettings() {
        
    }
    
    
    // MARK: - Player-related functions
    // TODO: populate the playersEliminatedThisPhase and playersProtectedThisPhase array for night/day end, and the clean it
    
    func assignRoles(player: Player, name: String) {
        player.name = name
        player.playerAssigned = true
    }
    
    func prepareToEliminatePlayer(victim: Player) {
        playersToBeEliminated.append(victim)
    }
    
    func eliminatePlayers() {
        for victim in playersToBeEliminated {
            if !victim.protected {
                if self.livingActors.contains(where: { $0 === victim }) {
                    self.deadActors.append(victim)
                    if let tempIndex = self.livingActors.index(where: { $0 === victim }) {
                        self.livingActors.remove(at: tempIndex)
                    }
                }
            }
        }
        
        playersToBeEliminated.removeAll()
    }
    
    func addToPhaseReport(player: Player) {
        let textToAdd = "\(player.name)\n"
        
        if player.isProtected {
            playersProtectedThisPhase = playersProtectedThisPhase + textToAdd
        } else {
            playersEliminatedThisPhase = playersEliminatedThisPhase + textToAdd
        }
    }
    
    func clearPhaseReport() {
        playersEliminatedThisPhase = ""
        playersProtectedThisPhase = ""
    }
    
    
    // MARK: - Night functions
    
    func finishNight() {
        
        if firstNight {
            firstNight = false
            eliminatePlayers()
            livingActors = availablePlayers
        }
        
        currentNight += 1
    }
    
    // MARK: - Day functions
    
    func finishDay() {
        eliminatePlayers()
        currentDay += 1
    }
    
}
