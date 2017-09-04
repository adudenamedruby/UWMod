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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stopTimers),
                                               name: NSNotification.Name(rawValue: DayEndTimersNotification),
                                               object: nil)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func configureCell() {
        playersAliveLabel.text              = "\(GAME.livingActors.count)"
        playersDeadLabel.text               = "\(GAME.deadActors.count)"
        totalPlayersLabel.text              = "\(GAME.availablePlayers.count)"
        numberOfNightsPassedLabel.text      = "\(GAME.currentNight - 1)"
        dayNumberLabel.text                 = "\(GAME.currentDay)"
        
        if !GAME.timerIsRunning && !GAME.dayTimerTimeIsUp {
            GAME.startTimer()
        
            self.timer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(updateTimeLabel),
                                              userInfo: nil,
                                              repeats: true)
            
            self.isTrackingTime = true
            
        } else {
            timeLabel.text = "TIME'S UP!"
        }
    }
    
    func updateTimeLabel() {
        timeLabel.text = GAME.currentTime
        
        if GAME.currentTime == "--:--:--" {
            GAME.dayTimerTimeIsUp = true
        }
        
        if GAME.dayTimerTimeIsUp {
            stopTimers()
            timeLabel.text = "TIME'S UP!"
        }
    }
    
    func stopTimers() {
        if self.isTrackingTime {
            self.timer.invalidate()
            self.isTrackingTime = false
        }
        
        GAME.stopTimer()
    }
}
