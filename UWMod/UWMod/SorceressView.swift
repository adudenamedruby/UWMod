//
//  SorceressView.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-14.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class SorceressView: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:              UIView!
    @IBOutlet weak var nameLabel:           RegBrown!
    
    // MARK: - Variables
    
    // passed variables
    var theSeer:                            Player?
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        Bundle.main.loadNibNamed("SorceressView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = self.bounds
        contentView.autoresizingMask    = [.flexibleHeight, .flexibleWidth]
        contentView.backgroundColor     = STYLE.Tan
        
        for player in GAME.availablePlayers {
            if player.role != nil {
                if player.roleType == .Seer {
                    theSeer = player
                    break
                }
            }
        }
        
        if theSeer != nil {
            if (theSeer?.isAlive)! {
                nameLabel.text          = "\(theSeer!.name) is the Seer."
            } else {
                nameLabel.text          = "The Seer has died."
            }
        } else {
            nameLabel.text              = "There is no Seer in this game."
        }
        
    }

}
