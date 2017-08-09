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
    
    @IBOutlet weak var firstDayTitleLabel:  RegBrownBold!
    @IBOutlet weak var ensuingTitleLabel:   RegBrownBold!
    @IBOutlet weak var decreaseTitleLabel:  RegBrownBold!
    @IBOutlet weak var minTitleLabel:       RegBrownBold!
    @IBOutlet weak var werewolfTitleLabel:  RegBrownBold!
    
    
    @IBOutlet var firstDayLabel:            RegBrownSetting!
    @IBOutlet var subsequentDayLabel:       RegBrownSetting!
    @IBOutlet var decreaseDayLabel:         RegBrownSetting!
    @IBOutlet var minimumDayLabel:          RegBrownSetting!
    @IBOutlet var werewolfTimerLabel:       RegBrownSetting!
    
    @IBOutlet var firstIncrease:            PMSuperButton!
    @IBOutlet var firstDecrease:            PMSuperButton!
    @IBOutlet var ensuingIncrease:          PMSuperButton!
    @IBOutlet var ensuingDecrease:          PMSuperButton!
    @IBOutlet var decreaseIncrease:         PMSuperButton!
    @IBOutlet var decreaseDecrease:         PMSuperButton!
    @IBOutlet var minIncrease:              PMSuperButton!
    @IBOutlet var minDecrease:              PMSuperButton!
    @IBOutlet var wolfIncrease:             PMSuperButton!
    @IBOutlet var wolfDecrease:             PMSuperButton!
    
    @IBOutlet weak var segmentedControl:    UISegmentedControl!

    // MARK: - Variables
    
    private var buttonList: [PMSuperButton]         = []
    private var labelList: [RegBrownSetting]        = []
    private var titleLabelList: [RegBrownBold]      = []
    
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
        
        buttonList              = [firstIncrease,
                                   firstDecrease,
                                   ensuingIncrease,
                                   ensuingDecrease,
                                   decreaseIncrease,
                                   decreaseDecrease,
                                   minIncrease,
                                   minDecrease,
                                   wolfIncrease,
                                   wolfDecrease]
        
        labelList               = [firstDayLabel,
                                   subsequentDayLabel,
                                   decreaseDayLabel,
                                   minimumDayLabel,
                                   werewolfTimerLabel]
        
        titleLabelList          = [firstDayTitleLabel,
                                   ensuingTitleLabel,
                                   decreaseTitleLabel,
                                   minTitleLabel,
                                   werewolfTitleLabel]

        setupButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupButtons() {
        for button in buttonList {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(normalTap))
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
            tapGesture.numberOfTapsRequired = 1
            button.addGestureRecognizer(tapGesture)
            button.addGestureRecognizer(longGesture)
        }
    
        enableButtons()
    }
    
    
    // MARK: - Button actions
    
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            enableButtons()
            SETTINGS.changeTimeKeepingStyle(style: .Countdown)
        case 1:
            disableButtons()
            SETTINGS.changeTimeKeepingStyle(style: .Stopwatch)
        default:
            break
        }
    }
    
    private func disableButtons() {
        for button in buttonList {
            button.isEnabled = false
            button.alpha = 0.5
        }
        
        for label in labelList {
            label.alpha = 0.5
        }
        
        for label in titleLabelList {
            label.alpha = 0.5
        }
    }

    
    private func enableButtons() {
        for button in buttonList {
            button.isEnabled = true
            button.alpha = 1
        }
        
        for label in labelList {
            label.alpha = 1
        }
        
        for label in titleLabelList {
            label.alpha = 1
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(normalTap))
//        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
//        tapGesture.numberOfTapsRequired = 1
//        sender.addGestureRecognizer(tapGesture)
//        sender.addGestureRecognizer(longGesture)
    }
    
    func normalTap(sender : UIGestureRecognizer) {
        let recognizer: UIGestureRecognizer = sender
        let tag: Int = recognizer.view!.tag
        
        switch tag {
        case 1:
            increaseSeconds(affectingLabel: firstDayLabel, forTimer: .FirstDay)
        case 2:
            decreaseSeconds(affectingLabel: firstDayLabel, forTimer: .FirstDay)
        case 3:
            increaseSeconds(affectingLabel: subsequentDayLabel, forTimer: .SubsequentDays)
        case 4:
            decreaseSeconds(affectingLabel: subsequentDayLabel, forTimer: .SubsequentDays)
        case 5:
            increaseSeconds(affectingLabel: decreaseDayLabel, forTimer: .SubstractFromDay)
        case 6:
            decreaseSeconds(affectingLabel: decreaseDayLabel, forTimer: .SubstractFromDay)
        case 7:
            increaseSeconds(affectingLabel: minimumDayLabel, forTimer: .MinimumDayTimeLength)
        case 8:
            decreaseSeconds(affectingLabel: minimumDayLabel, forTimer: .MinimumDayTimeLength)
        case 9:
            increaseSeconds(affectingLabel: werewolfTimerLabel, forTimer: .WerewolfDecisionTimer)
        case 10:
            decreaseSeconds(affectingLabel: werewolfTimerLabel, forTimer: .WerewolfDecisionTimer)
        default:
            print("ooooo")
        }
    }
    
    func longTap(sender : UIGestureRecognizer) {
        let recognizer: UIGestureRecognizer = sender
        let tag: Int = recognizer.view!.tag
        
        if sender.state == .began {
            print("UIGestureRecognizerStateEnded")
            switch tag {
            case 1:
                increaseMinute(affectingLabel: firstDayLabel, forTimer: .FirstDay)
            case 2:
                decreaseMinute(affectingLabel: firstDayLabel, forTimer: .FirstDay)
            case 3:
                increaseMinute(affectingLabel: subsequentDayLabel, forTimer: .SubsequentDays)
            case 4:
                decreaseMinute(affectingLabel: subsequentDayLabel, forTimer: .SubsequentDays)
            case 5:
                increaseMinute(affectingLabel: decreaseDayLabel, forTimer: .SubstractFromDay)
            case 6:
                decreaseMinute(affectingLabel: decreaseDayLabel, forTimer: .SubstractFromDay)
            case 7:
                increaseMinute(affectingLabel: minimumDayLabel, forTimer: .MinimumDayTimeLength)
            case 8:
                decreaseMinute(affectingLabel: minimumDayLabel, forTimer: .MinimumDayTimeLength)
            case 9:
                increaseMinute(affectingLabel: werewolfTimerLabel, forTimer: .WerewolfDecisionTimer)
            case 10:
                decreaseMinute(affectingLabel: werewolfTimerLabel, forTimer: .WerewolfDecisionTimer)
            default:
                print("ooooo")
            }
        } else if sender.state == .ended {
            
        }
    }
    
    
    @IBAction func saveSettingsButton(_ sender: Any) {
        
        let temp: GameSettings = GameSettings(firstDay:         SETTINGS.firstDayTime,
                                              subsequentDay:    SETTINGS.subsequentDayTime,
                                              increments:       SETTINGS.changeDayBy,
                                              minimumDayTime:   SETTINGS.minimumDayLength,
                                              werewolfTimer:    SETTINGS.werewolfTime,
                                              timekeepingStyle: SETTINGS.timekeepingStyle)
        
        SETTINGS                = GameSettings(firstDay:           temp.firstDayTime,
                                               subsequentDay:      temp.subsequentDayTime,
                                               increments:         temp.changeDayBy,
                                               minimumDayTime:     temp.minimumDayLength,
                                               werewolfTimer:      temp.werewolfTime,
                                               timekeepingStyle:   temp.timekeepingStyle)

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
    
    private func increaseSeconds(affectingLabel: UILabel, forTimer: TimeSetting) {
        SETTINGS.increaseSecondsFor(timer: forTimer)
        updateLabel(label: affectingLabel, forTimeItem: forTimer)
    }
    
    private func decreaseSeconds(affectingLabel: UILabel, forTimer: TimeSetting) {
        SETTINGS.decreaseSecondsFor(timer: forTimer)
        updateLabel(label: affectingLabel, forTimeItem: forTimer)
    }
    
    private func increaseMinute(affectingLabel: UILabel, forTimer: TimeSetting) {
        SETTINGS.increaseMinutesFor(timer: forTimer)
        updateLabel(label: affectingLabel, forTimeItem: forTimer)
    }
    
    private func decreaseMinute(affectingLabel: UILabel, forTimer: TimeSetting) {
        SETTINGS.decreaseMinutesFor(timer: forTimer)
        updateLabel(label: affectingLabel, forTimeItem: forTimer)
    }
    
    private func timeString(time:TimeInterval) -> String {
        
        let minutes         = Int(time) / 60 % 60
        let seconds         = Int(time) % 60
        
        return String(format:"%02i:%02i", minutes, seconds)
    }

}
