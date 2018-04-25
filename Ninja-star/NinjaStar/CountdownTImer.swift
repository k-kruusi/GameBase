//
//  CountdownTImer.swift
//  NinjaStar
//
//  Created by adid nissan on 2018-04-23.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import Foundation
import UIKit

class CountDownTimer: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var countdownTimer: Timer!
    var totalTime = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    @IBAction func startTimerPressed(_ sender: UIButton) {
        startTimer()
    }
    
}
