//
//  Constants.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

enum UWTeam: String {
    case TeamWerewolf = "Werewolf"
    case TeamVillage = "Village"
    case TeamCult = "The Cult"
    case TeamBlob = "The Blob"
    case TeamChupacabra = "Chupacabra"
    case TeamCountDracula = "Dracula"
    case TeamHoodlum = "Hoodlum"
    case TeamTanner = "Tanner"
    case TeamVamprie = "Vampire"
    case TeamZombie = "Zombie"
    case TeamBoegyman = "Boegyman"
    case UnknownTeam = "No Team"
}

enum UWNights: Int {
    case EveryNight = 0
    case First = 1
    case Second = 2
    case Third = 3
}


// Global Variables
let PLAYERS = "UserPlayers"
var GAME: Game = Game(availableRoster: [], availablePlayers: [])
