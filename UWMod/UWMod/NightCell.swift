//
//  NightCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class NightCell: TisprCardStackViewCell {
    
    @IBOutlet weak var cardBorder: UIView!
    @IBOutlet weak var roleIconImage: UIImageView!
    @IBOutlet weak var titleFirstLetterLabel: UILabel!
    @IBOutlet weak var titleRemainingLabel: UILabel!
    @IBOutlet weak var roleDescritpionLabel: UILabel!
    
    var player: Player?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardBorder.layer.cornerRadius = 10
    }
    
    func configureCell() {
        roleIconImage.image = player?.role.image
        titleFirstLetterLabel.text = player?.role.name.firstLetter()
        titleRemainingLabel.text = player?.role.name.restOfString()
        roleDescritpionLabel.text = player?.role.description
    }
}
