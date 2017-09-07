//
//  ZombieCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-11.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class ZombieCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var outlineView:              UIView!
    @IBOutlet var mainCardView:             UIView!
    @IBOutlet var headerView:               UIView!
    @IBOutlet weak var headerTitleLabel:    RegTanHeader!
    @IBOutlet weak var teamPlayerLabel:     RegTanHeader!
    @IBOutlet weak var playerTotalsLabel:   RegTanHeaderSmall!
    
    @IBOutlet var playerLabel:              RegBrown!
    
    
    // MARK: - Variables
    
    var playersAffectedByZombie: String!
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor = STYLE.ZombieBlue
        headerView.backgroundColor = STYLE.ZombieBlue
        mainCardView.layer.cornerRadius = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        
        let headerTitle = "The Walking Dead"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                      withColour: STYLE.Brown)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        let playerInfo                          = GAME.retrieveTeamVSTotalNumbers(team: .TeamZombie)
        let totalPlayers                        = playerInfo.total
        let teamTotal                           = playerInfo.team
        
        self.teamPlayerLabel.text = "\(teamTotal)"
        self.playerTotalsLabel.text = "/\(totalPlayers)"
        
        
        var zombiePlayer: Player!
        
        for player in GAME.livingActors {
            if player.roleType == .Zombie {
                zombiePlayer = player
            }
        }
        
        var concatenatedString = ""
        
        if playersAffectedByZombie != "" {
            concatenatedString = "\(zombiePlayer.name) has eaten the following people's brains (and they cannot vote):\n\n" + playersAffectedByZombie
        } else {
            concatenatedString = "\(zombiePlayer.name) has not yet eaten brains!"
        }
        
        self.playerLabel.text = concatenatedString
    }
    
}
