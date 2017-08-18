//
//  SweetheartCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-18.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class SweetheartCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var outlineView:                  UIView!
    @IBOutlet var mainCardView:                 UIView!
    @IBOutlet var headerView:                   UIView!
    @IBOutlet weak var headerTitleLabel:        RegTanHeader!
    
    @IBOutlet weak var cupidLabel:              RegBrown!
    @IBOutlet var lobebirdsLabel:               RegBrown!

    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius          = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor             = STYLE.VillageBlue
        headerView.backgroundColor              = STYLE.VillageBlue
        mainCardView.layer.cornerRadius         = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor            = STYLE.Tan
        
        let headerTitle                         = "The Lovebirds"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                      withColour: STYLE.Red)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        
        var cupidPlayer:        Player!
        var firstLover:         Player?
        var secondLover:        Player?
        
        for player in GAME.availablePlayers {
            if player.roleType() == .Cupid {
                cupidPlayer = player
            }
        }
        
        for player in GAME.livingActors {
            if player.isAffectedBy(condition: .Lovestruck) {
                if firstLover != nil {
                    secondLover = player
                } else {
                    firstLover = player
                }
            }
        }
        
        
        
        self.cupidLabel.text = "\(cupidPlayer.name)'s lovebirds:"
        self.lobebirdsLabel.text = "\(firstLover!.name) ❤️ \(secondLover!.name)"
    }
    
}
