//
//  Roles.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

enum RoleType {
    
    case AnyRole
    
    case AlphaWolf
    case ApprenticeSeer
    case AuraSeer
    case Beholder
    case BigBadWolf
    case BloodyMary
    case Bodyguard
    case Bogeyman
    case Chupacabra
    case CountDracula
    case CultLeader
    case Cupid
    case Cursed
    case DireWolf
    case Diseased
    case Doppelganger
    case Dreamwolf
    case Drunk
    case FangFace
    case FrankensteinsMonster
    case FruitBrute
    case Ghost
    case Hoodlum
    case Hunter
    case Huntress
    case Insomniac
    case Leprechaun
    case LoneWolf
    case Lycan
    case MadBomber
    case Mason
    case Mayor
    case Mentalist
    case Minion
    case MysticSeer
    case Nostradamus
    case OldHag
    case ParanormalInvestigator
    case Pacifist
    case Priest
    case Prince
    case Revealer
    case Sasquatch
    case Seer
    case Sorceress
    case Spellcaster
    case Tanner
    case TeenageWerewolf
    case TheBlob
    case TheCount
    case TheMummy
    case TheThing
    case ToughGuy
    case Troublemaker
    case Vamprie
    case VillageIdiot
    case Villager
    case VirginiaWoolf
    case Werewolf
    case Witch
    case WolfCub
    case WolfMan
    case Wolverine
    case Zombie
}

class Role {
    let name: String
    let type: RoleType
    let description: String
    let roleExplanation: String
    let notes: String?
    let impact: Int
    let priority: Int
    let image: UIImage
    
    var wakeTime: [UWNights]
    var canWake: Bool
    var powerChoice: Bool
    var powerUsed: Bool
    var team: UWTeam
    var daytimeInfoCard: [DaytimeCardType]
    
    init(name: String, type: RoleType, description: String, roleExplanation: String, impact: Int, priority: Int, powerChoice: Bool, team: UWTeam, daytimeInfoCard: [DaytimeCardType], wakeTime: [UWNights], image: UIImage, notes: String = "") {
        self.name = name
        self.type = type
        self.description = description
        self.roleExplanation = roleExplanation
        self.notes = notes
        self.impact = impact
        self.priority = priority
        self.image = image
        
        self.team = team
        self.daytimeInfoCard = daytimeInfoCard
        self.wakeTime = wakeTime
        self.powerChoice = powerChoice
        self.powerUsed = false
        self.canWake = true
    }
    
    func reconcileDeath() {
        
    }
}

//class Witch: Role {
//    var playerToPoison: Player?
//    var playerToSave: Player?
//    
//    init(name: String, description: String, impact: Int, priority: Int, powerChoice: Bool, team: UWTeam, numberOfEliminations: Int, playerToPoison: Player?, playerToSave: Player?) {
//        super.init(name: name, description: description, impact: impact, priority: priority, powerChoice: powerChoice, team: team, numberOfEliminations: numberOfEliminations)
//
//        self.playerToPoison = playerToPoison
//        self.playerToSave = playerToSave
//    }
//}
