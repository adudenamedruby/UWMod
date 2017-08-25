//
//  VirginiaTeamCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class VirginiaTeamCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var outlineView:                  UIView!
    @IBOutlet var mainCardView:                 UIView!
    @IBOutlet var headerView:                   UIView!
    @IBOutlet weak var headerTitleLabel:        RegTanHeader!
    
    @IBOutlet weak var dependentLabel:          RegBrown!
    
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius          = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor             = STYLE.VillageBlue
        headerView.backgroundColor              = STYLE.VillageBlue
        mainCardView.layer.cornerRadius         = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor            = STYLE.Tan
        
        let headerTitle                         = "The Charity Center"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                      withColour: STYLE.Red)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        
        var virginia:        Player?
        var dependent:       Player?
        
        for player in GAME.livingActors {
            if player.roleType == .VirginiaWoolf {
                virginia = player
            }
            
            if player.isAffectedBy(condition: .Dependent) {
                dependent = player
            }
        }
        
        if dependent != nil {
            self.dependentLabel.text = "\(dependent!.name) is depending, hand and foot, on \(virginia!.name) for their survivial.\n"
        }
    }
}
