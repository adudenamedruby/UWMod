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
                         DISEASED,
                         INSOMNIAC,
                         MAYOR,
                         MINION,
                         SEER,
                         THING,
                         VILLAGER_ONE, VILLAGER_TWO, VILLAGER_THREE, VILLAGER_FOUR, VILLAGER_FIVE, VILLAGER_SIX, VILLAGER_SEVEN, VILLAGER_EIGHT, VILLAGER_NINE, VILLAGER_TEN, VILLAGER_ELEVEN, VILLAGER_TWELVE, VILLAGER_THIRTEEN, VILLAGER_FOURTEEN, VILLAGER_FIFTEEN,
                        WEREWOLF_ONE, WEREWOLF_TWO, WEREWOLF_THREE, WEREWOLF_FOUR, WEREWOLF_FIVE, WEREWOLF_SIX, WEREWOLF_SEVEN, WEREWOLF_EIGHT, WEREWOLF_NINE, WEREWOLF_TEN, WEREWOLF_ELEVEN, WEREWOLF_TWELVE,
                         WOLFMAN]

let ALL_GAME_ROLES: [Role] = tempRoles.sorted(by: { $0.name < $1.name})


// ROLE RUNBOOK
// Add role definition here and add to ALL_GAME_ROLES
// Add roles to elimination for effects



// Roles get instantiated here! Fancy!
// Alphabetical order


let BODYGUARD = Role(name: "Bodyguard", type: .Bodyguard, description: "Each night, choose a player who cannot be eliminated that night. (Must be different.)", roleExplanation: "The Bodyguard chooses a different player each night to protect (but not the same player twice in a row). That player cannot be eliminated that night. He may not choose himself.", impact: 3, priority: 52, powerChoice: false, team: [.TeamVillage], availableEffects: [.Protection], image: #imageLiteral(resourceName: "bodyguard"), isNightActiveRole: .NightActiveRole)



let DISEASED = Role(name: "Diseased", type: .Diseased, description: "If you are eliminated by the Werewolves, they don't get to eliminate anyone the following night.", roleExplanation: "If the werewolves target and eliminate the Diseased player, they skip targeting the following night because they get sick. If the game does not have role reveal, the Werewolves still pick a target the following night but that target is not eliminated.", impact: 3, priority: 88, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)



let INSOMNIAC = Role(name: "Insomniac", type: .Insomniac, description: "Each night, learn if at least one of your neighbors has taken a night action.", roleExplanation: "Every night, the Insomniac is told if anyone woke up at night who is sitting next to him.\n\nThe Moderator does not tell the Insomniac if 1 or 2 players sitting next to him woke up at night, just that at least one of those players woke up that night. If a player next to the Insomniac is eliminated, the next player over is considered “next” to the Insomniac. If a player next to to the Insomniac is eliminated at night, he “sees” that player, not the player next to the eliminated player.\n\nThe Insomniac player needs to be clever when sharing any information he has about the players next to him, so he doesn’t accidentally out the Seer or another special character that is helping the village. The fewer special characters in the game, the more helpful the Insomniac role is to the village.", impact: 3, priority: 199, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NightActiveRole)



let MAYOR = Role(name: "Mayor", type: .Mayor, description: "Your vote counts twice.", roleExplanation: "The Mayor’s vote counts twice when voting to eliminate a player; this is done by the moderator secretly counting the Mayor’s vote twice (he’ll need to wake the Mayor up the first night to know who it is).", impact: 2, priority: 124, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)


let MINION = Role(name: "Minion", type: .Minion, description: "You know who the werewolves are, but you do not wake up with them at night.", roleExplanation: "The Player learns who the werewolves are, but does not wake with them at night. The Seer sees the Minion as a villager.", impact: -6, priority: 40, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)



let SEER = Role(name: "Seer", type: .Seer, description: "Each night choose a player to learn if he is a Villager or a Werewolf.", roleExplanation: "Each night, the Seer points at a player, and the Moderator shows her a “V” for Villager or “W” for Werewolf. To be extra clear that the Seer knows that a targeted player is a Werewolf, the Moderator may use another indicator (such as a thumbs up and thumbs down).", impact: 4, priority: 181, powerChoice: false, team: [.TeamVillage], availableEffects: [.Protection], image: #imageLiteral(resourceName: "seer"), isNightActiveRole: .NightActiveRole)



let THING = Role(name: "The Thing", type: .TheThing, description: "Each night, tap a player sitting immediately next to you.", roleExplanation: "The Thing (that goes bump in the night) awakes each night and must tap one of the players next to him. He may tap a player he’s already tapped, or pick a different player each night (as long as that player is next to him). If the player next to the Thing is eliminated, the Thing may tap the next player over. But each night, he must tap one of his neighbours (even if his original neighbours are eliminated).\n\nThe good “thing” about the Thing is that if he is sitting next to players on the village team, they know they can trust him. However, if he is sitting next to even one Werewolf, it’s probably in the werewolves’ best interest to kill him off quickly, because otherwise he’ll be compelled to “defend” the Thing during the day in order not to raise suspicion upon himself.\n\nNo other players may tap or touch anyone else during the Thing’s 'awakening' or at any other time during the night.", impact: 3, priority: 157, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NightActiveRole)



let VILLAGER_ONE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 250, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_TWO = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 251, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_THREE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 252, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FOUR = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 253, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FIVE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 254, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_SIX = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 255, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_SEVEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 256, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_EIGHT = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 257, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_NINE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 258, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_TEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 259, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_ELEVEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 260, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_TWELVE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 261, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_THIRTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 262, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FOURTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 263, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")

let VILLAGER_FIFTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.", impact: 3, priority: 264, powerChoice: false, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole, notes: "This role doesn't usually wake at night. Tonight, however, ask Villagers to raise their hands (while keeping eyes closed), so you may assign roles to players.")



let WEREWOLF_ONE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_TWO = Role(name: "Werewolf", type: .Werewolf,description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_THREE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_FOUR = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_FIVE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_SIX = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_SEVEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_EIGHT = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_NINE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_TEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_ELEVEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_TWELVE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: -6, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)



let WOLFMAN = Role(name: "Wolf Man", type: .WolfMan, description: "Each night, wake with the other Werewolves. The Seer sees you as a Villager.", roleExplanation: "The Wolf Man is a Werewolf but the Seer sees him as a Villager. The Wolf Man is a very powerful Werewolf team role.", impact: -9, priority: 13, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

// MARK: - Team roles

let WEREWOLF_TEAM = Role(name: "The Werewolves", type: .Werewolf, description: "All werewolves wake up and choose a player to eliminate.", roleExplanation: "The Werewolf team members learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.", impact: 0, priority: 25, powerChoice: false, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)
