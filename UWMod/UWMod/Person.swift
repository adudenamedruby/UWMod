//
//  Person.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-19.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding {

    private var _firstName:                 String
    private var _lastName:                  String
    private var _personID:                  String
    
    var firstName: String {
        get { return _firstName }
    }
    
    var lastName: String {
        get { return _lastName }
    }
    
    var personID: String {
        get { return _personID }
    }
    
    init(firstName: String, lastName: String) {
        self._firstName             = firstName
        self._lastName              = lastName
        self._personID              = ""
        
        super.init()
        self.generateRandomID(length: 64)
    }
    
    
    // MARK: - Encoding/Decoding
    
    required init(coder aDecoder: NSCoder) {
        
        self._firstName             = aDecoder.decodeObject(forKey: "first") as! String
        self._lastName              = aDecoder.decodeObject(forKey: "last") as! String
        self._personID              = aDecoder.decodeObject(forKey: "id") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self._firstName, forKey: "first")
        aCoder.encode(self._lastName, forKey: "last")
        aCoder.encode(self._personID, forKey: "id")
    }
    
    private func generateRandomID(length: Int) {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*(){}:;-=+/?"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
    
        _personID = randomString
    }
}
