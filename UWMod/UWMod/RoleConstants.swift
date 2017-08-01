//
//  RoleConstants.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-26.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

// Roles in the game

let SEER = Role(name: "Seer", description: "Test description", notes: "More notes", impact: 4, priority: 2, powerChoice: false, team: .TeamVillage, wakeTime: .EveryNight, image: #imageLiteral(resourceName: "seerImage"))

let VILLAGER_ONE = Role(name: "Villager", description: "Find the werewolves and eliminate them.", notes: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: .First, image: #imageLiteral(resourceName: "seerImage"))

let WEREWOLF_ONE = Role(name: "Werewolf", description: "Each night, wake with the other Werewolves and choose a player to eliminate.", notes: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: .EveryNight, image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_TWO = Role(name: "Werewolf", description: "Each night, wake with the other Werewolves and choose a player to eliminate.", notes: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: .EveryNight, image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_THREE = Role(name: "Werewolf", description: "Each night, wake with the other Werewolves and choose a player to eliminate.", notes: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: .EveryNight, image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_FOUR = Role(name: "Werewolf", description: "Each night, wake with the other Werewolves and choose a player to eliminate.", notes: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: .EveryNight, image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_FIVE = Role(name: "Werewolf", description: "Each night, wake with the other Werewolves and choose a player to eliminate.", notes: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: .EveryNight, image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_SIX = Role(name: "Werewolf", description: "Each night, wake with the other Werewolves and choose a player to eliminate.", notes: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: .EveryNight, image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_SEVEN = Role(name: "Werewolf", description: "Each night, wake with the other Werewolves and choose a player to eliminate.", notes: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: .EveryNight, image: #imageLiteral(resourceName: "werewolf"))

let ALL_GAME_ROLES: [Role] = [VILLAGER_ONE, SEER, WEREWOLF_ONE, WEREWOLF_TWO, WEREWOLF_THREE, WEREWOLF_FOUR, WEREWOLF_FIVE, WEREWOLF_SIX, WEREWOLF_SEVEN]
