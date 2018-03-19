//
//  CharacterEntity.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/19/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import Foundation
import GameplayKit

class CharacterEntity : GKEntity {
    var spriteComponent: SpriteComponent?
    var body: SKPhysicsBody?
    
    init(imageName: String) {
        super.init()
    
        spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        
        // Add a physics body

        body = SKPhysicsBody(circleOfRadius: (spriteComponent?.node.texture?.size().width)! / 2, center: CGPoint(x: 0.0, y: 0.0))
        body?.affectedByGravity = true
        body?.isDynamic = true
        body?.allowsRotation = false
        body?.restitution = -1.0
        spriteComponent?.node.physicsBody = body

        addComponent(spriteComponent!)
    }
    
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
