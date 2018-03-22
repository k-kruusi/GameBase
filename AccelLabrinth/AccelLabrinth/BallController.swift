//
//  BallController.swift
//  AccelLabrinth
//
//  Created by Rasmussen Darren K. on 3/8/18.
//  Copyright © 2018 Darren/Marya. All rights reserved.
// created for everthing pertaining to the ball object

import Foundation
import SpriteKit

class BallObject: GameObject {
    /// a static offset value to add to any Ball so it appears on top of other sprites
    private static let BallZPosition: CGFloat = 1000
    
    
    /// the target of the user input the ball should walk to or nil
    var target: CGPoint?
    
    private let velocity: CGFloat = 150
    
    init() {
        super.init(imageName: "circle")
        self.zPosition = self.zPosition + BallObject.BallZPosition
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// update method to inject updates into the crazy catlady during the game loop
    ///
    /// - Parameter currentTime: the current time
    override func update(_ currentTime: TimeInterval) {
        
        // in order to use the functionality provided in GameObject we need to call super here
        // since we will want to use the calculation of delta time
        super.update(currentTime)
        
        // if no target exit early
        guard let target = target else {
            return
        }
        
        // check out CGPoint+VectorMath since you cannot subtract CGPoints by default
        let dVector = target - position
        
        guard dVector.length > 5 else {
            // exit early if she has arrived at her position
            // and remove her target so she stops trying to walk to it
            self.target = nil
            return
        }
        
        // move to target
        self.position = position.travel(inDirection: dVector.asUnitVector, atVelocity: velocity, for: deltaTime)
    }
}
