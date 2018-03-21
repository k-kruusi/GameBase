//
//  AttackButton.swift
//  SwiftDungeon
//
//  Created by Puntillo Andrew J. on 3/19/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class AttackButton: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "attack_button")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(size:CGSize) {
        position = CGPoint(x: size.width - 400, y: 400)
        alpha = 0.5
        zPosition = CGFloat(10)
    }
    
    func onClick(loc:CGPoint) -> Bool {
        if (frame.contains(loc)) {
                return true
        }
        return false
    }
    
}
