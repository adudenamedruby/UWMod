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
    @IBOutlet weak var roleNotes:       UILabel!
    
    
    // MARK: - Variables
    
    // passed variables
    weak var delegate:                  UpdateCardDelegate?
    var role:                           Role?
    // assigned variables
    var chosenPlayer:                   Player!
    
    
    // MARK: - Initializers
    
    init(frame: CGRect, withRole role: Role) {
        super.init(frame: frame)
        self.role = role
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        let bundle = Bundle(for: type(of: self))
        UINib(nibName: "AssignPlayer", bundle: bundle).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = bounds
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkPlayerAssignment),
                                               name: NSNotification.Name(rawValue: AssignPlayerFailureNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerAssigned),
                                               name: NSNotification.Name(rawValue: AssignPlayerSuccessNotification),
                                               object: nil)
        
        contentView.backgroundColor     = STYLE.Tan
        
        roleNotes.text                  = role?.notes
    }
    
    func checkPlayerAssignment() {
        assignButton.isHidden           = false
        roleNotes.text                  = role?.notes
    }
    
    @IBAction func assignButtonTapped(_ sender: Any) {
        assignButton.isHidden           = true
        roleNotes.isHidden              = true
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Assign Role"
        selectPlayer.role = role!
        selectPlayer.reason = .AssignPlayer
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(selectPlayer, animated: true, completion: nil)
    }

    func playerAssigned() {
        delegate?.updateCard()
    }
}
