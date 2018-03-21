//
//  MenuScene.swift
//  Search For The Light
//
//  Created by Kramarczyk Jessica N. on 3/21/18.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    var starfeild:SKEmitterNode!
    var newGameButtonNode:SKSpriteNode!
    
    override func didMove(to view: SKView){
       /* for child in children {
            if child is SKEmitterNode {
                print("foundIt")
            }
            
        }*/
        starfeild = self.childNode(withName: "starfeild") as! SKEmitterNode
        starfeild.advanceSimulationTime(10) //screen should be filled with stars by then
        
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
 
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at:location)
            
            if nodesArray.first?.name == "newGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
                starfeild.removeFromParent()
            }
            
            
        }
}
}
