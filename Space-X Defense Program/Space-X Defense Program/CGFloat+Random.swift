//
//  CGFloat+Random.swift
//  Space-X Defense Program
//
//  File Created by Favero Miguel Fernando on 3/13/18.
//
//  Code by Kevin, taken from class lab
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
//    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
//        let rand = CGFloat(arc4random()) / CGFloat(UInt32.max)
//        return (rand * (max - min) + min)
//    }
    
    /// returns a value between 0 and 1.0
    ///
    /// - Returns: CGFloat
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
