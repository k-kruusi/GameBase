//
//  Maths.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/20/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import Foundation
import SpriteKit

extension CGPoint {
    
    //adding CGPoints
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    //subtracting CGPoints
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    //multiplying CGPoints by a scalar
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    //dividing CGPoints by a scalar
    static func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / scalar, y: point.y / scalar)
    }
    
    //square root of a CGFloat
    #if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
    }
    #endif
    
    //the magnitude of a vector
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    //the normalized of a unit vector
    func normalized() -> CGPoint {
        return self / length()
    }
    
    /// get the unit vector of self
    var asUnitVector: CGPoint {
        return divide(by: length())
    }
    
    //returns the facing angle of the given direction in rads
    static func facingAngle(_ direction: CGPoint) -> CGFloat
    {
        return CGFloat(atan2(Double(direction.y), Double(direction.x)))
    }
}

extension CGFloat
{
    //random number between a min and max CGFloat
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        let rand = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return (rand * (max - min) + min)
    }
}
