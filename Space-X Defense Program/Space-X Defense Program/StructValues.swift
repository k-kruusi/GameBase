//
//  StructValues.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/19/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import Foundation
import SpriteKit


extension GameScene {
    struct Values {
        
        //Background
        static let bgZPOS : CGFloat = -1
        static let bgScale : CGFloat = 1.43
        
        //Spaceship (Player)
        static let playerStartPosition = CGPoint(x: 220, y: 800)
        static let playerScale : CGFloat = 0.6
        static let minY: CGFloat = 313
        static let maxY: CGFloat = 1228
        
        //Projectiles
        static let actualDuration = 3              // Determine speed of the projectiles
        static let projectileScale : CGFloat = 0.1
        
        //Rockets
        static let rocketScale : CGFloat = 0.4
    }
}

