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
    
    @IBOutlet var mainCardView:             UIView!
    @IBOutlet var headerView:               UIView!
    @IBOutlet var headerTitleLabel:         OldTan!
    
    @IBOutlet var firstDayLabel:            RegBrownSetting!
    @IBOutlet var subsequentDayLabel:       RegBrownSetting!
    @IBOutlet var decreaseDayLabel:         RegBrownSetting!
    @IBOutlet var minimumDayLabel:          RegBrownSetting!
    @IBOutlet var werewolfTimerLabel:       RegBrownSetting!
    

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainCardView.layer.cornerRadius     = STYLE.CornerRadius
        mainCardView.backgroundColor        = STYLE.Tan
        headerView.backgroundColor          = STYLE.Brown
        
        let headerTitle                     = "Game Settings"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        firstDayLabel.text      = timeString(time: TimeInterval(SETTINGS.firstDayTime))
        subsequentDayLabel.text = timeString(time: TimeInterval(SETTINGS.subsequentDayTime))
        decreaseDayLabel.text   = timeString(time: TimeInterval(SETTINGS.changeDayBy))
        minimumDayLabel.text    = timeString(time: TimeInterval(SETTINGS.minimumDayLength))
        werewolfTimerLabel.text = timeString(time: TimeInterval(SETTINGS.werewolfTime))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button actions
    
    @IBAction func increaseFirstDay(_ sender: Any) {
        raiseValue(affectingLabel: firstDayLabel, forTimer: .FirstDay)
    }
    
    @IBAction func decreaseFirstDay(_ sender: Any) {
        lowerValue(affectingLabel: firstDayLabel, forTimer: .FirstDay)
    }
    
    @IBAction func increaseSubsequentDay(_ sender: Any) {
        raiseValue(affectingLabel: subsequentDayLabel, forTimer: .SubsequentDays)
    }
    
    @IBAction func decreaseSubsequentDay(_ sender: Any) {
        lowerValue(affectingLabel: subsequentDayLabel, forTimer: .SubsequentDays)
    }
    
    @IBAction func increaseChangeIncrement(_ sender: Any) {
        raiseValue(affectingLabel: decreaseDayLabel, forTimer: .SubstractFromDay)
    }
    
    @IBAction func decreaseChangeIncrement(_ sender: Any) {
        lowerValue(affectingLabel: decreaseDayLabel, forTimer: .SubstractFromDay)
    }
    
    @IBAction func increaseMinimumDayLength(_ sender: Any) {
        raiseValue(affectingLabel: minimumDayLabel, forTimer: .MinimumDayTimeLength)
    }
    
    @IBAction func decreaseMinimumDayLength(_ sender: Any) {
        lowerValue(affectingLabel: minimumDayLabel, forTimer: .MinimumDayTimeLength)
    }
    
    @IBAction func increaseWerewolfTime(_ sender: Any) {
        raiseValue(affectingLabel: werewolfTimerLabel, forTimer: .WerewolfDecisionTimer)
    }
    
    @IBAction func decreaseWerewolfTime(_ sender: Any) {
        lowerValue(affectingLabel: werewolfTimerLabel, forTimer: .WerewolfDecisionTimer)
    }
    
    @IBAction func saveSettingsButton(_ sender: Any) {
        
        let temp: GameSettings = GameSettings(firstDay:       SETTINGS.firstDayTime,
                                              subsequentDay:  SETTINGS.subsequentDayTime,
                                              increments:     SETTINGS.changeDayBy,
                                              minimumDayTime: SETTINGS.minimumDayLength,
                                              werewolfTimer:  SETTINGS.werewolfTime)
        
        SETTINGS = GameSettings(firstDay:       temp.firstDayTime,
                                subsequentDay:  temp.subsequentDayTime,
                                increments:     temp.changeDayBy,
                                minimumDayTime: temp.minimumDayLength,
                                werewolfTimer:  temp.werewolfTime)

        self.dismiss(animated: true, completion: nil)
    }
    
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
    
    private func raiseValue(affectingLabel: UILabel, forTimer: TimeSetting) {
        SETTINGS.increaseTimeFor(timer: forTimer)
        updateLabel(label: affectingLabel, forTimeItem: forTimer)
    }
    
    private func lowerValue(affectingLabel: UILabel, forTimer: TimeSetting) {
        SETTINGS.decreaseTimeFor(timer: forTimer)
        updateLabel(label: affectingLabel, forTimeItem: forTimer)
    }
    
    private func timeString(time:TimeInterval) -> String {
        
        let minutes         = Int(time) / 60 % 60
        let seconds         = Int(time) % 60
        
        return String(format:"%02i:%02i", minutes, seconds)
    }

}
