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
    private let velocity: CGFloat = 300
    //Animation
    private var textureAnimation: [SKTexture] = []
    //Check if already animating (Prevent spamming)
    var isAnimating:Bool = false
    //SKAction for animation
    var animationAction:SKAction = SKAction()
    //Timer for animation
    var animTimer:Double = 0
    
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
        position.x -= velocity * direction.x * CGFloat(deltaTime)
        position.y += velocity * direction.y * CGFloat(deltaTime)
        
        //If it is animating, increment the animTimer until it has reached the total duration of the SKAction's animation time
        //Once the time has exceeded the duration, is is no longer animating
        if (isAnimating) {
            animTimer += deltaTime
            if (animTimer > animationAction.duration) {
                isAnimating = false
                animTimer = 0
            }
        }

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
        
        animationAction = SKAction.animate(with: textureAnimation, timePerFrame: 0.2)
        let repeatAction = SKAction.repeatForever(animationAction)
        
        self.run(repeatAction)
    }
    
    //Attack animation/action
    func attack() {
        if (!isAnimating) {
            isAnimating = true
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
            
            animationAction = SKAction.animate(with: textureAnimation, timePerFrame: 0.08)
            self.run(animationAction)
        }
    }
    
    //Move animation/action
    func moveTo() {
        //If already animating, then do not enter again until animation is complete
        if (!isAnimating) {
            isAnimating = true
            textureAnimation = [SKTexture(imageNamed: "rogue_run_01"),
                                SKTexture(imageNamed: "rogue_run_02"),
                                SKTexture(imageNamed: "rogue_run_03"),
                                SKTexture(imageNamed: "rogue_run_04"),
                                SKTexture(imageNamed: "rogue_run_05"),
                                SKTexture(imageNamed: "rogue_run_06"),
                                SKTexture(imageNamed: "rogue_run_07"),
                                SKTexture(imageNamed: "rogue_run_09"),
                                SKTexture(imageNamed: "rogue_run_10")]
            
            animationAction = SKAction.animate(with: textureAnimation, timePerFrame: 0.08)
            self.run(animationAction)
        }
    }
    
    func SetDirection(dir:CGPoint) {
        direction = dir
    }
}
