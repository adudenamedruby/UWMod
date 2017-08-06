//
//  VillageTeamCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-04.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class VillageTeamCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var outlineView: UIView!
    @IBOutlet var mainCardView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: RegTanHeader!
    
    @IBOutlet var playerLabel: RegRed!
    
    
    // MARK: - Variables
    
    var villageTeamPlayers: String!
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius = STYLE.CornerRadius
        outlineView.backgroundColor = STYLE.VillageBlue
        headerView.backgroundColor = STYLE.VillageBlue
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        
        let headerTitle = "Village Team"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldFont!, withColour: STYLE.Red)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        self.playerLabel.text = villageTeamPlayers
    }
    
}
