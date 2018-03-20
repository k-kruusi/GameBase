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
   
   //create the ninja
   private let ninja = Ninja()
   
   //background
   private let background = SKSpriteNode(imageNamed: "GameBackground")
   
   //Ground
   private let ground = SKSpriteNode()
   
   override func didMove(to view: SKView) {
      super.didMove(to: view)
      
      
      //set the ninja  position in the scene
      ninja.position = CGPoint(x: 100, y: 100)
      
      //set-up the background position and size to fill the window
      backgroundColor = SKColor.black
      background.zPosition = -1
      background.size.width = UIScreen.main.bounds.size.width
      background.size.height = UIScreen.main.bounds.size.height
      addChild(background)
      
      //Set-up the ground so that the player does not fall through the ground. Also place it on the same zposition as the player
      ground.color = UIColor.clear
      ground.zPosition = 1
      let sizeOfGround = CGSize(width: UIScreen.main.bounds.size.width, height: 1)
      ground.size.width = sizeOfGround.width
      ground.size.height = sizeOfGround.height
      ground.position.y = -100
      ground.physicsBody = SKPhysicsBody(rectangleOf: sizeOfGround)
      ground.physicsBody?.affectedByGravity = false
      ground.physicsBody?.isDynamic = false
      addChild(ground)
      //add ninja as a child of the scene
      addChild(ninja)
      ninja.zPosition = 1
      ninja.position = CGPoint(x: 0, y: 0)
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
         // let location = touch.location(in: self)
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

