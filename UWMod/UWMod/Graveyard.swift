//
//  Graveyard.swift
//  UWMod
//
//  Created by roux buciu on 2017-08-04.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class Graveyard: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var outlineView: UIView!
    @IBOutlet var mainCardView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: RegTanHeader!
    
    @IBOutlet var playerLabel: RegGrey!
    
    
    // MARK: - Variables
    
    var deadPlayers: String!
    
    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius = STYLE.CornerRadius
        outlineView.backgroundColor = STYLE.Grey
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Grey
        
        let headerTitle = "The Graveyard"
        headerTitleLabel.attributedText = headerTitle.colourFirstCharacter(withStringFont: STYLE.RegBoldFont!, withColour: STYLE.Red)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        self.playerLabel.text = deadPlayers
    }
    
}
