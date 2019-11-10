//
//  TimerModel.swift
//  Timity
//
//  Created by Bassel Al Araaj on 08/11/2019.
//  Copyright © 2019 Webicom B.V. All rights reserved.
//

import Cocoa

class TimerModel {
    let appDelegate = NSApp.delegate as! AppDelegate
    
    var timer = Timer()
    var duration = 0
    var isTimerOn = false
    var isTimerOnPause = false
    var timerId: Int? = nil
    
    public init?(){
        
    }
    
    func getTime()-> String {
        let (h, m, s) = secondsToHoursMinutesSeconds(seconds:duration)
        return String(format: " %02d:%02d", h, m)
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func startTimer(id: Int?) {
        if(isTimerOn == false || isTimerOnPause == true){
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimer(timer:))
            isTimerOn = true
            isTimerOnPause = false
            timerId = id
            appDelegate.statusItem.button?.contentTintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
    }
    
    func stopTimer() {
        if(isTimerOn == true){
            timer.invalidate()
            isTimerOnPause = false
            isTimerOn = false
            duration = 0
            appDelegate.statusItem.button?.title = getTime()
            appDelegate.statusItem.button?.contentTintColor = .none
        }
    }
    
    func pauseTimer() {
        if(isTimerOn == true){
            timer.invalidate()
            isTimerOnPause = true
            appDelegate.statusItem.button?.contentTintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }
    }
    
    func continueTimer() {
        if(isTimerOn == true) {
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimer(timer:))
        }
    }
    
    func updateTimer(timer: Timer) {
        timerModel?.duration += 1
        appDelegate.statusItem.button?.title = timerModel!.getTime()
    }

}

var timerModel = TimerModel()
