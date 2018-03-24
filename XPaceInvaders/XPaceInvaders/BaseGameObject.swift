//
//  BaseGameObject.swift
//  XPaceInvaders
//
//  Created by Mazza Matthew J. on 3/8/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import SpriteKit
import GameplayKit

class BaseGameObject : SKSpriteNode, Updatable {
    
    init(imagedName name: String)
    {
        let tex = SKTexture(imageNamed: name)
        super.init(texture: tex, color: UIColor.clear, size: tex.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: TimeInterval){
        // update logic here
    }
}
