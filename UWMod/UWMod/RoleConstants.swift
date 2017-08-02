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

let tempRoles: [Role] = [VILLAGER_ONE, VILLAGER_TWO, VILLAGER_THREE, VILLAGER_FOUR, VILLAGER_FIVE, VILLAGER_SIX, VILLAGER_SEVEN, VILLAGER_EIGHT, VILLAGER_NINE, VILLAGER_TEN, VILLAGER_ELEVEN, VILLAGER_TWELVE, VILLAGER_THIRTEEN, VILLAGER_FOURTEEN, VILLAGER_FIFTEEN,
                         SEER,
                         WEREWOLF_ONE, WEREWOLF_TWO, WEREWOLF_THREE, WEREWOLF_FOUR, WEREWOLF_FIVE, WEREWOLF_SIX, WEREWOLF_SEVEN, WEREWOLF_EIGHT, WEREWOLF_NINE, WEREWOLF_TEN, WEREWOLF_ELEVEN, WEREWOLF_TWELVE]

let ALL_GAME_ROLES: [Role] = tempRoles.sorted(by: { $0.name < $1.name})




let SEER = Role(name: "Seer", type: .Seer, description: "Test description", roleExplanation: "More notes", impact: 4, priority: 2, powerChoice: false, team: .TeamVillage, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "seerImage"))

let VILLAGER_ONE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_TWO = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_THREE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FOUR = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FIVE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_SIX = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_SEVEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_EIGHT = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_NINE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_TEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_ELEVEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_TWELVE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_THIRTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FOURTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FIFTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "test notes", impact: 3, priority: 3, powerChoice: false, team: .TeamVillage, wakeTime: [.First], image: #imageLiteral(resourceName: "seerImage"), notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")


let WEREWOLF_ONE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_TWO = Role(name: "Werewolf", type: .Werewolf,description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_THREE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_FOUR = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_FIVE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_SIX = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_SEVEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_EIGHT = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_NINE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_TEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_ELEVEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))

let WEREWOLF_TWELVE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "Test Notes", impact: -6, priority: 1, powerChoice: false, team: .TeamWerewolf, wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"))
