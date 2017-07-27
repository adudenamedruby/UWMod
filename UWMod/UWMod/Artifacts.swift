//
//  Artifacts.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-26.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

struct EffectType {
    static let ongoingEffect = "Ongoing"
    static let oneTimeEffect = "Single use"
}

class Artifact {
    let name: String
    let description: String
    let effectType: String
    var effectUsed: Bool?
    
    init(name: String, description: String, effectType: String, effectUsed:Bool?) {
        self.name = name
        self.description = description
        self.effectType = effectType
        self.effectUsed = effectUsed ?? false
    }
}
