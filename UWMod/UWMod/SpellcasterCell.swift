//
//  SpellcasterCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-18.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class SpellcasterCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var outlineView:                  UIView!
    @IBOutlet var mainCardView:                 UIView!
    @IBOutlet var headerView:                   UIView!
    @IBOutlet weak var headerTitleLabel:        RegTanHeader!
    
    @IBOutlet weak var spellcasterLabel:              RegBrown!
    @IBOutlet var silencedPlayerLabel:               RegBrown!
    
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius          = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor             = STYLE.VillageBlue
        headerView.backgroundColor              = STYLE.VillageBlue
        mainCardView.layer.cornerRadius         = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor            = STYLE.Tan
        
        let headerTitle                         = "Aura of Silence"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                      withColour: STYLE.Red)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        
        var spellcasterPlayer:          Player!
        let silencedPlayer              = GAME.fetchPlayersAffectedByEffect(fromList: GAME.livingActors,
                                                                            affectedBy: .Silence, withRole: true)
        
        for player in GAME.availablePlayers {
            if player.roleType == .Spellcaster {
                spellcasterPlayer = player
            }
        }
        
        
        
        self.spellcasterLabel.text      = "\(spellcasterPlayer.name) has cast a spell on:"
        self.silencedPlayerLabel.text   = "\(silencedPlayer)"
    }
    
}
