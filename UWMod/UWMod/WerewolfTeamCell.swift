//
//  WerewolfTeamCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-04.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class WerewolfTeamCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var outlineView:                  UIView!
    @IBOutlet var mainCardView:                 UIView!
    @IBOutlet var headerView:                   UIView!
    @IBOutlet weak var headerTitleLabel:        RegTanHeader!
    
    @IBOutlet var playerLabel:                  RegRed!
    @IBOutlet weak var playerTotalsLabel:       RegTanHeaderSmall!
    @IBOutlet weak var teamTotalLabel:          RegTanHeader!
    
    
    // MARK: - Variables
    
    var werewolfTeamPlayers: String!
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius          = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor             = STYLE.Red
        headerView.backgroundColor              = STYLE.Red
        mainCardView.layer.cornerRadius         = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor            = STYLE.Tan
        
        let headerTitle = "The Werewolf Pack"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                      withColour: STYLE.Brown)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        
        let playerInfo                          = GAME.retrieveTeamVSTotalNumbers(team: .TeamWerewolf)
        let totalPlayers                        = playerInfo.total
        let teamTotal                           = playerInfo.team
        
        self.teamTotalLabel.text    = "\(teamTotal)"
        self.playerTotalsLabel.text = "/\(totalPlayers)"
        self.playerLabel.text = werewolfTeamPlayers
    }
    
}
