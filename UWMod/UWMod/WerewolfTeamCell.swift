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
    
    @IBOutlet var outlineView: UIView!
    @IBOutlet var mainCardView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: RegTanHeader!
    
    @IBOutlet var playerLabel: RegRed!
    
    
    // MARK: - Variables
    
    var werewolfTeamPlayers: String!
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius = STYLE.CornerRadius
        outlineView.backgroundColor = STYLE.Red
        headerView.backgroundColor = STYLE.Red
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        
        let headerTitle = "WerewolfTeam"
        headerTitleLabel.attributedText = headerTitle.colourFirstCharacter(withStringFont: STYLE.RegStandardFont!, withColour: STYLE.Brown)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        self.playerLabel.text = werewolfTeamPlayers
    }
    
}
