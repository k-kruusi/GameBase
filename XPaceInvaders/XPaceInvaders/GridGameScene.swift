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
        if let path = Bundle.main.path(forResource: "level", ofType: "txt")
        {
            var readStringProject = ""
            do {
                readStringProject = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                var result: [String] = []
                readStringProject.enumerateLines {
                    (line, _) -> () in
                        result.append(line)
                }
                
                let levelName = result[0]
                let rowsColsArray = result[1].split(separator: " ")
                let rows : Int = Int(rowsColsArray[0])!
                let cols : Int = Int(rowsColsArray[1])!
                
                print(levelName)
                print(rows)
                print(cols)
                print(rows + cols)
            } catch let error as NSError {
                print("Failed reading from URL: \(path), Error: " + error.localizedDescription)
            }
            // trying to read from the file. I can't call the following function for some reason
            //let text = String.init(contentsOfFile: path, usedEncoding: nil)
            //print(readStringProject)
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
