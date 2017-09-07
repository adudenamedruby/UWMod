//
//  VirginiasView.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class VirginiasView: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:              UIView!
    @IBOutlet weak var intimidateButton:    PMSuperButton!
    
    
    // MARK: - Variables
    
    // passed variables
    weak var delegate:                      UpdateCardDelegate?
    var currentPlayer:                      Player?
    // assigned variables
    var chosenPlayer:                       Player!
    
    
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
        let bundle = Bundle(for: type(of: self))
        UINib(nibName: "VirginiasView", bundle: bundle).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = bounds
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(intimidationSuccessful),
                                               name: NSNotification.Name(rawValue: VirginiaIntimidationSuccessNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(intimidationFailure),
                                               name: NSNotification.Name(rawValue: VirginiaIntimidationFailureNotification),
                                               object: nil)
        
        contentView.backgroundColor     = STYLE.Tan
        
    }
    
    @IBAction func intimidateButtonTapped(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Find Dependent"
        selectPlayer.reason = .VirginiaIsInTown
        selectPlayer.activePlayer = currentPlayer
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(selectPlayer, animated: true, completion: nil)
        
    }
    
    func intimidationFailure() {
        intimidateButton.isHidden = false
    }
    
    func intimidationSuccessful() {
        delegate?.updateCard()
    }

}
