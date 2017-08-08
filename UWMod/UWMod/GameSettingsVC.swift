//
//  GameSettingsVC.swift
//  UWMod
//
//  Created by roux buciu on 2017-08-08.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class GameSettingsVC: UIViewController {

    // MARK: - Outlets
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button actions
    
    
    
    
    // MARK: - Change settings functions
    
    private func updateLabel(label: UILabel, forTimeItem: TimeSetting) {
        
        var timer: Int
        
        switch forTimeItem {
        case .FirstDay:
            timer = SETTINGS.firstDayTime
        case .SubsequentDays:
            timer = SETTINGS.subsequentDayTime
        case .SubstractFromDay:
            timer = SETTINGS.changeDayBy
        case .MinimumDayTimeLength:
            timer = SETTINGS.minimumDayLength
        case .WerewolfDecisionTimer:
            timer = SETTINGS.werewolfTime
        }
        
        label.text = timeString(time: TimeInterval(timer))
    }
    
    private func increaseValue(affectingLabel: UILabel, forTimer: TimeSetting) {
        SETTINGS.increaseTimeFor(timer: forTimer)
        updateLabel(label: affectingLabel, forTimeItem: forTimer)
    }
    
    private func decreaseValue(affectingLabel: UILabel, forTimer: TimeSetting) {
        SETTINGS.decreaseTimeFor(timer: forTimer)
        updateLabel(label: affectingLabel, forTimeItem: forTimer)
    }
    
    private func timeString(time:TimeInterval) -> String {
        
        let minutes         = Int(time) / 60 % 60
        let seconds         = Int(time) % 60
        
        return String(format:"%02i:%02i", minutes, seconds)
    }

}
