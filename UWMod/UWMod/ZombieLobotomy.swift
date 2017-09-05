//
//  ZombieLobotomy.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-11.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class ZombieLobotomy: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:              UIView!
    @IBOutlet weak var eatBrainsButton:     PMSuperButton!
    
    
    // MARK: - Variables
    
    // passed variables
    weak var delegate:                      UpdateCardDelegate?
    var activePlayer:                       Player?
    // assigned variables
    var chosenPlayer:                       Player!
    var playersWithBrains:                  [Player]!
    
    
    // MARK: - Initializers
    
    init(frame: CGRect, withPlayer player: Player) {
        super.init(frame: frame)
        self.activePlayer = player
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
        UINib(nibName: "ZombieLobotomy", bundle: bundle).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = bounds
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(lobotomySuccess),
                                               name: NSNotification.Name(rawValue: ZombieLobotomySuccessNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(lobotomyFailure),
                                               name: NSNotification.Name(rawValue: ZombieLobotomyFailureNotification),
                                               object: nil)
        
        contentView.backgroundColor     = STYLE.Tan
        
    }
    
    @IBAction func eatBrainsButtonTapped(_ sender: Any) {
        eatBrainsButton.isHidden          = true
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Available Dinner"
        selectPlayer.reason = .ZombieLobotomization
        selectPlayer.activePlayer = activePlayer
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(selectPlayer, animated: true, completion: nil)
        
    }
    
    func lobotomyFailure() {
        eatBrainsButton.isHidden = false
    }
    
    func lobotomySuccess() {
        delegate?.updateCard()
    }

}
