//
//  JoinCultCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-14.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class JoinCultCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var outlineView:              UIView!
    @IBOutlet var mainCardView:             UIView!
    @IBOutlet var headerView:               UIView!
    @IBOutlet weak var headerTitleLabel:    RegTanHeader!
    
    
    @IBOutlet weak var cultLeaderLabel:     RegBrown!
    @IBOutlet var playerLabel:              RegBrown!
    @IBOutlet weak var playerTotalsLabel:   RegTanHeaderSmall!
    @IBOutlet weak var teamTotalLabel:      RegTanHeader!
    
    
    // MARK: - Variables
    
    var cultLeader:                         Player!
    var cultMembers:                        String!
    
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius      = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor         = STYLE.Green
        headerView.backgroundColor          = STYLE.Green
        mainCardView.layer.cornerRadius     = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor        = STYLE.Tan

        let headerTitle                     = "The Order of Chorazos"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                      withColour: STYLE.Red)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        let leaderStatus                        = cultLeader.isAlive ? "(currently alive)" : "(dead)"
        self.cultLeaderLabel.text               = "Cult Leader: \(cultLeader.name) \(leaderStatus)"
        
        let playerInfo                          = GAME.retrieveTeamVSTotalNumbers(team: .TeamCult)
        let totalPlayers                        = playerInfo.total
        let teamTotal                           = playerInfo.team
        
        self.teamTotalLabel.text                = "\(teamTotal)"
        self.playerTotalsLabel.text             = "/\(totalPlayers)"
        self.playerLabel.text                   = cultMembers
    }
    
}
