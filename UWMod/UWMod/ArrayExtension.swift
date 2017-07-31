//
//  ArrayExtension.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-30.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

extension Array {
    
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
