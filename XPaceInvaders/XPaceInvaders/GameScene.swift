//
//  GameScene.swift
//  XPaceInvaders
//
//  Created by Fonseca Barbalho Talis on 3/1/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var testTower = Tower(imagedName: "enemyBlack1")
    var testEnemy = Enemy(imagedName: "meteorGrey_small2")
    var towerArray = [Tower]()
    var updatables = [Updatable]()
    
    let background = BaseGameObject(imagedName: "purple")
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //background
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        addChild(background)
        
        
        //testtower
        testTower.isUserInteractionEnabled = false
        background.addChild(testTower)
        towerArray.append(testTower)
        updatables.append(testTower)
        
        testTower.zPosition = 1
        testTower.position = CGPoint(x: 0, y: 0)
        
        //testenemy
        background.addChild(testEnemy)
        updatables.append(testEnemy)
        
        testEnemy.zPosition = 1
        testEnemy.position = CGPoint(x: 50, y: 50)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        testTower.Fire()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))
            
            let t:UITouch = touches.first!
            let positionInScene = t.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if touchedNode is Tower{
            //    let newTower = BaseGameObject(imagedName: "enemyBlack1")
            //    newTower.isUserInteractionEnabled = false
            //    background.addChild(newTower)
                
            //    newTower.zPosition = 1
            //    newTower.position = CGPoint(x: 0, y: 0)
                
            //    towerArray.append(newTower)
                
                touchedNode.position.x = positionInScene.x
                touchedNode.position.y = positionInScene.y
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        for obj in updatables{
            obj.update(currentTime: currentTime)
        }
    }
}
