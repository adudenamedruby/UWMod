//
//  RoleSelectionCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-30.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class RoleSelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageBackgroundViewTop: UIView!
    @IBOutlet weak var imageBackgroundView: UIView!
    
    @IBOutlet weak var roleImage: UIImageView!
    @IBOutlet weak var firstLetter: UILabel!
    @IBOutlet weak var remainingCharacters: UILabel!
    
    
    func configureCell() {
        borderView.layer.cornerRadius = 10
        mainView.layer.cornerRadius = 10
        imageBackgroundViewTop.layer.cornerRadius = 10
    }
}
