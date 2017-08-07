//
//  AssignPlayer.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-01.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

protocol UpdateCardDelegate: class {
    func updateCard()
}

class AssignPlayer: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:          UIView!
    @IBOutlet weak var assignButton:    PMSuperButton!
    @IBOutlet weak var okButton:        PMSuperButton!
    @IBOutlet weak var pickerView:      UIPickerView!
    @IBOutlet weak var roleNotes:       UILabel!
    
    
    // MARK: - Variables
    
    // passed variables
    weak var delegate:                  UpdateCardDelegate?
    var role:                           Role?
    // assigned variables
    var chosenPlayer:                   Player!
    var unassignedPlayers:              [Player]!
    
    
    // MARK: - Initializers
    
    init(frame: CGRect, withRole role: Role) {
        super.init(frame: frame)
        self.role = role
        setupView()
        setupUnassignedPlayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupUnassignedPlayers()
    }
    
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        Bundle.main.loadNibNamed("AssignPlayer", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = self.bounds
        contentView.autoresizingMask    = [.flexibleHeight, .flexibleWidth]
        
        contentView.backgroundColor     = STYLE.Tan
        
        roleNotes.text                  = role?.notes
        pickerView.isHidden             = true
        okButton.isHidden               = true
        
        pickerView.delegate             = self
        pickerView.dataSource           = self
        
    }
    
    func setupUnassignedPlayers() {
        unassignedPlayers               = unassignedPlayerList()
        chosenPlayer                    = unassignedPlayers.first
    }
    
    func unassignedPlayerList() -> [Player] {
        var unassignedPlayerList:       [Player] = []
        
        for player in GAME.availablePlayers {
            if !player.isAssigned {
                unassignedPlayerList.append(player)
            }
        }
        
        unassignedPlayerList.sort(by: { $0.name < $1.name })
        
        return unassignedPlayerList
    }
    
    @IBAction func assignButtonTapped(_ sender: Any) {
        assignButton.isEnabled          = false
        assignButton.isHidden           = true
        roleNotes.isHidden              = true
        
        pickerView.isHidden             = false
        okButton.isHidden               = false
    }

    @IBAction func okButtonTapped(_ sender: Any) {
        chosenPlayer.assignRole(role: role!)
        GAME.addPlayerToLivingActors(player: chosenPlayer)
        
        delegate?.updateCard()
    }
}

extension AssignPlayer: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unassignedPlayerList().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let unassignedPlayers = unassignedPlayerList()
        return unassignedPlayers[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenPlayer = unassignedPlayerList()[row]
    }
}
