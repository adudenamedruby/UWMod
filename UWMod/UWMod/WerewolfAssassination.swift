//
//  WerewolfAssassination.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-05.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class WerewolfAssassination: UIView {

    // MARK: - Outlets
    
    @IBOutlet var contentView:                  UIView!
    @IBOutlet weak var killVillagerButton:      PMSuperButton!
    @IBOutlet weak var timerLabel:              RegRedHeader!
    
    
    // MARK: - Variables
    weak var delegate:                          UpdateCardDelegate?
    private var timer:                          Timer!
    private var counter                         = 0
    private var isTrackingTime                  = false
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        Bundle.main.loadNibNamed("WerewolfAssassination", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame                       = self.bounds
        contentView.autoresizingMask            = [.flexibleHeight, .flexibleWidth]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(confirmKill),
                                               name: NSNotification.Name(rawValue: EliminationByWerewolfSuccessNotification),
                                               object: nil)
        
        contentView.backgroundColor             = STYLE.Tan

        GAME.startTimer()
        
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(updateTimer),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    
    // MARK: - Button functionality
    
    @IBAction func killVillagerPressed(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let selectPlayer = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        selectPlayer.popupTitle = "Who to kill?"
        selectPlayer.reason = .WerewolfElimination

        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(selectPlayer, animated: true, completion: nil)
    }
    
    func confirmKill() {
        GAME.stopTimer()
        timerLabel.isHidden                 = true
        killVillagerButton.isHidden         = true
        delegate?.updateCard()
    }
    
    func updateTimer() {
        timerLabel.text = GAME.timer.currentTime
    }
}
