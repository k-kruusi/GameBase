//
//  GameScene.swift
//  WarriorOfLeporia
//
//  Created by Kirupa Nijastan on 2/28/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var brabbit = SKSpriteNode()
    private var brabbitMoveFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.blue
        buildBRabbitTest()

    }
    
    func buildBRabbitTest() {
        let brabbitAnimatedAtlas = SKTextureAtlas(named: "BRabbit-Run")
        var runFrames: [SKTexture] = []
        
        let numImages = brabbitAnimatedAtlas.textureNames.count;
        for i in 1...numImages {
            let brabbitTextureName = "run\(i)"
            runFrames.append(brabbitAnimatedAtlas.textureNamed(brabbitTextureName))
        }
        brabbitMoveFrames = runFrames
        let firstFrameTexture = brabbitMoveFrames[0]
        brabbit = SKSpriteNode(texture: firstFrameTexture)
        brabbit.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(brabbit)
    }
    
    func animateBRabbitTest() {
        brabbit.run(SKAction.repeatForever(
            SKAction.animate(with: brabbitMoveFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey:"movingInPlaceBRabbit")
    }
    
    func brabbitMoveEnded() {
        brabbit.removeAllActions()
    }
    
    func moveBRabbit(location: CGPoint) {
        var multiplierForDirection: CGFloat
        let brabbitSpeed = frame.size.width / 3.0
        let moveDifference = CGPoint(x: location.x - brabbit.position.x, y: location.y - brabbit.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        let moveDuration = distanceToMove / brabbitSpeed
        

        if moveDifference.x < 0 {
            multiplierForDirection = -1.0
        } else {
            multiplierForDirection = 1.0
        }
        brabbit.xScale = abs(brabbit.xScale) * multiplierForDirection
        
        if (brabbit.action(forKey: "movingInPlaceBRabbit") == nil) {
            animateBRabbitTest()
        }
        let moveAction = SKAction.move(to: location, duration: (TimeInterval(moveDuration)))
        let doneAction = SKAction.run({ [weak self] in
            self?.brabbitMoveEnded()
        })
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        brabbit.run(moveActionWithDone, withKey:"brabbitMoving")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        moveBRabbit(location: location)
    }
}
