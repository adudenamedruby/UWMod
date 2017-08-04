//
//  RegularTextLabels.swift
//  UWMod
//
//  Created by roux buciu on 2017-08-01.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class RegTan: UILabel {

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
        self.font = STYLE.RegStandardFont
    }

}

class RegBrown: UILabel {
    
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
        self.font = STYLE.RegStandardFont
    }
    
}

class RegRed: UILabel {
    
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
        self.font = STYLE.RegStandardFont
    }
    
}

class RegTanLarge: UILabel {
    
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
        self.font = STYLE.RegLargeFont
    }
    
}

class RegBrownLarge: UILabel {
    
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
        self.font = STYLE.RegLargeFont
    }
    
}

class RegRedLarge: UILabel {
    
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
        self.font = STYLE.RegLargeFont
    }
    
}

class RegRedHeader: UILabel {
    
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
        self.font = STYLE.RegBoldHeaderFont
    }
    
}

class RegTanHeader: UILabel {
    
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
        self.font = STYLE.RegStandardFont
    }
    
}

class RegBrownHeader: UILabel {
    
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
        self.font = STYLE.RegStandardFont
    }
    
}



