//
//  BodyguardView.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-06.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class BodyguardView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet var contentView:              UIView!
    @IBOutlet weak var protectButton:       PMSuperButton!
    @IBOutlet weak var okButton:            PMSuperButton!
    @IBOutlet weak var roleNotes: UILabel!
    
    
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
        setupUnprotectedPlayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupUnprotectedPlayers()
    }
    
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        Bundle.main.loadNibNamed("BodyguardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = self.bounds
        contentView.autoresizingMask    = [.flexibleHeight, .flexibleWidth]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkAssignment),
                                               name: NSNotification.Name(rawValue: BodyguardProtectingNotification),
                                               object: nil)
        
        contentView.backgroundColor     = STYLE.Tan
        
        okButton.isHidden               = true
    }
    
    func setupUnprotectedPlayers() {
        playersAvailableForProtection   = unprotectedPlayersList()
        chosenPlayer                    = playersAvailableForProtection.first
    }
    
    func unprotectedPlayersList() -> [Player] {
        var unprotectedPlayersList: [Player] = []
        
        for player in GAME.livingActors {
            if (currentPlayer?.canAffect(player: player, forCondition: .Protection))! && player !== currentPlayer {
                    unprotectedPlayersList.append(player)
            }
        }
        
        unprotectedPlayersList.sort(by: { $0.name < $1.name })
        
        return unprotectedPlayersList
    }
    
    func checkAssignment() {
        let name = GAME.identifyChosenPlayer().name
        roleNotes.text = "Protect \(name)?"
        roleNotes.isHidden = false
    }
    
    @IBAction func protectButtonTapped(_ sender: Any) {
        protectButton.isEnabled         = false
        protectButton.isHidden          = true
        okButton.isHidden               = false
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Protect a Player"
        selectPlayer.reason = .BodyguardSelectProtectee
        selectPlayer.currentPlayer = currentPlayer
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        currentPlayer?.protect(playerToProtect: chosenPlayer, protector: currentPlayer!)
        currentPlayer?.hasActedTonight = true
        
        delegate?.updateCard()
    }
}


extension BodyguardView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playersAvailableForProtection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return playersAvailableForProtection[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenPlayer = playersAvailableForProtection[row]
    }
}

