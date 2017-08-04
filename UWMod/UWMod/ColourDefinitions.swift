//
//  ColourDefinitions.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-30.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIColor {
    struct WerewolfTheme {
        static let LightTan = UIColor(netHex: 0xEAE3D6)
        static let DarkTan = UIColor(netHex: 0xB7A588)
        static let ChocolateBrown = UIColor(netHex: 0x4F4235)
        static let BloodRed = UIColor(netHex: 0x9E1422)
        static let TurqoiseGreen = UIColor(netHex: 0x21B6A8)
        static let MutedGreen = UIColor(netHex: 0x177F75)
        static let VillageBlue = UIColor(netHex: 0x3B6D93)
        static let ZombieBlue = UIColor(netHex: 0x75DBCD)
        static let BogeymanBrown = UIColor(netHex: 0x1E1B06)
        static let CountDraculaPurple = UIColor(netHex: 0x440381)
        static let VampirePurple = UIColor(netHex: 0x420129)
        static let HoodlumBrown = UIColor(netHex: 0x8C271E)
        static let TannerBrown = UIColor(netHex: 0x704E2E)
        static let BlobGreen = UIColor(netHex: 0x5FAD41)
        static let ChupacabraBrown = UIColor(netHex: 0x2D170E)
    }
}
