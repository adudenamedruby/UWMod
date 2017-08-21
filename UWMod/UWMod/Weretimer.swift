//
//  Weretimer.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-19.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

enum TimerType {
    case WerewolfTimer
    case DayTimer
}


class Weretimer {
    
    private var _timer:                             Timer!
    private var _counter:                           Int
    private var _isTrackingTime:                    Bool
    private var _isTimerPaused:                     Bool
    private var _currentTime:                       String
    private var _timeLabel:                         UILabel!
    private var _settings:                          GameSettings
    
    var handler: (_ timeAsString: String) -> ()
    
    var counter: Int {
        get { return _counter }
    }
    
    var isPaused: Bool {
        get { return _isTimerPaused }
    }
    
    init(withSettings settings: GameSettings) {
        _counter                                    = 0
        _isTrackingTime                             = false
        _timer                                      = Timer()
        _isTimerPaused                              = false
        _currentTime                                = ""
        _settings                                   = settings
    }
    
    public func startTimer(withTime time: Int, handler: @escaping (String) -> ()) {
        if !_isTrackingTime {
            _counter    = time
            self.handler = handler
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
            if counter > 0 {
                _counter -= 1
                
                self.handler(timeString(time: TimeInterval(counter)))
            } else {
                stopTimer()
                self.handler("--:--:--")
            }
        } else {
            _counter += 1
            self.handler(timeString(time: TimeInterval(counter)))
        }
    }
    
    private func timeString(time:TimeInterval) -> String {
        
        let hours               = Int(time) / 3600
        let minutes             = Int(time) / 60 % 60
        let seconds             = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
    // var t = Timer(duration: 30, handler:{ (x:Int) -> Void in
    //Do soemthing with x;
    //});
}
