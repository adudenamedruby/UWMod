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
    var currentDay: Int
    var availableRoles: [Role]
    var playerRoles: [Player]
    
    init(availableRoles: [Role]) {
        // Sort the roles by the role priority. This makes it easier to present the 
        // player list in some semblance of a correct order.
        self.availableRoles = availableRoles.sorted(by: { $0.priority > $1.priority })

        self.firstNight = true
        self.currentDay = 1
        self.playerRoles = [Player]()
    }
}
