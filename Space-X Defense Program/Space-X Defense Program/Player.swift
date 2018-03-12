//
//  Player.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/12/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import Foundation
import SpriteKit


class Player: GameObject {
    
    
    private static let playerZPositionOffset: CGFloat = 1000
    
    /// the target of the user input the spaceship will move to
    var target: CGPoint?
    
    private let velocity: CGFloat = 150
    
    /// create the player spaceship
    init() {
        super.init(imageName: "spaceship")
        self.zPosition = self.zPosition + Player.playerZPositionOffset
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
        
        
        
        
        // move to target
        //self.position = position.travel(inDirection: dVector.asUnitVector, atVelocity: velocity, for: deltaTime)
    }
    
    
}
