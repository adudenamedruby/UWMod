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

let tempRoles: [Role] = [BODYGUARD,
                         VILLAGER_ONE, VILLAGER_TWO, VILLAGER_THREE, VILLAGER_FOUR, VILLAGER_FIVE, VILLAGER_SIX, VILLAGER_SEVEN, VILLAGER_EIGHT, VILLAGER_NINE, VILLAGER_TEN, VILLAGER_ELEVEN, VILLAGER_TWELVE, VILLAGER_THIRTEEN, VILLAGER_FOURTEEN, VILLAGER_FIFTEEN,
                         SEER,
                         WEREWOLF_ONE, WEREWOLF_TWO, WEREWOLF_THREE, WEREWOLF_FOUR, WEREWOLF_FIVE, WEREWOLF_SIX, WEREWOLF_SEVEN, WEREWOLF_EIGHT, WEREWOLF_NINE, WEREWOLF_TEN, WEREWOLF_ELEVEN, WEREWOLF_TWELVE]

let ALL_GAME_ROLES: [Role] = tempRoles.sorted(by: { $0.name < $1.name})


// Roles get instantiated here! Fancy!

let BODYGUARD = Role(name: "Bodyguard", type: .Bodyguard, description: "Each night, choose a player who cannot be eliminated that night. (Must be different.)", roleExplanation: "The Bodyguard chooses a different player each night to protect (but not the same player twice in a row). That player cannot be eliminated that night. He may not choose himself.", impact: 3, priority: 19, powerChoice: false, team: [.TeamVillage], availableEffects: [.Protection], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "bodyguard"), isNightActiveRole: .NightActiveRole)

let SEER = Role(name: "Seer", type: .Seer, description: "Each night choose a player to learn if he is a Villager or a Werewolf.", roleExplanation: "Each night, the Seer points at a player, and the Moderator shows her a “V” for Villager or “W” for Werewolf. To be extra clear that the Seer knows that a targeted player is a Werewolf, the Moderator may use another indicator (such as a thumbs up and thumbs down).", impact: 4, priority: 2, powerChoice: false, team: [.TeamVillage], availableEffects: [.Protection], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "seer"), isNightActiveRole: .NightActiveRole)


let VILLAGER_ONE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_TWO = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_THREE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FOUR = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FIVE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_SIX = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_SEVEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_EIGHT = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_NINE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_TEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_ELEVEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_TWELVE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_THIRTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FOURTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FIFTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 3, powerChoice: false, team: [.TeamVillage], availableEffects: [], wakeTime: [.First], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")


let WEREWOLF_ONE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_TWO = Role(name: "Werewolf", type: .Werewolf,description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_THREE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_FOUR = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_FIVE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_SIX = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_SEVEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_EIGHT = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_NINE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_TEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_ELEVEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_TWELVE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 1, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], wakeTime: [.EveryNight], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)
