//
//  Map.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 3/12/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class Map : SKSpriteNode {
    
    var enemySpawns:[CGPoint] = [CGPoint(x: 800, y: 800), CGPoint(x: 700, y: 700), CGPoint(x: 900, y: 900), CGPoint(x: 900, y: 900), CGPoint(x: 900, y: 900)]
    var playerSpawn = CGPoint(x: 100, y: 300)
    
    init() {
        let texture = SKTexture(imageNamed: "map")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
