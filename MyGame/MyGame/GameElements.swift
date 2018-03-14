//
//  GameElements.swift
//  MyGame
//
//  Created by Sacchitiello Fabio on 3/7/18.
//  Copyright © 2018 Sacchitiello Fabio. All rights reserved.
//

import SpriteKit

//struct for physics body
struct CollisionBitMask {
    static let chopperCategory: UInt32 = 0x1 << 0
    static let wallCategory: UInt32 = 0x1 << 1
    static let collectibleCategory: UInt32 = 0x1 << 2
    static let groundCategory: UInt32 = 0x1 << 3
}

extension GameScene {
    
}
