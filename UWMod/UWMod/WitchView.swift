//
//  WitchView.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-27.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class WitchView: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:              UIView!
    @IBOutlet weak var protectButton:       PMSuperButton!
    @IBOutlet weak var poisonButton:        PMSuperButton!
    @IBOutlet weak var victimLabel: RegBrown!
    
    
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
        Bundle.main.loadNibNamed("WitchView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = self.bounds
        contentView.autoresizingMask    = [.flexibleHeight, .flexibleWidth]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(actionSuccess),
                                               name: NSNotification.Name(rawValue: WitchActionSuccessNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(actionFailure),
                                               name: NSNotification.Name(rawValue: WitchActionFailureNotification),
                                               object: nil)
        
        contentView.backgroundColor     = STYLE.Tan
        presentButtons()
        
    }
    
    @IBAction func protectButtonTapped(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Player to Protect"
        selectPlayer.reason = .WitchSelectProtectee
        selectPlayer.activePlayer = currentPlayer
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(selectPlayer, animated: true, completion: nil)
        
    }
    
    @IBAction func poisonButtonTapped(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Player to Poison"
        selectPlayer.reason = .WitchPoison
        selectPlayer.activePlayer = currentPlayer
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(selectPlayer, animated: true, completion: nil)
        
    }
    
    func actionFailure() {
        presentButtons()
    }
    
    func presentButtons() {
        
        if currentPlayer?.playersIneligibleForEffect[.Protection] == nil {
            protectButton.alpha         = 1
            protectButton.isEnabled     = true
            presentVictim()
            
        } else {
            protectButton.alpha         = 0.5
            protectButton.isEnabled     = false
        }
        
        if currentPlayer?.playersIneligibleForEffect[.Poison] == nil {
            poisonButton.alpha         = 1
            poisonButton.isEnabled     = true
            
        } else {
            poisonButton.alpha         = 0.5
            poisonButton.isEnabled     = false
        }
    }
    
    func presentVictim() {
        var victimPresented             = false
        
        if GAME.playersToBeEliminated.count > 0 {
            for player in GAME.playersToBeEliminated {
                if player.killedBy == .Werewolf {
                    victimLabel.text    = "Werewolf target: \(player.name)"
                    victimPresented     = true
                    break
                }
            }
        }
        
        if !victimPresented {
            victimLabel.text            = ""
        }
    }
    
    func actionSuccess() {
        delegate?.updateCard()
    }

}
