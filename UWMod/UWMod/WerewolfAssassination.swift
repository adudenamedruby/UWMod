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
        
        contentView.backgroundColor             = STYLE.Tan
        
        counter                                 = setCurrentTime()
        
        startTimer()
    }
    
    
    // MARK: - Button functionality
    
    @IBAction func killVillagerPressed(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let lynchView = storyboard.instantiateViewController(withIdentifier: "eliminatePlayer") as! EliminatePlayerVC
        lynchView.modalTransitionStyle = .crossDissolve
        lynchView.eliminatedBy = .Werewolf
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(lynchView, animated: true, completion: nil)
    }
    
    
    // MARK: - Timer
    
    private func startTimer() {
        if !isTrackingTime {
            self.timer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(GeneralInfo.updateTimerLabel),
                                              userInfo: nil,
                                              repeats: true)
            
            isTrackingTime = true
        }
    }
    
    private func stopTimer() {
        self.timer.invalidate()
        self.counter            = setCurrentTime()
        isTrackingTime          = false
    }
    
    public func updateTimerLabel() {
        if counter > 0 {
            counter -= 1
            timerLabel.text      = timeString(time: TimeInterval(counter))
        } else {
            stopTimer()
            timerLabel.text      = "Time Expired"
            killVillagerButton.isHidden = true
        }
    }
    
    private func timeString(time:TimeInterval) -> String {
        
        let minutes             = Int(time) / 60 % 60
        let seconds             = Int(time) % 60
        
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    private func setCurrentTime() -> Int {
        return GAME.settings.werewolfTime
    }
}
