//
//  TroublemakerView.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-26.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class TroublemakerView: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:              UIView!
    @IBOutlet weak var causeTroubleButton:  PMSuperButton!
    
    
    // MARK: - Variables
    
    // passed variables
    weak var delegate:                      UpdateCardDelegate?
    // assigned variables
    var currentPlayer:                      Player!
    
    
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
        UINib(nibName: "TroublemakerView", bundle: bundle).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame               = bounds
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(delinquencySucceded),
                                               name: NSNotification.Name(rawValue: TroublemakerDelinquencySuccessNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(delinquencyFailed),
                                               name: NSNotification.Name(rawValue: TroublemakerDelinquencyFailureNotification),
                                               object: nil)
        
        contentView.backgroundColor     = STYLE.Tan
        
    }
    
    @IBAction func causeTroubleButtonTapped(_ sender: Any) {
        causeTroubleButton.isHidden          = true
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let confirmTrouble = storyboard.instantiateViewController(withIdentifier: "confirmationPopup") as! ConfirmationPopup
        confirmTrouble.actingPlayer     = currentPlayer
        confirmTrouble.reason           = .StirUpTrouble
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(confirmTrouble, animated: true, completion: nil)
        
    }
    
    func delinquencyFailed() {
        causeTroubleButton.isHidden = false
    }
    
    func delinquencySucceded() {
        delegate?.updateCard()
    }

}
