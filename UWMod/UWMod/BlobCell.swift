//
//  BlobCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-13.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class BlobCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var outlineView:              UIView!
    @IBOutlet var mainCardView:             UIView!
    @IBOutlet var headerView:               UIView!
    @IBOutlet weak var headerTitleLabel:    RegTanHeader!
    
    
    @IBOutlet weak var originalBlobLabel:   RegBrown!
    @IBOutlet var playerLabel:              RegBrown!
    @IBOutlet weak var playerTotalsLabel:   RegTanHeader!
    @IBOutlet weak var teamTotalLabel:      RegTanHeader!
    
    
    // MARK: - Variables
    
    var originalBlob:                       Player!
    var blobTeamMembers:                    String!
    
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius      = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor         = STYLE.BlobGreen
        headerView.backgroundColor          = STYLE.BlobGreen
        mainCardView.layer.cornerRadius     = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor        = STYLE.Tan
        
        let headerTitle                     = "The Blob"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                      withColour: STYLE.Red)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        self.originalBlobLabel.text             = "Original Blob: \(originalBlob.name)"
        
        let playerInfo                          = GAME.retrieveTeamVSTotalNumbers(team: .TeamBlob)
        let totalPlayers                        = playerInfo.total
        let teamTotal                           = playerInfo.team
        
        self.teamTotalLabel.text                = "\(teamTotal)"
        self.playerTotalsLabel.text             = "/\(totalPlayers)"
        self.playerLabel.text                   = blobTeamMembers
    }
}
