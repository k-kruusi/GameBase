//
//  GameScene.swift
//  ElementalAcolyte
//
//  Created by Asante Kwasi G. on 3/8/18.
//  Copyright © 2018 Asante Kwasi G. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /*private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?*/
    
    var starfield:SKEmitterNode!
    
    private let player = Acolyte()
    //private let element = Element(type: ElementType.Lightning)
    private var spawnManager: SpawnManager?
    private var elements: [Element] = []
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    override func didMove(to view: SKView) {
        /*// Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }*/
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height)
        starfield.advanceSimulationTime(10)
        starfield.zPosition = -1
        self.addChild(starfield)
        
        /*player = SKSpriteNode(imageNamed: "shuttle")
        player.position = CGPoint(x:self.frame.size.width / 2 - self.frame.size.width / 2, y: -self.frame.size.height / 2 + player.frame.size.height)
        self.addChild(player)*/
        player.zPosition = 1
        player.position = CGPoint (x:0+player.frame.size.width, y:self.frame.size.height/2)
        addChild(player)
        
        /*element.zPosition = 1
        element.position = CGPoint(x:self.frame.width/2, y:self.frame.size.height/2)
        addChild(element)*/
        spawnManager = SpawnManager(givenSpawnArea: CGRect(x:self.frame.width, y:0, width: 100, height: self.frame.height), min: 0.5, max: 1)
        spawnManager?.scene = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x:0+scoreLabel.frame.size.width-30, y: self.frame.size.height - 50)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        score = 0
        self.addChild(scoreLabel)
    }
    
    deinit {
        elements = []
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        // Called before each frame is rendered
        //element.update(currentTime)
        
        var toBeDeleted : [Int] = []
        
        for ele in elements {
            ele.update(currentTime)
            
            let acolyte = ele.collision(items: [player]).first
            if let _ = acolyte{
                print("Collision")
                ele.removeFromParent()
                toBeDeleted.append(elements.index(of: ele)!)
            }
        }
        
        deleteElement(toBeDeleted)
        
        guard let element = spawnManager?.update(currentTime) else {
            return
        }
        
        elements.append(element)
    }
    
    private func deleteElement(_ elementIndexes: [Int]) {
        let reversedIndexes = elementIndexes.reversed()
        for index in reversedIndexes{
            elements.remove(at: index)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.green
         self.addChild(n)
         }*/
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.blue
         self.addChild(n)
         }*/
    }
    
    func touchUp(atPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.red
         self.addChild(n)
         }*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*if let label = self.label {
         label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
         }
         
         for t in touches { self.touchDown(atPoint: t.location(in: self)) }*/
        for ele in elements {
            ele.elementSpeed = ele.elementSpeed + CGFloat(5.0)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
