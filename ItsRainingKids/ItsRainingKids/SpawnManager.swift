//
//  SpawnManager.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 3/14/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit

class SpawnManager
{
    weak var sceneRef: GameScene?
    var spawnLocation: CGPoint
    var standardDeviation: UInt32
    
    let FactoryKid = KidFactory()
    
    init(sRef: GameScene) {
        sceneRef = sRef
        spawnLocation = CGPoint(x: sceneRef!.size.width/2, y: sceneRef!.size.height)
        standardDeviation = UInt32(sceneRef!.size.width/4 - sceneRef!.size.width/10)
        //print(standardDeviation)
    }
    
    func spawnKid() -> Kid{
        let newKid = FactoryKid.createKid(specificType: nil)
        var rand = Int(arc4random_uniform(standardDeviation))
        let absolute = Int(arc4random_uniform(2))
        if (absolute >= 1){
            rand = -1 * rand
        }
        //newKid.position = CGPoint(x: CGFloat(rand), y:spawnLocation.y)
        newKid.position = CGPoint(x: spawnLocation.x + CGFloat(rand), y: spawnLocation.y)
        newKid.topOfScreen.y = newKid.position.y + 50
        return newKid
    }
    
}
