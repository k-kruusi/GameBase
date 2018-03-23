//
//  GameScene.swift
//  XPaceInvaders
//
//  Created by Fonseca Barbalho Talis on 3/1/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

struct PhysicsCategory{
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Enemy        : UInt32 = 0b1  //1
    static let Projectile   : UInt32 = 0b10 //2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //UI
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var testTowerButton = TowerButton(imagedName: "buttonGreen")
    
    //arrays
    var towerArray = [Tower]()
    var updatables = [Updatable]()
    var enemyArray = [Enemy]()
    
    //scene
    let background = BaseGameObject(imagedName: "purple")
    
    //misc
    var bDraggingTower = Bool(false)
    var towerFireTimer : Timer!
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let testing : Level = Level(levelName: "level")
        
        //background
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        addChild(background)
        
        //UI buttons
        testTowerButton.isUserInteractionEnabled = false
        background.addChild(testTowerButton)
        testTowerButton.zPosition = 1
        testTowerButton.position = CGPoint(x: 0, y: -175)
        
        //testenemy
        let testEnemy = Enemy(imagedName: "meteorGrey_small2")
        background.addChild(testEnemy)
        updatables.append(testEnemy)
        
        testEnemy.zPosition = 1
        testEnemy.position = CGPoint(x: 50, y: 50)
        enemyArray.append(testEnemy)
        
        //test enemy2
        let testEnemy2 = Enemy(imagedName: "meteorGrey_small2")
        background.addChild(testEnemy2)
        updatables.append(testEnemy2)
        
        testEnemy2.zPosition = 1
        testEnemy2.position = CGPoint(x: 250, y: 50)
        enemyArray.append(testEnemy2)
        
        //timer for the towers firing
        towerFireTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ActivateTowers), userInfo: nil, repeats: true)

        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self

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
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))
            
            let t:UITouch = touches.first!
            let positionInScene = t.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if touchedNode is TowerButton && bDraggingTower == false{
                let newTower = Tower(imagedName: "enemyBlack1")
                newTower.isUserInteractionEnabled = false
                background.addChild(newTower)
                
                newTower.zPosition = 1
                newTower.position = CGPoint(x: 0, y: 0)
                
                towerArray.append(newTower)
            }
            
            if touchedNode is Tower{
                bDraggingTower = true
                touchedNode.position = positionInScene
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self))
            bDraggingTower = false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        for obj in updatables{
            obj.update(currentTime: currentTime)
        }
    }
    
    func projectileDidCollideWithEnemy(projectile: SKSpriteNode, enemy: SKSpriteNode){
        (enemy as! Enemy).takeDamage(damageTaken: 5)
        projectile.removeFromParent()
        
        enemyArray = enemyArray.filter{ !$0.bIsDead }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if((firstBody.categoryBitMask & PhysicsCategory.Enemy != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)){
            if let enemy = firstBody.node as? SKSpriteNode, let
                projectile = secondBody.node as? SKSpriteNode {
                projectileDidCollideWithEnemy(projectile: projectile, enemy: enemy)
            }
        }
    }
    
    @objc func ActivateTowers(){
        //if enemies exist
        if(!enemyArray.isEmpty){
            
            //for each tower that exists
            for x in towerArray{
                
                //find closest enemy and fire
                x.GetClosestEnemy(enemyArray: enemyArray)
                x.Fire(background: background)
            }
        }
    }
}
