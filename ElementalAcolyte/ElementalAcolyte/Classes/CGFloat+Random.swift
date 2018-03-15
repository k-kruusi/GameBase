//
//  CGFloat+Random.swift
//  ZombieConga
//
//  Created by Kevin Kruusi on 2018-02-26.
//  Copyright © 2018 kevin. All rights reserved.
//

import SceneKit

// MARK: - random numbers extension for CGFloat
extension CGFloat {
    
    /// returns a random number between a minimum and maximum number
    ///
    /// - Parameters:
    ///   - min: the mininimum number
    ///   - max: the maximum number
    /// - Returns: CGFloat
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        let rand = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return (rand * (max - min) + min)
    }
    
    /// returns a value between 0 and 1.0
    ///
    /// - Returns: CGFloat
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
