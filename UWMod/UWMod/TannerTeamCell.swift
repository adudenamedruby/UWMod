//
//  TannerTeamCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class TannerTeamCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var outlineView:                  UIView!
    @IBOutlet var mainCardView:                 UIView!
    @IBOutlet var headerView:                   UIView!
    @IBOutlet weak var headerTitleLabel:        RegTanHeader!
    
    @IBOutlet weak var tannerLabel:             RegBrown!
    @IBOutlet weak var playerCountLabel:        RegTanHeaderSmall!
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius          = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor             = STYLE.TannerBrown
        headerView.backgroundColor              = STYLE.TannerBrown
        mainCardView.layer.cornerRadius         = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor            = STYLE.Tan
        
        let headerTitle                         = "The Tanner"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                      withColour: STYLE.Red)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        
        var tanner:        Player!
        
        for player in GAME.availablePlayers {
            if player.roleType == .Tanner {
                tanner = player
            }
        }
        
        self.tannerLabel.text = "\(tanner.name) hates his life. A lot.\n"
        self.playerCountLabel.text = "/\(GAME.livingActors.count)"
    }
    
}
