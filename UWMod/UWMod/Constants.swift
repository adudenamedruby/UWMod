//
//  Constants.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation


// Global variables
var rolesInCurrentGame = [Role]()

// Roles in the game

let werewolf = Role(name: "Werewolf",
                    description: "Each night, wake with the other werewolves and choose a player to eliminate.",
                    impact: -6,
                    priority: 1,
                    groupWithLikeRoles: true,
                    powerChoice: false)

let wolfCub = Role(name: "Wolf Cub",
                   description: "Each night, wake with the other Werewolves. If you are eliminated, the Werewolves eliminate two players the following night.",
                   impact: -8,
                   priority: 1,
                   groupWithLikeRoles: true,
                   powerChoice: false)

let sorceress = Role(name: "Sorceress",
                     description: "Each night, look for the seer. You are on the werewolf team.",
                     impact: -3,
                     priority: 1,
                     groupWithLikeRoles: true,
                     powerChoice: false)

let witch = Witch(name: "Witch",
                  description: "",
                  impact: 2,
                  priority: 2,
                  groupWithLikeRoles: true,
                  powerChoice: true,
                  playerToPoison: nil,
                  playerToSave: nil)

let allRolesInGame = [werewolf, wolfCub, sorceress]

// Artifacts
