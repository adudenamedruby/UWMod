//
//  Enumerators.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-05.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

enum UWTeam: String {
    case TeamWerewolf       = "Werewolf"
    case TeamVillage        = "Village"
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
}
