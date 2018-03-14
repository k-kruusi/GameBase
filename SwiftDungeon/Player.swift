//
//  Player.swift
//  SwiftDungeon
//
//  Created by Puntillo Andrew J. on 3/12/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class Player : Entity {
    
    //The direction the player will move towards to on input
    var direction:CGPoint = CGPoint(x:0, y:0)
    //Speed of player
    private let velocity: CGFloat = 10
    //Animation
    private var textureAnimation: [SKTexture] = []
    
    init() {
        super.init(imageName: "rogue_idle_01")
        idle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if (direction.x != 0 || direction.y != 0) {
            moveTo()
        }
        position.x -= velocity * direction.x
        position.y += velocity * direction.y

    }
    
    //Idle animation
    func idle() {
        textureAnimation = [SKTexture(imageNamed: "rogue_idle_01"),
                            SKTexture(imageNamed: "rogue_idle_02"),
                            SKTexture(imageNamed: "rogue_idle_03"),
                            SKTexture(imageNamed: "rogue_idle_04"),
                            SKTexture(imageNamed: "rogue_idle_05"),
                            SKTexture(imageNamed: "rogue_idle_06"),
                            SKTexture(imageNamed: "rogue_idle_07"),
                            SKTexture(imageNamed: "rogue_idle_08"),
                            SKTexture(imageNamed: "rogue_idle_09"),
                            SKTexture(imageNamed: "rogue_idle_10")]
        
        let animationAction = SKAction.animate(with: textureAnimation, timePerFrame: 0.2)
        let repeatAction = SKAction.repeatForever(animationAction)
        
        self.run(repeatAction)
    }
    
    //Attack animation/action
    func attack() {
        textureAnimation = [SKTexture(imageNamed: "rogue_attack_01"),
                            SKTexture(imageNamed: "rogue_attack_02"),
                            SKTexture(imageNamed: "rogue_attack_03"),
                            SKTexture(imageNamed: "rogue_attack_04"),
                            SKTexture(imageNamed: "rogue_attack_05"),
                            SKTexture(imageNamed: "rogue_attack_06"),
                            SKTexture(imageNamed: "rogue_attack_07"),
                            SKTexture(imageNamed: "rogue_attack_08"),
                            SKTexture(imageNamed: "rogue_attack_09"),
                            SKTexture(imageNamed: "rogue_attack_10"),
                            SKTexture(imageNamed: "rogue_attack_11")]
        
        let animationAction = SKAction.animate(with: textureAnimation, timePerFrame: 0.08)
        //let repeatAction = SKAction.runAction(animationAction)
        
        self.run(animationAction)
    }
    
    //Move animation/action
    func moveTo() {
        textureAnimation = [SKTexture(imageNamed: "rogue_run_01"),
                            SKTexture(imageNamed: "rogue_run_02"),
                            SKTexture(imageNamed: "rogue_run_03"),
                            SKTexture(imageNamed: "rogue_run_04"),
                            SKTexture(imageNamed: "rogue_run_05"),
                            SKTexture(imageNamed: "rogue_run_06"),
                            SKTexture(imageNamed: "rogue_run_07"),
                            SKTexture(imageNamed: "rogue_run_09"),
                            SKTexture(imageNamed: "rogue_run_10")]
        
        let animationAction = SKAction.animate(with: textureAnimation, timePerFrame: 0.08)
        
        self.run(animationAction)
        
        
    }
    
    func SetDirection(dir:CGPoint) {
        direction = dir
    }
}
