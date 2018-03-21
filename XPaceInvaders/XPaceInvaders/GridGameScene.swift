//
//  GridGameScene.swift
//  XPaceInvaders
//
//  Created by Fonseca Barbalho Talis on 3/8/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

// https://www.raywenderlich.com/105437/implement-pathfinding-swift

import Foundation
import SpriteKit
import GameplayKit

class GridGameScene: SKScene
{
    func touchDown(atPoint pos : CGPoint) {
        if let path = Bundle.main.path(forResource: "l1", ofType: "doc")
        {
            // trying to read from the file. I can't call the following function for some reason
            //let text = String.init(contentsOfFile: path, usedEncoding: nil)
            print(path)
        }
        
        //contentsOf: path., usedEncoding: &NSUTF8StringEncoding)
        //print (text)
        //print(pos.x)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
}


protocol CollisionSupport {
    
    func collision(gameObjects:[BaseGameObject]) -> [BaseGameObject]
}

extension BaseGameObject: CollisionSupport {
    func collision(gameObjects:[BaseGameObject]) -> [BaseGameObject] {
        
        return []
    }
}
