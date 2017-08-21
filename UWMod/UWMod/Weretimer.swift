//
//  Weretimer.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-19.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

class Weretimer {
    
    private var _timer:                             Timer!
    private var _counter:                           Int
    private var _isTrackingTime:                    Bool
    private var _isTimerPaused:                     Bool
    private var _currentTime:                       String
    private var _timeLabel:                         UILabel!
    private var _settings:                          GameSettings
    private var _label:                             UILabel!
    
    var isPaused: Bool {
        get { return _isTimerPaused }
    }
    
    var currentTime: String {
        get { return _currentTime }
    }
    
    var isRunning: Bool {
        get { return _isTrackingTime }
    }
    
    init(withSettings settings: GameSettings) {
        _counter                                    = 0
        _isTrackingTime                             = false
        _timer                                      = Timer()
        _isTimerPaused                              = false
        _currentTime                                = ""
        _settings                                   = settings
    }
    
    public func startTimer(withTime time: Int) {
        if !_isTrackingTime {
            _counter    = time
            self._timer = Timer.scheduledTimer(timeInterval: 1,
                                               target: self,
                                               selector: #selector(updateTimer),
                                               userInfo: nil,
                                               repeats: true)
            
            _isTrackingTime = true
        }
    }
    
    public func stopTimer() {
        self._timer.invalidate()
        _isTrackingTime          = false
    }
    
    public func pauseTimer() {
        if !_isTimerPaused {
            _timer.invalidate()
            _isTimerPaused = true
        }
    }
    
    public func resumeTimer() {
        if _isTimerPaused {
            self._timer = Timer.scheduledTimer(timeInterval: 1,
                                               target: self,
                                               selector: #selector(updateTimer),
                                               userInfo: nil,
                                               repeats: true)
            _isTimerPaused = false
        }
    }
    
    @objc func updateTimer() {
        if _settings.timekeepingStyle == .Countdown {
            if _counter > 0 {
                _counter -= 1
                
                _currentTime = timeString(time: TimeInterval(_counter))
            } else {
                stopTimer()
                _currentTime = "--:--:--"
            }
        } else {
            _counter += 1
            _currentTime = timeString(time: TimeInterval(_counter))
        }
    }
    
    private func timeString(time:TimeInterval) -> String {
        
        let hours               = Int(time) / 3600
        let minutes             = Int(time) / 60 % 60
        let seconds             = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
