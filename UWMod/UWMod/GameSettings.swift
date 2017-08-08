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

class GameSettings {
    
    private var _firstDayTime:               Int
    private var _subsequentDayTime:          Int
    private var _changeDayBy:                Int
    private var _minimumDayLength:           Int
    private var _werewolfTime:               Int
    private var timeIncrement:               Int
    
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
    
    init(firstDay: Int = 1200, subsequentDay: Int = 600, increments: Int = 30, minimumDayLength: Int = 180, werewolfTime: Int = 120) {
        
        self._firstDayTime           = firstDayTime
        self._subsequentDayTime      = subsequentDay
        self._changeDayBy            = increments
        self._minimumDayLength       = minimumDayLength
        self._werewolfTime           = werewolfTime
        self.timeIncrement              = 10
    }
    
    public func increaseTimeFor(timer: TimeSetting) {
        
        switch timer {
        case .FirstDay:
            _firstDayTime += timeIncrement
        case .SubsequentDays:
            _subsequentDayTime += timeIncrement
        case .SubstractFromDay:
            _changeDayBy += timeIncrement
        case .MinimumDayTimeLength:
            _minimumDayLength += timeIncrement
        case .WerewolfDecisionTimer:
            _werewolfTime += timeIncrement
        }
    }
    
    public func decreaseTimeFor(timer: TimeSetting) {
        
        switch timer {
        case .FirstDay:
            _firstDayTime -= timeIncrement
        case .SubsequentDays:
            _subsequentDayTime -= timeIncrement
        case .SubstractFromDay:
            _changeDayBy -= timeIncrement
        case .MinimumDayTimeLength:
            _minimumDayLength -= timeIncrement
        case .WerewolfDecisionTimer:
            _werewolfTime -= timeIncrement
        }
    }
}
