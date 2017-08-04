//
//  Constants.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

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
}

enum UWNights {
    case Never
    case EveryNight
    case First
    case Second
    case Third
}

struct StyleConstants {
    
    let CornerRadius = CGFloat(15)
    
    let Brown = UIColor.WerewolfTheme.ChocolateBrown
    let Tan = UIColor.WerewolfTheme.LightTan
    let Beige = UIColor.WerewolfTheme.DarkTan
    let Red = UIColor.WerewolfTheme.BloodRed
    let Turqoise = UIColor.WerewolfTheme.TurqoiseGreen
    let Green = UIColor.WerewolfTheme.MutedGreen
    let Grey = UIColor.darkGray
    
    let OldStandardFont = UIFont(name: "OldWiseSketch", size: 35)
    let OldFirstLetterFont = UIFont(name: "OldWiseSketch", size: 38)
    let OldMenuTopFont = UIFont(name: "OldWiseSketch", size: 60)
    let OldMenuBottomFont = UIFont(name: "OldWiseSketch", size: 70)
    let OldRoleFont = UIFont(name: "OldWiseSketch", size: 50)
    let OldRoleFirstFont = UIFont(name: "OldWiseSketch", size: 55)
    let RegStandardFont = UIFont(name: "AmericanTypewriter", size: 15)
    let RegSmallFont = UIFont(name: "AmericanTypewriter", size: 13)
    let RegBoldFont = UIFont(name: "AmericanTypewriter-Bold", size: 16)
    let RegBoldHeaderFont = UIFont(name: "AmericanTypewriter-Bold", size: 19)
    let RegLargeFont = UIFont(name: "AmericanTypewriter", size: 18)
}


// Global Variables
let localizedActionFinishedNotification = "localizedActionFinishedNotification"
let PLAYERS = "UserPlayers"
let STYLE = StyleConstants()
var GAME: Game = Game(availableRoster: [], availablePlayers: [])

let ROLE_TO_DAYINFO: [RoleType:DaytimeInfoCard] = [.Werewolf:.WerewolfTeam]


