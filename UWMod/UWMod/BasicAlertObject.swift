//
//  BasicAlertObject.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-02.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

/// A class for passing basic alert information more elegantly between views.
class BasicAlertObject {
    let title:                          String
    let text:                           String
    let buttonName:                     String
    let additionalInformation:          String
    
    init(title: String, text: String, buttonName: String = "", additionalInformation: String = "") {
        self.title                      = title
        self.text                       = text
        self.buttonName                 = buttonName
        self.additionalInformation      = additionalInformation
    }
}
