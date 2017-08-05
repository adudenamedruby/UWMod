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
    
    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet var playersAliveLabel: RegGreenBold!
    @IBOutlet var playersDeadLabel: RegRedBold!
    @IBOutlet var totalPlayersLabel: RegBrownBold!
    
    @IBOutlet weak var timeLabel: RegBrown!
    
    //MARK: - Variables
    private var timer: Timer!
    private var counter = 0
    private var isTrackingTime = false
    
    //MARK: - View Lifecycle & Configuration
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius = STYLE.CornerRadius
        outlineView.backgroundColor = STYLE.Beige
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Beige
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell() {
        playersAliveLabel.text = "\(GAME.livingActors.count)"
        playersDeadLabel.text = "\(GAME.deadActors.count)"
        totalPlayersLabel.text = "\(GAME.livingActors.count + GAME.deadActors.count)"
        startTimer()
        
    }
    
    func startTimer() {
        if !isTrackingTime {
            self.timer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(GeneralInfo.updateTimerLabel),
                                              userInfo: nil,
                                              repeats: true)
            
            isTrackingTime = true
        }
    }
    
    func stopTimer() {
        self.timer.invalidate()
        self.counter = 0
        isTrackingTime = false
    }
    
    func updateTimerLabel() {
        counter += 1
        timeLabel.text = timeString(time: TimeInterval(counter))
    }
    
    func timeString(time:TimeInterval) -> String {
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
