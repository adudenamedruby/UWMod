//
//  Constants.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit


// Defire all the different style things required thourghout the app for later QoL
struct StyleConstants {
    
    let CornerRadius            = CGFloat(15)
    let InfoCardCornerRadius    = CGFloat(5)
    
    let Brown               = UIColor.WerewolfTheme.ChocolateBrown
    let Tan                 = UIColor.WerewolfTheme.LightTan
    let Beige               = UIColor.WerewolfTheme.DarkTan
    let Red                 = UIColor.WerewolfTheme.BloodRed
    let Turqoise            = UIColor.WerewolfTheme.TurqoiseGreen
    let Green               = UIColor.WerewolfTheme.MutedGreen
    let Grey                = UIColor.darkGray
    let VillageBlue         = UIColor.WerewolfTheme.VillageBlue
    let ZombieBlue          = UIColor.WerewolfTheme.ZombieBlue
    let BogeyManBrown       = UIColor.WerewolfTheme.BogeymanBrown
    let CountDPurple        = UIColor.WerewolfTheme.CountDraculaPurple
    let VampirePurple       = UIColor.WerewolfTheme.VampirePurple
    let HoodlumBrown        = UIColor.WerewolfTheme.HoodlumBrown
    let TannerBrown         = UIColor.WerewolfTheme.TannerBrown
    let BlobGreen           = UIColor.WerewolfTheme.BlobGreen
    let ChupacabraBrown     = UIColor.WerewolfTheme.ChupacabraBrown
    
    let OldMenuTopFont      = UIFont(name: "OldWiseSketch", size: 60) // for menu title
    let OldMenuBottomFont   = UIFont(name: "OldWiseSketch", size: 70) // for menu title
    let OldStandardFont     = UIFont(name: "EnchantedLand", size: 50) // used throughout the app
    let OldRoleFont         = UIFont(name: "OldWiseSketch", size: 50) // used for nightPhase card titles
    
    let RegSmallFont        = UIFont(name: "CaviarDreams", size: 13)
    let RegMedFont          = UIFont(name: "CaviarDreams", size: 14)
    let RegFlavourFont      = UIFont(name: "CaviarDreams-Italic", size: 14)
    let RegStandardFont     = UIFont(name: "CaviarDreams", size: 15)
    let RegLargeFont        = UIFont(name: "CaviarDreams", size: 18)
    let RegBoldSmallFont    = UIFont(name: "CaviarDreams-Bold", size: 13)
    let RegBoldTableView    = UIFont(name: "CaviarDreams-Bold", size: 15)
    let RegBoldFont         = UIFont(name: "CaviarDreams-Bold", size: 16)
    let RegBoldHeaderFont   = UIFont(name: "CaviarDreams-Bold", size: 20)
    let RegBoldSettingsFont = UIFont(name: "CaviarDreams-Bold", size: 25)

}


// Global Variables
let PLAYERS                 = "UserPlayers"
let STYLE                   = StyleConstants()
var GAME: Game              = Game(availableRoster: [], availablePlayers: [])
var SETTINGS: GameSettings  = GameSettings()




// Notification Variables
let localizedActionFinishedNotification = "localizedActionFinishedNotification"
let NoNightActorsRemainNotification = "noNightActorsRemainNotification"

let ReloadTableForNewPlayersNotification            = "reloadTableForNewPlayersNotification"
let ReturnToPlayerSelectNotification                = "returnToPlayerSelectNotification"
let EliminationByWerewolfFailureNotification        = "eliminationByWerewolfFailureNotification"
let EliminationByWerewolfSuccessNotification        = "eliminationByWerewolfSuccessNotification"
let AssignPlayerSuccessNotification                 = "assignPlayerSuccessNotification"
let AssignPlayerFailureNotification                 = "assignPlayerFailureNotification"
let BodyguardProtectingSuccessNotification          = "bodyguardProtectingSuccessNotification"
let BodyguardProtectingFailureNotification          = "bodyguardProtectingFailureNotification"
let ZombieLobotomySuccessNotification               = "zombieLobotomySuccessNotification"
let ZombieLobotomyFailureNotification               = "zombieLobotomyFailureNotification"
let BlobAbsorbtionSuccessNotification               = "blobAbsorbtionSuccessNotification"
let BlobAbsorbtionFailureNotification               = "blobAbsorbtionFailureNotification"
let JoinCultFailureNotification                     = "joinCultFailureNotification"
let JoinCultSuccessNotification                     = "joinCultSuccessNotification"
let PriestProtectSuccessNotification                = "priestProtectSuccessNotification"
let PriestProtectFailureNotification                = "priestProtectFailureNotification"
let CupidLovestrikeFirstSuccessNotification         = "cupidLovestrikeFirstSuccessNotification"
let CupidLovestrikeSecondSuccessNotification        = "cupidLovestrikeSecondSuccessNotification"
let CupidLovestrikeFailureNotification              = "cupidLovestrikeFailureNotification"
let SpellcasterSilenceSuccessNotification           = "spellcasterSilenceSuccessNotification"
let SpellcasterSilenceFailureNotification           = "spellcasterSilenceFailureNotification"
let VirginiaIntimidationSuccessNotification         = "virginiaIntimidationSuccessNotification"
let VirginiaIntimidationFailureNotification         = "virginiaIntididationFailureNotification"
let TroublemakerDelinquencySuccessNotification      = "troublemakerDelinquencySuccessNotification"
let TroublemakerDelinquencyFailureNotification      = "troublemakerDelinquencyFailureNotification"
let WitchActionSuccessNotification                  = "witchActionSuccessNotification"
let WitchActionFailureNotification                  = "witchActionFailureNotification"
