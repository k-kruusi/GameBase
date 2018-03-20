//
//  CGPoint+VectorMath.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/19/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import SpriteKit

// MARK: - Vector Math extention
extension CGPoint {
    
    // get the length of self
    var length: CGFloat {
        return sqrt( x * x + y * y)
    }
    
    /// get the unit vector of self
    var asUnitVector: CGPoint {
        return divide(by: length)
    }
    
    /// divide self by a scalar
    ///
    /// - Parameter by: a CGFloat scalar number
    /// - Returns: the divided point
    func divide(by: CGFloat) -> CGPoint {
        return CGPoint(x: self.x / by, y: y / by)
    }
    
    /// Simple movement function that starts where you currently are
    ///
    /// - Parameters:
    ///   - direction: what direction you wish to travel should be a unit vector
    ///   - velocity: the velocity you wish to travel
    ///   - time: the time you wish to travel
    /// - Returns: the distance you traveled from where you currently are
    func travel(in direction: CGPoint, at velocity: CGFloat, for time: TimeInterval) -> CGPoint {
        return CGPoint(x: velocity * CGFloat(time) * direction.x + x, y: velocity * CGFloat(time) * direction.y + y)
    }
    
    /// add two CGPoints together
    ///
    /// - Parameters:
    ///   - left: the left side of the addition
    ///   - right: the right side of the addition
    /// - Returns: the result
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
    
    /// subtract one CGPoint from another
    ///
    /// - Parameters:
    ///   - left: the left side of the subtraction
    ///   - right: the right side of the subtraction
    /// - Returns: the result
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    /// A simple check to see if you have reached your target by compairing direction vectors
    ///
    /// - Parameter target: the next iteration of your target direction
    /// - Returns: true or false you your target vector has mutated in another direction
    func didOvershoot(next target: CGPoint) -> Bool {
        if (self.x > 0) == (target.x > 0) && (self.y > 0) == (target.y > 0) {
            return true
        }
        return false
    }
    
    /// Returns the facing angle of a given direction in radians
    ///
    /// - Parameter direction: the direction you wish to point
    /// - Returns: the angel in radians
    static func facingAngle(_ direction: CGPoint) -> CGFloat {
        return CGFloat( atan2( Double(direction.y), Double(direction.x)))
    }
}
