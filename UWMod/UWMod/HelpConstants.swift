//
//  HelpConstants.swift
//  UWMod
//
//  Created by roux buciu on 2017-08-03.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation


public var helpSectionsData: [Section] = [
    Section(name: "Rules", items: [
        Item(name: "How do I Play?", detail: "UWMod is NOT a standalone game or a replacement for Ultimate Werewolf. It is a tool to help moderate the wonderful boardgame Ultimate Werewolf designed by Ted Alspach. To learn to play, and, indeed, to be able to actually play the game, it is necessary to purchase Ultimate Werewolf from your friendly local board game store... or online!"),
        Item(name: "No Kill First Night", detail: "Getting a role and being eliminated right away, without getting a chance to play a single round, is no fun for anyone. For this reason, UWMod enforces a strict no kill on the first night rule."),
        Item(name: "Rule Clarifications", detail: "Some roles are straightforward, while other roles are a bit more challenging and may cause some confusion. Thankfully, UWMod includes all the role related material from the published game. If you need to clarify something, just click the question mark button on the specific role card, and you'll be presented with all the information you need."),
        Item(name: "Can I Play a Homebrew Variant?", detail: "In order to provide the highest quality app possible, UWMod sticks to the base rules of the game. This helps both players and moderators as this leads to less uncertainty about how roles work. Homebrew variants, while great to play, are currently not supported."),
        Item(name: "But, but, but.....", detail: "Here's the deal. I'm aware that there's... who knows how many different ways to play Werewolf. And many of them are really great! I've tried to design the app to be as general as possible in order to support as many styles of play as possible. For example: the lynch at the end of the day can be carried out in at least four different ways. Instead of forcing a voting system, I've allowed moderators to directly kill someone in order to account for a lynch result. Or you can end the day without a vote or kill. It's entirely up to you how you run your game. I've tried to give as much flexibility as possible, where possible.")
        ]),
    Section(name: "FAQ", items: [
        Item(name: "What order are roles presented in?", detail: "UWMod employs a priority system for the roles currently in the game. For simplicitys' sake, some roles, like the werewolves, are collapsed into one card per night, preceeded, or followed by, the appropriate separate roles."),
        Item(name: "The first night is different! What gives?!", detail: "The first night, like in most Ultimate Werewolf games, is also a lot of record-keeping for the moderator. Thus, UWMod accounts for this in order to allow for roles to be assigned, teams to be formed, etc."),
        Item(name: "I don't remember who did what!", detail: "Well that's what this tool is here for. Based on the roles available for each particular game, the app will remember and present all important information: from living/dead players and round length to keeping track of protected players, whether roles have used their powers or not, the different teams players are on (a werewolf that's also part of The Cult AND part of The Blob!), the different effects players may be under (ie. Zombie's eaten a player's brain and that player cannot vote anymore), etc.! This way you can focus on moderating well, rather than bookeeping details."),
        Item(name: "The bodyguard protected X, but I can still choose to eliminate them?!", detail: "That's intended! The game carries out phase effects at the end of each phase, in order to account for all possible permutations. Just enter all the information asked for in the app and everything will take care of itself."),
        Item(name: "What about 'special' roles?", detail: "Roles like the Lone Wolf, roles that people are unsure whether they are in the game or not, are not called. They are handled slightly differently to ensure that they remain secret but the moderator is still able to know who they are.\n\nIMPORTANT: At the moment, the app limits you to only ONE of these types of roles per game. This will be changed in an upcoming release.")
        ]),
    Section(name: "Feedback", items: [
        Item(name: "UWMod hasn't been updated in forever!", detail: "First, I should mention that while this project is very much a labour of love, it is a side-project and, as such, may only see sporadic updates. I will do my best to try and address game-breaking bugs as soon as possible; after that, as time allows, I will endeavour to introduce new features or improve the app as time goes on."),
        Item(name: "How do I get in touch?", detail: "Glad you asked! Your feedback and advice is important to me, and while I don't have the manpower to answer every question or comment - I do my best to read everything!\n\nHaving said that, if you have questions, comments, ideas, or just want to send praise/encouraging words, please send an e-mail to info@acmelabs.ca.")
        ])
]
