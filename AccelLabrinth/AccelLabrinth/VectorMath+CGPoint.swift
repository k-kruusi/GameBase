//
//  VectorMath+CGPoint.swift
//  AccelLabrinth
//
//  Created by Rasmussen Darren K. on 3/22/18.
//  Copyright © 2018 Darren/Marya. All rights reserved.
//

//
//  CGPoint+VectorMath.swift
//  ZombieConga
//
//  Created by Kevin Kruusi on 2018-02-15.
//  Copyright © 2018 kevin. All rights reserved.
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
    func travel(inDirection direction: CGPoint, atVelocity velocity: CGFloat, for time: TimeInterval) -> CGPoint {
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
    
    /// subtract one CGPoint from another
    ///
    /// - Parameters:
    ///   - left: the left side of the subtraction
    ///   - right: the right side of the subtraction
    /// - Returns: the result
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
}

