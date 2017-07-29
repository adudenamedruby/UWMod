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
    var livingPlayers: [Player]
    var deadPlayers: [Player]
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
        self.nightActors = [Player]()
        self.livingPlayers = [Player]()
        self.deadPlayers = [Player]()
        self.teams = [UWTeam: [Player]]()
    }

    
    // MARK: - Game setup
    
    func startWithSettings() {
        
    }
    
    
    // MARK: - Player-related functions
    
    func assignRoles(player: Player, role: Role) {
        
    }
    
    func eliminatePlayer(victim: Player) {
        if self.livingPlayers.contains(where: { $0 === victim }) {
            self.deadPlayers.append(victim)
            if let tempIndex = self.livingPlayers.index(where: { $0 === victim }) {
                self.livingPlayers.remove(at: tempIndex)
            }
        }
    }
    
    
    // MARK: - Night functions
    
    func night() {
        if self.firstNight == true {
            firstNightRoleCall()
            
        }
    }
    
    func firstNightRoleCall() {
        
    }
    
}
