//
//  GameSettings.swift
//  UWMod
//
//  Created by roux buciu on 2017-08-08.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

// first day, subsequent, change, minimum, werewolf time

enum TimeSetting {
    case FirstDay
    case SubsequentDays
    case SubstractFromDay
    case MinimumDayTimeLength
    case WerewolfDecisionTimer
}

enum TimekeepingType {
    case Countdown
    case Stopwatch
}

class GameSettings {
    
    private var _firstDayTime:               Int
    private var _subsequentDayTime:          Int
    private var _changeDayBy:                Int
    private var _minimumDayLength:           Int
    private var _werewolfTime:               Int
    private var _timerType:                  TimekeepingType
    private var secondIncrement:             Int
    private var minuteIncrement:             Int
    
    var firstDayTime: Int {
        get { return _firstDayTime }
    }
    
    var subsequentDayTime: Int {
        get { return _subsequentDayTime }
    }
    
    var changeDayBy: Int {
        get { return _changeDayBy }
    }
    
    var minimumDayLength: Int {
        get { return _minimumDayLength }
    }
    
    var werewolfTime: Int {
        get { return _werewolfTime }
    }
    
    var timekeepingStyle: TimekeepingType {
        get { return _timerType }
    }
    
    init(firstDay: Int = 1200, subsequentDay: Int = 600, increments: Int = 30, minimumDayTime: Int = 180, werewolfTimer: Int = 120, timekeepingStyle: TimekeepingType = .Countdown) {
        
        self._firstDayTime              = firstDay
        self._subsequentDayTime         = subsequentDay
        self._changeDayBy               = increments
        self._minimumDayLength          = minimumDayTime
        self._werewolfTime              = werewolfTimer
        self._timerType                 = timekeepingStyle
        self.secondIncrement            = 10
        self.minuteIncrement            = 60
    }
    
    public func increaseSecondsFor(timer: TimeSetting) {
        
        switch timer {
        case .FirstDay:
            _firstDayTime += secondIncrement
        case .SubsequentDays:
            _subsequentDayTime += secondIncrement
        case .SubstractFromDay:
            _changeDayBy += secondIncrement
        case .MinimumDayTimeLength:
            _minimumDayLength += secondIncrement
        case .WerewolfDecisionTimer:
            _werewolfTime += secondIncrement
        }
    }
    
    public func decreaseSecondsFor(timer: TimeSetting) {
        
        switch timer {
        case .FirstDay:
            _firstDayTime -= secondIncrement
        case .SubsequentDays:
            _subsequentDayTime -= secondIncrement
        case .SubstractFromDay:
            _changeDayBy -= secondIncrement
        case .MinimumDayTimeLength:
            _minimumDayLength -= secondIncrement
        case .WerewolfDecisionTimer:
            _werewolfTime -= secondIncrement
        }
    }
    
    public func increaseMinutesFor(timer: TimeSetting) {
        
        switch timer {
        case .FirstDay:
            _firstDayTime += minuteIncrement
        case .SubsequentDays:
            _subsequentDayTime += minuteIncrement
        case .SubstractFromDay:
            _changeDayBy += minuteIncrement
        case .MinimumDayTimeLength:
            _minimumDayLength += minuteIncrement
        case .WerewolfDecisionTimer:
            _werewolfTime += minuteIncrement
        }
    }
    
    public func decreaseMinutesFor(timer: TimeSetting) {
        
        switch timer {
        case .FirstDay:
            _firstDayTime -= minuteIncrement
        case .SubsequentDays:
            _subsequentDayTime -= minuteIncrement
        case .SubstractFromDay:
            _changeDayBy -= minuteIncrement
        case .MinimumDayTimeLength:
            _minimumDayLength -= minuteIncrement
        case .WerewolfDecisionTimer:
            _werewolfTime -= minuteIncrement
        }
    }
    
    public func changeTimeKeepingStyle(style: TimekeepingType) {
        _timerType = style
    }
}
