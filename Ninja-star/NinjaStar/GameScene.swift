//
//  GameScene.swift
//  NinjaStar
//
//  Created by Nissan Adid on 2/28/18.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
   
   // Buttons
   var PlayGameLabel = SKLabelNode()
   
   //background
   private let background = SKSpriteNode(imageNamed: "background1")
   
    override func didMove(to view: SKView) {
      //create the play game label
      PlayGameLabel = CreateLabel(position: CGPoint(x: 100, y: -100), name: "Play Game", fontsize: 65, color: UIColor.black)
      //create the background
      backgroundColor = SKColor.black
      background.zPosition = -1
      background.size.width = UIScreen.main.bounds.size.width
      background.size.height = UIScreen.main.bounds.size.height
      
      addChild(background)
      addChild(PlayGameLabel)
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
            let gameScene = GamePlayScene(fileNamed: "GamePlayScene")!
            gameScene.scaleMode = .aspectFill
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

