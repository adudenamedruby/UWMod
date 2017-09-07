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
    @IBOutlet weak var notesLabel:              UILabel!
    @IBOutlet weak var eliminationDetails:      UILabel!
    
    
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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stopTimers),
                                               name: NSNotification.Name(rawValue: NightEndTimersNotification),
                                               object: nil)
        
        contentView.backgroundColor             = STYLE.Tan
        
        self.dreamwolfLabel()
        
        eliminationDetails.text = "(Eliminations available: \(GAME.werewolfEliminationsThisNight))"

        if !GAME.timerIsRunning && !GAME.nightTimerTimeIsUp {
            GAME.startTimer()
        }
        
        if !isTrackingTime {
            self.timer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(updateTimer),
                                              userInfo: nil,
                                              repeats: true)
            self.isTrackingTime = true
        }
    }
    
    func dreamwolfLabel() {
        if GAME.dreamwolfIsPresent {
            var dreamwolfIsAlive        = false
            
            for player in GAME.livingActors {
                if player.roleType == .Dreamwolf {
                    dreamwolfIsAlive    = true
                }
            }
            
            if dreamwolfIsAlive {
                if GAME.dreamwolfShouldWake {
                    notesLabel.text     = "Including the Dreamwolf"
                } else {
                    notesLabel.text     = "Excluding the Dreamwolf"
                }
                
            } else {
                notesLabel.text         = ""
            }
        } else {
            notesLabel.text             = ""
        }
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
        if !(GAME.werewolfEliminationsThisNight > 0) {
            stopTimers()
            timerLabel.isHidden                 = true
            killVillagerButton.isHidden         = true
            eliminationDetails.isHidden         = true
        }
        //delegate?.updateCard()
    }
    
    func updateTimer() {
        self.timerLabel.text = GAME.currentTime
        
        if GAME.currentTime == "--:--:--" {
            GAME.nightTimerTimeIsUp = true
        }
        
        if GAME.nightTimerTimeIsUp {
            stopTimers()
            timerLabel.text = "TIME'S UP!"
        }
    }
    
    func stopTimers() {
        if isTrackingTime {
            self.timer.invalidate()
            self.isTrackingTime = false
        }
        
        GAME.stopTimer()
    }
}
