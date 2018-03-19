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
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
    }
    
    func removeEmpties() {

        for ent in entities {
            let spriteNode = ent.component(ofType: SpriteComponent.self)?.node
            if (spriteNode == nil) {
                entities.remove(ent)
            }
        }
        print(entities.count)
    }
    
    func spawnBullet(shootRight: Bool, shooter: CharacterEntity) {
        let bullet = BulletEntity(shootRight: shootRight)
        
        if let spriteComponent = bullet.component(ofType: SpriteComponent.self) {
            if (shootRight) {
            spriteComponent.node.position = CGPoint(x: shooter.spriteComponent!.node.position.x + 70, y: shooter.spriteComponent!.node.position.y)
            } else {
                spriteComponent.node.position = CGPoint(x: shooter.spriteComponent!.node.position.x - 70, y: shooter.spriteComponent!.node.position.y)
            }
        }
        scene.addChild((bullet.component(ofType: SpriteComponent.self)?.node)!)
    }
    
    func spawnEnemy()
    {
        let blob = BlobEntity(imageName: "run1", scale: 1)
        if let spriteComponent = blob.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: CGFloat.random(min: scene.size.width * 0.25, max: scene.size.width * 0.75), y: scene.size.height * 0.80)
        }
        add(blob)
    }
    
}
