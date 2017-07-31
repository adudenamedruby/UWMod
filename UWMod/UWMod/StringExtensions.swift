//
//  StringExtensions.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

extension String {
    
    func firstLetter() -> String {
        let index = self.index(self.startIndex, offsetBy: 0)
        
        return String(self[index])
    }
    
    func restOfString() -> String {
        let index = self.index(self.startIndex, offsetBy: 1)
        
        return self.substring(from: index)
    }
    
}
