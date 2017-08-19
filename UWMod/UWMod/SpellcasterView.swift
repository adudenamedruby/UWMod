//
//  SpellcasterView.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-18.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class SpellcasterView: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:              UIView!
    @IBOutlet weak var silenceButton:       PMSuperButton!
    
    
    // MARK: - Variables
    
    // passed variables
    weak var delegate:                      UpdateCardDelegate?
    var currentPlayer:                      Player?

    
    
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
        Bundle.main.loadNibNamed("SpellcasterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = self.bounds
        contentView.autoresizingMask    = [.flexibleHeight, .flexibleWidth]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(silenceSuccessful),
                                               name: NSNotification.Name(rawValue: SpellcasterSilenceSuccessNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(silenceFailure),
                                               name: NSNotification.Name(rawValue: SpellcasterSilenceFailureNotification),
                                               object: nil)
        
        contentView.backgroundColor     = STYLE.Tan
        
    }
    
    @IBAction func silencePlayerButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Player to Silence"
        selectPlayer.reason = .SilencePlayer
        selectPlayer.activePlayer = currentPlayer
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(selectPlayer, animated: true, completion: nil)
        
    }
    
    func silenceFailure() {
        silenceButton.isHidden = false
    }
    
    func silenceSuccessful() {
        delegate?.updateCard()
    }

}
