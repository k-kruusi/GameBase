//
//  Trampoline.swift
//  ItsRainingKids
//
//  Created by Kanabe Lucas A. on 3/20/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit

class Trampoline : SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture.init(imageNamed: "trampoline")
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width*3, height: texture.size().height*3))
    }
    
    func isKidTouching(_position: CGPoint) -> Bool {
        if ((_position.x >= position.x - size.width/2) && (_position.x <= position.x + size.width/2) &&
            (_position.y >= position.y - size.height/2) && (_position.y <= position.y + size.height/2)) {
            return true
        } else {
            return false
        }
    }
    
    func handleMovement(_position: CGPoint) {
        if (touchInsideBounds(_position : _position)) {
            position.x = _position.x;
        }
    }
    
    func touchInsideBounds(_position: CGPoint) -> Bool {
        if (_position.y > position.y + 50) {
            return false
        } else {
            return true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
