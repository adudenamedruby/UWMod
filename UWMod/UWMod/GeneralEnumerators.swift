//
//  Enumerators.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-05.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation


// Different enumerators that will be used throughout the app. Good to have them in one
// spot for ease of access.
enum UWTeam: String {
    case TeamWerewolf       = "Werewolf"
    case TeamVillage        = "Villager"
    case TeamCult           = "The Cult"
    case TeamBlob           = "The Blob"
    case TeamChupacabra     = "Chupacabra"
    case TeamCountDracula   = "Dracula"
    case TeamHoodlum        = "Hoodlum"
    case TeamTanner         = "Tanner"
    case TeamVamprie        = "Vampire"
    case TeamZombie         = "Zombie"
    case TeamBoegyman       = "Boegyman"
    case TeamLovebirds      = "Lovebirds"
}


enum UWNights: Int {
    case Never              = -1
    case EveryNight         = 0
    case First              = 1
    case Second
    case Third
}


enum DaytimeCardType {
    // Team based cards
    case GeneralInfoCard
    case BlobTeamCard
    case GhostTeamCard
    case BoegymanTeamCard
    case ChupacabraTeamCard
    case CountDraculaTeamCard
    case CultTeamCard
    case HoodlumTeamCard
    case TannerTeamCard
    case VampireTeamCard
    case VillageTeamCard
    case WerewolfTeamCard
    case ZombieTeamCard
    case LovebirdTeamCard
    case GraveyardCard
    
    // Indivitual cards - cards like the Witch who has protected AND poisoned someone.
    case WitchCard
    case TeenageWerewolfCard
}

// To be added as time goes by.
enum PlayerEffects {
    case Protection
    case Hypnosis
    case Silence
    case Ostracism
    case Lobotomy           // zombie
    case Lovestruck         // cupid
}


enum PlayersToTrack {
    case Single
    case Many
    case AffectingList
    case IneligibilityList
}
