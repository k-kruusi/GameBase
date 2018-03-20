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
    
    var playerSpawn = CGPoint(x: 200, y: 650)
    
    var enemySpawns:[CGPoint] = [CGPoint(x: 900, y: 800), CGPoint(x: 1000, y: 700), CGPoint(x: 1100, y: 900), CGPoint(x: 1200, y: 900), CGPoint(x: 1300, y: 900)]
    
    init() {
        let texture = SKTexture(imageNamed: "map")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
