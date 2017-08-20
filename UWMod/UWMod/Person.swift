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
    private var _number:                    Int
    
    var firstName: String {
        get { return _firstName }
    }
    
    var lastName: String {
        get { return _lastName }
    }
    
    var number: Int {
        get { return _number }
    }
    
    init(firstName: String, lastName: String, number: Int = 0) {
        self._firstName             = firstName
        self._lastName              = lastName
        self._number                = number
    }
    
    public func setNumber(to number: Int) {
        self._number                = number
    }
    
    
    // MARK: - Encoding/Decoding
    
    required init(coder aDecoder: NSCoder) {
        
        self._firstName             = aDecoder.decodeObject(forKey: "first") as! String
        self._lastName              = aDecoder.decodeObject(forKey: "last") as! String
        self._number                = aDecoder.decodeInteger(forKey: "num")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self._firstName, forKey: "first")
        aCoder.encode(self._lastName, forKey: "last")
        aCoder.encode(self._number, forKey: "num")
    }
    
    
//    func save(arr: [Person]) {
//        let data = NSKeyedArchiver.archivedData(withRootObject: arr)
//        UserDefaults.standard.set(data, forKey: "TestKey")
//    }
//    
//    func load() {
//        
//        var peoples: [Person] = []
//        if let data = UserDefaults.standard.data(forKey: "TestKey") {
//            peoples = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Person]
//        }
//    }
}
