//
//  EntityManager.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/19/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    
    var entities = Set<GKEntity>()
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
        
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            print("deleeeting!")
            spriteNode.removeAllActions()
            spriteNode.removeFromParent()
        }
        entities.remove(entity)
    }
    
    func remove(_ node: SKNode) {
        for ent in entities {
            let spriteNode = ent.component(ofType: SpriteComponent.self)?.node
            if (spriteNode == node) {
                self.remove(ent)
            }
        }
        print(entities.count)
    }
    
    func spawnBullet(shootRight: Bool, shooter: CharacterEntity) {
        let bullet = BulletEntity(shootRight: shootRight)
        
        if let spriteComponent = bullet.component(ofType: SpriteComponent.self) {
            if (shootRight) {
            spriteComponent.node.position = CGPoint(x: shooter.spriteComponent!.node.position.x + 30, y: shooter.spriteComponent!.node.position.y)
            } else {
                spriteComponent.node.position = CGPoint(x: shooter.spriteComponent!.node.position.x - 30, y: shooter.spriteComponent!.node.position.y)
            }
        }
     //   scene.addChild((bullet.component(ofType: SpriteComponent.self)?.node)!)
        add(bullet)
    }
    
    func spawnEnemy(ptarget: PlayerEntity)
    {
        let blob = BlobEntity(imageName: "slime1-s", scale: 1, target: ptarget)
        if let spriteComponent = blob.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: CGFloat.random(min: -450.0, max: 450.0), y: 100.0)
        }
        self.add(blob)
    }
    
}
