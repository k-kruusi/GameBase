//
//  Spawner.swift
//  XPaceInvaders
//
//  Created by Mazza Matthew J. on 3/22/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import Foundation
import SpriteKit

class Spawner : BaseGameObject {
    
    var rate : Float
    
    init(imagedName name: String, spawnRate: Float) {
        rate = spawnRate
        super.init(imagedName: name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawnEnemy(level: Level, arrayToAppend: inout [Enemy]){
        
        let newEnemy = Enemy(imagedName: "meteorGrey_small2", level: level)
        self.scene?.addChild(newEnemy)
        
        newEnemy.zPosition = 1
        newEnemy.position = self.position
        newEnemy.activate()
        arrayToAppend.append(newEnemy)
    }
}
