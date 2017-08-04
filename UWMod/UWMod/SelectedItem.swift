//
//  SelectedItem.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-03.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

// This item handles selecting players and roles in order to keep track of selections.
// It's being used because UITableView and UICollectionView do not keep out of view
// cells in memory and thus their contents cannot be accessed. :( :)

class SelectedPlayer {
    
    let name: String
    let index: Int
    
    init(index: Int, name: String) {
        self.name = name
        self.index = index
    }
}

class SelectedRole {
    
    let index: Int
    let role: Role
    
    init(index: Int, role: Role) {
        self.index = index
        self.role = role
    }
}
