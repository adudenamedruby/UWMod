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
    @IBOutlet weak var pickerView:          UIPickerView!
    
    
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
        
        contentView.backgroundColor     = STYLE.Tan
        
        pickerView.isHidden             = true
        okButton.isHidden               = true
        
        pickerView.delegate             = self
        pickerView.dataSource           = self
        
    }
    
    func setupUnprotectedPlayers() {
        playersAvailableForProtection   = unprotectedPlayersList()
        chosenPlayer                    = playersAvailableForProtection.first
    }
    
    func unprotectedPlayersList() -> [Player] {
        var unprotectedPlayersList: [Player] = []
        
        for player in GAME.livingActors {
            if !player.isProtectedByBodyguard && player !== currentPlayer {
                unprotectedPlayersList.append(player)
            }
        }
        
        unprotectedPlayersList.sort(by: { $0.name < $1.name })
        
        return unprotectedPlayersList
    }
    
    @IBAction func protectButtonTapped(_ sender: Any) {
        protectButton.isEnabled         = false
        protectButton.isHidden          = true
        
        pickerView.isHidden             = false
        okButton.isHidden               = false
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        
        if let player = currentPlayer?.role as? Bodyguard {
            player.protect(player: chosenPlayer)
            currentPlayer?.hasActedTonight = true
        }
        
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

