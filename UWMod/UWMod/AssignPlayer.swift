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

    // MARK: - Initializers
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var assignButton: PMSuperButton!
    @IBOutlet weak var okButton: PMSuperButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var roleNotes: UILabel!
    
    weak var delegate: UpdateCardDelegate?
    var chosenPlayerName: String!
    var player: Player?
    
    init(frame: CGRect, withPlayer player: Player) {
        super.init(frame: frame)
        self.player = player
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        Bundle.main.loadNibNamed("AssignPlayer", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.backgroundColor = STYLE.Tan
        
        roleNotes.text = player?.role.notes
        pickerView.isHidden = true
        okButton.isHidden = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        chosenPlayerName = GAME.availableRoster[0]
    }
    
    @IBAction func assignButtonTapped(_ sender: Any) {
        assignButton.isEnabled = false
        assignButton.isHidden = true
        roleNotes.isHidden = true
        
        pickerView.isHidden = false
        okButton.isHidden = false
        
    }

    @IBAction func okButtonTapped(_ sender: Any) {
            
        let index = GAME.availableRoster.index(of: chosenPlayerName)
        GAME.availableRoster.remove(at: index!)
        GAME.assignRoleToPlayer(player: player!, name: chosenPlayerName!)
        delegate?.updateCard()
    }
}

extension AssignPlayer: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GAME.availableRoster.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GAME.availableRoster[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenPlayerName = GAME.availableRoster[row]
    }
}
