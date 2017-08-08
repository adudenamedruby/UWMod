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
        
        outlineView.layer.cornerRadius = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor = STYLE.Grey
        mainCardView.layer.cornerRadius = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Grey
        
        let headerTitle = "The Graveyard"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                      withColour: STYLE.Red)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        self.playerLabel.text = deadPlayers
    }
    
}
