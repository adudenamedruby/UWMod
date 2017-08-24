//
//  Roles.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

enum RoleType: String {
    
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
    case Martyr
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
    case Vampire
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

enum NightActiveStatus {
    case NightActiveRole
    case NotNightActiveRole
    case Conditional
    
    var currentStatus: Bool {
        switch self {
        case .NightActiveRole:
            return true
        case .NotNightActiveRole:
            return false
        case .Conditional:
            return true
        }
    }
}

class Role {
    let name:                       String
    let type:                       RoleType
    let description:                String
    let roleExplanation:            String
    var notes:                      String
    let impact:                     Int
    let priority:                   Int
    let team:                       [UWTeam]
    let image:                      UIImage
    
    // this should change the priority of special roles depending on game settings
    // for example, Lone Wolf would have this set to false by default so it's an auto
    // assigned role. However, if set to manually assigned, its priority variable would be
    // a custom getter that returns a priority on whether a role is called or not.
    var isManuallyAssigned:         Bool
    var availableEffects:           [PlayerEffects]
    var powerChoice:                Bool
    var powerUsed:                  Bool
    var isNightActiveRole:          NightActiveStatus
    var isActivated:                Bool
    
    init(name: String, type: RoleType, description: String, roleExplanation: String, impact: Int, priority: Int, powerChoice: Bool, team: [UWTeam], availableEffects: [PlayerEffects], image: UIImage, isNightActiveRole: NightActiveStatus, notes: String = "") {
        self.name                   = name
        self.type                   = type
        self.description            = description
        self.roleExplanation        = roleExplanation
        self.notes                  = notes
        self.impact                 = impact
        self.priority               = priority
        self.image                  = image
        
        self.availableEffects       = availableEffects
        self.isManuallyAssigned     = true
        self.team                   = team
        self.powerChoice            = powerChoice
        self.powerUsed              = false
        self.isNightActiveRole      = isNightActiveRole
        self.isActivated            = true
    }
    
    func checkForActivation() {
        // All base roles are activated by default and do not change
    }
}

























