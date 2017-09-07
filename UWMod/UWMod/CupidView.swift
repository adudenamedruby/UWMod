//
//  CupidView.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-18.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class CupidView: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:              UIView!
    @IBOutlet weak var loveButton:          PMSuperButton!
    
    
    // MARK: - Variables
    
    // passed variables
    weak var delegate:                      UpdateCardDelegate?
    var currentPlayer:                      Player?
    // assigned variables
    var chosenPlayer:                       Player!
    //var playersAvailableToStrikeWithLove:   [Player]!
    
    
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
        UINib(nibName: "CupidView", bundle: bundle).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = bounds
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(lovestrikeSecondPlayer),
                                               name: NSNotification.Name(rawValue: CupidLovestrikeFirstSuccessNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(lovestrikeSuccessful),
                                               name: NSNotification.Name(rawValue: CupidLovestrikeSecondSuccessNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(lovestrikeFailure),
                                               name: NSNotification.Name(rawValue: CupidLovestrikeFailureNotification),
                                               object: nil)
        
        contentView.backgroundColor     = STYLE.Tan
        
    }
    
    @IBAction func lovestrikeButtonTapped(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Mark for Love"
        selectPlayer.reason = .CupidLovestrike
        selectPlayer.activePlayer = currentPlayer
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(selectPlayer, animated: true, completion: nil)
        
    }
    
    func lovestrikeSecondPlayer() {
        loveButton.setTitle("Mark Second Player", for: .normal)
    }
    
    func lovestrikeFailure() {
        loveButton.isHidden = false
    }
    
    func lovestrikeSuccessful() {
        loveButton.isHidden         = true
        delegate?.updateCard()
    }

}
