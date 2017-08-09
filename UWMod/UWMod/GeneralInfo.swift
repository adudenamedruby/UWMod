//
//  GeneralInfo.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-02.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class GeneralInfo: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var outlineView:                 UIView!
    @IBOutlet weak var mainCardView:                UIView!
    @IBOutlet weak var headerView:                  UIView!
    @IBOutlet weak var headerTitleLabel:            RegTanHeader!
    
    @IBOutlet var playersAliveLabel:                RegGreenBold!
    @IBOutlet var playersDeadLabel:                 RegRedBold!
    @IBOutlet var totalPlayersLabel:                RegBrownBold!
    
    @IBOutlet weak var numberOfNightsPassedLabel:   RegBrown!
    @IBOutlet weak var dayNumberLabel:              RegBrown!
    
    @IBOutlet weak var timeLabel:                   RegBrown!
    
    //MARK: - Variables
    private var timer:                              Timer!
    private var counter                             = 0
    private var isTrackingTime                      = false
    
    //MARK: - View Lifecycle & Configuration
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius      = STYLE.InfoCardCornerRadius
        outlineView.backgroundColor         = STYLE.Beige
        mainCardView.layer.cornerRadius     = STYLE.InfoCardCornerRadius
        mainCardView.backgroundColor        = STYLE.Tan
        headerView.backgroundColor          = STYLE.Beige
        
        let headerTitle = "General Info"
        headerTitleLabel.attributedText     = headerTitle.styleTitleLabel(withStringFont: STYLE.RegBoldHeaderFont!,
                                                                          withColour: STYLE.Red)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func configureCell() {
        playersAliveLabel.text              = "\(GAME.livingActors.count)"
        playersDeadLabel.text               = "\(GAME.deadActors.count)"
        totalPlayersLabel.text              = "\(GAME.livingActors.count + GAME.deadActors.count)"
        numberOfNightsPassedLabel.text      = "\(GAME.currentNight - 1)"
        dayNumberLabel.text                 = "\(GAME.currentDay)"
        
        setCounter()
        startTimer()
        
    }
    
    private func setCounter() {
        if GAME.settings.timekeepingStyle == .Countdown {
            if GAME.currentDay == 1 {
                counter                         = GAME.settings.firstDayTime
            } else {
                counter                         = setCurrentTime()
            }
        } else {
            counter                             = 0
        }
    }
    
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
        setCounter()
        isTrackingTime          = false
    }
    
    public func updateTimerLabel() {
        if GAME.settings.timekeepingStyle == .Countdown {
            if counter > 0 {
                counter -= 1
                timeLabel.text      = timeString(time: TimeInterval(counter))
            } else {
                stopTimer()
                timeLabel.text      = "--:--:--"
            }
        } else {
            counter += 1
            timeLabel.text      = timeString(time: TimeInterval(counter))
        }
    }
    
    private func timeString(time:TimeInterval) -> String {
        
        let hours               = Int(time) / 3600
        let minutes             = Int(time) / 60 % 60
        let seconds             = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func setCurrentTime() -> Int {
        let timerMultiplier     = GAME.currentDay - 2
        let shortenDayBy        = (timerMultiplier * GAME.settings.changeDayBy)
        let counterTime         = GAME.settings.subsequentDayTime - shortenDayBy
        
        if counterTime < GAME.settings.minimumDayLength {
            return GAME.settings.minimumDayLength
        }
        
        return counterTime
    }
}
