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
    var availableRoles: [Role]
    var availablePlayers: [Player]
    var nightActors: [Player]
    var livingActors: [Player]
    var deadActors: [Player]
    var teams: [UWTeam: [Player]]
    
    init(availableRoles: [Role], availablePlayers: [Player]) {
        // Sort the roles by the role priority. This makes it easier to present the 
        // player list in some semblance of a correct order.
        self.availableRoles = availableRoles.sorted(by: { $0.priority > $1.priority })
        self.availablePlayers = availablePlayers

        self.firstNight = true
        self.currentNight = 1
        self.currentDay = 1
        self.nighttimeEliminations = 1
        self.daytimeEliminations = 1
        self.nightActors = []
        self.livingActors = []
        self.deadActors = []
        self.teams = [:]
    }

    
    // MARK: - Game setup
    
    // Game settings will be added in a later iteration.
    func startWithSettings() {
        
    }
    
    
    // MARK: - Player-related functions
    
    func assignRoles(player: Player, role: Role) {
        
    }
    
    func eliminatePlayer(victim: Player) {
        if self.livingActors.contains(where: { $0 === victim }) {
            self.deadActors.append(victim)
            if let tempIndex = self.livingActors.index(where: { $0 === victim }) {
                self.livingActors.remove(at: tempIndex)
            }
        }
    }
    
    
    // MARK: - Night functions
    
    func finishNight() {
        if firstNight {
            firstNight = false
        }
        
        currentNight += 1
    }
    
    // MARK: - Day functions
    
    func finishDay() {
        currentDay += 1
    }
    
}
