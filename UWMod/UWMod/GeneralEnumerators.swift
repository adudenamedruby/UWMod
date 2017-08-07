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
}


enum UWNights {
    case Never
    case EveryNight
    case First
    case Second
    case Third
}


enum DaytimeCardType {
    // Team based cards
    case GeneralInfoCard
    case BlobTeamCard
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
    case GraveyardCard
    
    // Indivitual cards - cards like the Witch who has protected AND poisoned someone.
    case WitchCard
}

// To be added as time goes by.
enum PlayerEffects {
    case Protection
    case Hypnosis
    case Silence
    case Ostracism
    case Lobotoby           // zombie
}


enum PlayersToTrack {
    case Single
    case Many
    case AffectingList
    case IneligibilityList
}
