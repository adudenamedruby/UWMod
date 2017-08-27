//
//  StringExtensions.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    // Format strings for title - split strings into first letter and the rest of
    // the letters
    func firstLetter() -> String {
        let index = self.index(self.startIndex, offsetBy: 0)
        
        return String(self[index])
    }
    
    func restOfString() -> String {
        let index = self.index(self.startIndex, offsetBy: 1)
        
        return self.substring(from: index)
    }
    
    /// Takes a string and returns an attributed string with a coloured first letter.
    func styleTitleLabel(withStringFont font: UIFont, withColour colour: UIColor) -> NSAttributedString  {
        let attributedText = NSMutableAttributedString(string: self,
                                                       attributes: [NSFontAttributeName:font])
        attributedText.addAttribute(NSForegroundColorAttributeName,
                                    value: colour,
                                    range: NSRange(location:0,length:1))
        
        return attributedText
    }
    
    /// Takes a string and converts anything between [ and ] into italicized text.
    func styleFlavourText() -> NSAttributedString  {
        
        let sIndex          = self.characters.index(of: "[")
        let eIndex          = self.characters.index(of: "]")
        let startIndx       = self.distance(from: self.startIndex, to: sIndex!) + 1
        let distance        = self.distance(from: sIndex!, to: eIndex!) - 1
        
        let attributedText = NSMutableAttributedString(string: self,
                                                       attributes: [NSFontAttributeName:STYLE.RegSmallFont!])
        attributedText.addAttribute(NSFontAttributeName,
                                    value: STYLE.RegFlavourFont!,
                                    range: NSRange(location:startIndx, length:distance))
        
        return attributedText
    }
    
    subscript (i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

