//
//  BlobEntity.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/19/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import SpriteKit
import GameplayKit

class BlobEntity: CharacterEntity {
    var facingRight = false
    var blobFrames: [SKTexture] = []
    var target: PlayerEntity?
    var aiComponent: AIComponent?
    
    convenience init(imageName: String, scale: CGFloat, target: PlayerEntity) {
        self.init(imageName: imageName)
        self.target = target
        
        spriteComponent?.node.xScale = scale
        spriteComponent?.node.yScale = scale
        
        body?.categoryBitMask = PhysicsMasks.Enemy
        body?.collisionBitMask = PhysicsMasks.LevelBounds | PhysicsMasks.Player | PhysicsMasks.Bullet
        
        body?.contactTestBitMask = PhysicsMasks.Bullet // callback when bullet hits enemy
        
        buildBlobAnimation()
        animateBlob()
        
        aiComponent = AIComponent(target: target, node: (spriteComponent?.node)!, facingRight: facingRight)
        addComponent(aiComponent!)
    //    attackPlayer()
    }
    
    func buildBlobAnimation() {
        let blobAnimatedAtlas = SKTextureAtlas(named: "Slime")
        var moveFrames: [SKTexture] = []
        
        let numImages = blobAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let blobTextureName = "slime\(i)"
            moveFrames.append(blobAnimatedAtlas.textureNamed(blobTextureName))
        }
        blobFrames = moveFrames
    }
    
    func animateBlob() {
        let animateAction = SKAction.animate(with: blobFrames, timePerFrame: 0.1, resize: false, restore: true)
        self.spriteComponent?.node.run(SKAction.repeatForever(animateAction), withKey:"movingBlob")
    }
    

    
}
