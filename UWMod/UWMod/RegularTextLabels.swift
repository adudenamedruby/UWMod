//
//  RegularTextLabels.swift
//  UWMod
//
//  Created by roux buciu on 2017-08-01.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class RegularTextTanLabel: UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        self.textColor = STYLE.Tan
    }

}

class RegularTextBrownLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        self.textColor = STYLE.Brown
    }
    
}

class RegularTextRedLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        self.textColor = STYLE.Red
    }
    
}

