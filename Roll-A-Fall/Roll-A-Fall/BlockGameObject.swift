//
//  BlockGameObject.swift
//  Roll-A-Fall
//
//  Created by Stefen Matias on 2018-03-06.
//  Copyright © 2018 Stefen Matias. All rights reserved.
//

import Foundation
import SpriteKit
class BlockGameObject: Gameobject {
    
    var type: String
    var blockName: String
    init (StartingPosition: CGPoint, BlockType: String) {
        
        self.type = BlockType
        
        
        switch type {
        case "Base":
            self.blockName = "block01"
        default:
            self.blockName = "block01"
        }
        
        //References the super class (Gameobject) and initilizes it  within this class
        super.init(NameId: blockName, zPos: 2, transparency: 1)
        
        self.position = StartingPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePlatform(currentPlayerMovementSpeed: CGFloat){
        //Update Platform Based on Players current movement speed
    }
}

