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
    
    @objc func spawnEnemy(bg: BaseGameObject, arrayToAppend: [Enemy]){
        
        print("spawn!")
        
        let newEnemy = Enemy(imagedName: "meteorGrey_small2")
        bg.addChild(newEnemy)
        
        newEnemy.zPosition = 1
        newEnemy.position = self.position
//        arrayToAppend.append(newEnemy)
    }
}
