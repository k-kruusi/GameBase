//
//  GameScene.swift
//  NinjaStar
//
//  Created by Nissan Adid on 3/03/18.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import SpriteKit
import GameplayKit

class GamePlayScene: SKScene {
   
   private var label : SKLabelNode?
   private var spinnyNode : SKShapeNode?
   
   // Buttons
   var PlayGameLabel = SKLabelNode()
   
   //create the ninja
   var ninja: Ninja?
   
   override func didMove(to view: SKView) {
      //create the play game label
      PlayGameLabel = CreateLabel(position: CGPoint(x: 200, y: 200), name: "Play Game", fontsize: 45, color: UIColor.white)
      self.addChild(PlayGameLabel)
      //set the ninja in the scene to the ninja class
      if (self.childNode(withName: "Player") as? SKSpriteNode != nil)
      {
         let temp: SKSpriteNode = (self.childNode(withName: "Player") as? SKSpriteNode)!
         ninja = Ninja(skspritenode: temp)
         ninja?.physicsBody?.isDynamic = false
         if(ninja?.physicsBody?.isDynamic == false){
            print("that worked Kappa")
         }
      }else{
         print ("That failed")
      }
      
      // Get label node from scene and store it for use later
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
      }
   }
   //Create label function
   func CreateLabel(position: CGPoint, name: String, fontsize: CGFloat, color: UIColor) ->SKLabelNode{
      let Label = SKLabelNode(text: name)
      Label.position = position
      Label.fontSize = fontsize
      Label.color = color
      return Label
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
      if let label = self.label {
         label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
      }
      
      for t in touches { self.touchDown(atPoint: t.location(in: self)) }
      
      //when the user clicks on Play Game, Switch to game scene
      for touch in touches {
         let location = touch.location(in: self)
         if PlayGameLabel.contains(location){
            let gameScene = GameScene(fileNamed: "GamePlayScene")!
            gameScene.scaleMode = .resizeFill
            let myTransition = SKTransition.moveIn(with: .up, duration: 1.0)
            self.view?.presentScene(gameScene, transition: myTransition)
            
         }
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
   
   
   override func update(_ currentTime: TimeInterval) {
      // Called before each frame is rendered
   }
}

