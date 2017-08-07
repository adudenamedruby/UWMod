//
//  Artifacts.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-26.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

// Leave alone for future updates. Currently is not going to be implemented.

enum UWEffectType: String {
    case Ongoing                = "Ongoing"
    case SingeUse               = "Single use"
}

class Artifact {
    let name:                   String
    let description:            String
    let effectType:             UWEffectType
    var effectUsed:             Bool?
    
    init(name: String, description: String, effectType: UWEffectType, effectUsed:Bool?) {
        self.name               = name
        self.description        = description
        self.effectType         = effectType
        self.effectUsed         = effectUsed ?? false
    }
}
