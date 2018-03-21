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
    
    var cameraComponent: CameraComponent?
    var facingRight = true
    var playerSpeed = 300.0
    var playerFrames: [[SKTexture]] = []
    var playerState: PlayerStates = PlayerStates.SPIN
    var playerStateHasChanged: Bool = false
    var playerSpinFrameSpeed = 0.2
    var playerJumpFrameSpeed = 0.35
    
    convenience init(imageName: String, scale: CGFloat, background: SKNode, camera: SKCameraNode, view: SKView) {
        self.init(imageName: imageName)
        
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
        default:
            print("unknown state")
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
    }
    
    func animatePlayerLoop(index: Int, animSpeed: TimeInterval) {
        self.spriteComponent?.node.removeAllActions()
        let animateAction = SKAction.animate(with: playerFrames[index], timePerFrame: animSpeed, resize: false, restore: true)
        self.spriteComponent?.node.run(SKAction.repeatForever(animateAction), withKey:"animation\(index)")
    }
    
    func animateOnceThenSpin(index: Int, animSpeed: TimeInterval) {
        self.spriteComponent?.node.removeAllActions()
        let animateAction = SKAction.animate(with: playerFrames[index], timePerFrame: animSpeed, resize: false, restore: true)
        let spinAction = SKAction.animate(with: playerFrames[0], timePerFrame: playerSpinFrameSpeed, resize: false, restore: true)
        let spinRepeat = SKAction.repeatForever(spinAction);
        
        let sequence = SKAction.sequence([animateAction, spinRepeat])
        self.spriteComponent?.node.run(sequence, withKey:"animation\(index)")
    }
    
}
