//
//  PlayerEntity.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/19/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerEntity : CharacterEntity
{
    enum PlayerStates {
        case SPIN
        case JUMP
        case SHOOT
    }
    
    var scene: SKScene?
    var cameraComponent: CameraComponent?
    var facingRight = true
    var playerSpeed = 300.0
    var playerFrames: [[SKTexture]] = []
    var playerState: PlayerStates = PlayerStates.SPIN
    var playerSpinFrameSpeed = 0.2
    var playerJumpFrameSpeed = 0.35
    var playerShootFrameSpeed = 0.2
    
    convenience init(imageName: String, scale: CGFloat, background: SKNode, camera: SKCameraNode, view: SKView, scene: SKScene) {

        self.init(imageName: imageName)
        
        self.scene = scene
        // Configure sprite and physics
        spriteComponent?.node.xScale = scale
        spriteComponent?.node.yScale = scale
        spriteComponent?.node.zPosition = 10
        body?.categoryBitMask = PhysicsMasks.Player
        body?.collisionBitMask = PhysicsMasks.Enemy | PhysicsMasks.LevelBounds // player should only colide with the enemy and bounds, not its own bullets
        body?.contactTestBitMask = PhysicsMasks.Enemy // callback for when it collides with enemy
        
        // Add camera
        cameraComponent = CameraComponent(camera: camera, view: view, node: (spriteComponent?.node)!, background: background)
        addComponent(cameraComponent!)
        
        // initialize animation
        playerState = PlayerStates.SPIN
        buildPlayerAnimation()
        animatePlayerLoop(index: 0, animSpeed: playerSpinFrameSpeed)
    }
    
    func moveRight() {
        if (body?.velocity.dy == 0.0) {
            body?.velocity = CGVector(dx: playerSpeed, dy: 0.0)
            playerState = PlayerStates.SPIN
            facingRight = true
        }
        if (facingRight && (spriteComponent?.node.xScale)! < CGFloat(0)) {
            spriteComponent?.node.xScale *= -1
            body?.velocity = CGVector(dx: 0.0, dy: 0.0)
        }
    }
    
    func moveLeft() {
        if (body?.velocity.dy == 0.0) {
            body?.velocity = CGVector(dx: -playerSpeed, dy: 0.0)
            playerState = PlayerStates.SPIN
            facingRight = false
        }
        if (!facingRight && (spriteComponent?.node.xScale)! > CGFloat(0)) {
            spriteComponent?.node.xScale *= -1
            body?.velocity = CGVector(dx: 0.0, dy: 0.0)
        }
    }
    
    func jump() {
        if (body?.velocity.dy == 0.0) {
            playerState = PlayerStates.JUMP
            body?.applyForce(CGVector(dx: 0, dy: 500))
        }
    }
    
    func shoot() {
        playerState = PlayerStates.SHOOT
        spawnBullet()
    }
    
    // Animation state in here
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        switch playerState {
        case PlayerStates.SPIN:
            if let _ = spriteComponent?.node.action(forKey: "animation0") { } else {
                animatePlayerLoop(index: 0, animSpeed: playerSpinFrameSpeed)
            }
        case PlayerStates.JUMP:
            if let _ = spriteComponent?.node.action(forKey: "animation1") { } else {
                animateOnceThenSpin(index: 1, animSpeed: playerJumpFrameSpeed)
            }
        case PlayerStates.SHOOT:
            if let _ = spriteComponent?.node.action(forKey: "animation2") { } else {
                animateOnceThenSpin(index: 2, animSpeed: playerShootFrameSpeed)
            }
        }
    }

    
    func buildPlayerAnimation() {
        // Add idle animation (0 index)
        let spinAnimatedAtlas = SKTextureAtlas(named: "PSpin")
        var spinFrames: [SKTexture] = []
        
        let numSpinImages = spinAnimatedAtlas.textureNames.count
        for i in 1...numSpinImages {
            let spinTextureName = "spin\(i)"
            spinFrames.append(spinAnimatedAtlas.textureNamed(spinTextureName))
        }
        playerFrames.append(spinFrames)
        
        // Add jump animation (1 index)
        let jumpAnimatedAtlas = SKTextureAtlas(named: "PJump")
        var jumpFrames: [SKTexture] = []
        
        let numJumpImages = jumpAnimatedAtlas.textureNames.count
        for i in 1...numJumpImages {
            let jumpTextureName = "jump\(i)"
            jumpFrames.append(jumpAnimatedAtlas.textureNamed(jumpTextureName))
        }
        playerFrames.append(jumpFrames)
        
        // Add shoot animation (2 index)
        let shootAnimatedAtlas = SKTextureAtlas(named: "PShoot")
        var shootFrames: [SKTexture] = []
        
        let numShootImages = shootAnimatedAtlas.textureNames.count
        for i in 1...numShootImages {
            let shootTextureName = "shoot\(i)"
            shootFrames.append(shootAnimatedAtlas.textureNamed(shootTextureName))
        }
        playerFrames.append(shootFrames)
    }
    
    func animatePlayerLoop(index: Int, animSpeed: TimeInterval) {
        self.spriteComponent?.node.removeAllActions()
        let animateAction = SKAction.animate(with: playerFrames[index], timePerFrame: animSpeed, resize: false, restore: true)
        self.spriteComponent?.node.run(SKAction.repeatForever(animateAction), withKey:"animation\(index)")
    }
    
    func animateOnceThenSpin(index: Int, animSpeed: TimeInterval) {
        self.spriteComponent?.node.removeAllActions()
        let animateAction = SKAction.animate(with: playerFrames[index], timePerFrame: animSpeed, resize: false, restore: true)
        let backToSpinState = SKAction.run {
            self.playerState = PlayerStates.SPIN
        }
        
        let sequence = SKAction.sequence([animateAction, backToSpinState])
        self.spriteComponent?.node.run(sequence, withKey:"animation\(index)")
    }
    
    func spawnBullet() {
        let bullet = BulletEntity(shootRight: facingRight)
        
        if let sc = bullet.component(ofType: SpriteComponent.self) {
            if (facingRight) {
                sc.node.position = CGPoint(x: (spriteComponent?.node.position.x)! + 30, y: (spriteComponent?.node.position.y)!)
            } else {
                sc.node.position = CGPoint(x: (spriteComponent?.node.position.x)! - 30, y: (spriteComponent?.node.position.y)!)
            }
        }
        scene?.addChild((bullet.component(ofType: SpriteComponent.self)?.node)!)
    }
}
