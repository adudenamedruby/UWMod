//
//  PriestView.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-17.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class PriestView: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:              UIView!
    @IBOutlet weak var protectButton:       PMSuperButton!
    
    
    // MARK: - Variables
    
    // passed variables
    weak var delegate:                      UpdateCardDelegate?
    var currentPlayer:                      Player?
    // assigned variables
    var chosenPlayer:                       Player!
    var playersAvailableForProtection:      [Player]!
    
    
    // MARK: - Initializers
    
    init(frame: CGRect, withPlayer player: Player) {
        super.init(frame: frame)
        self.currentPlayer = player
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        Bundle.main.loadNibNamed("PriestView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = self.bounds
        contentView.autoresizingMask    = [.flexibleHeight, .flexibleWidth]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(protectionSuccessful),
                                               name: NSNotification.Name(rawValue: PriestProtectSuccessNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(protectionFailure),
                                               name: NSNotification.Name(rawValue: PriestProtectFailureNotification),
                                               object: nil)
        
        contentView.backgroundColor     = STYLE.Tan
        
    }
    
    @IBAction func protectButtonTapped(_ sender: Any) {
        protectButton.isHidden          = true
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Player to Protect"
        selectPlayer.reason = .PriestSelectProtectee
        selectPlayer.activePlayer = currentPlayer
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(selectPlayer, animated: true, completion: nil)
        
    }
    
    func protectionFailure() {
        protectButton.isHidden = false
    }
    
    func protectionSuccessful() {
        delegate?.updateCard()
    }

}
