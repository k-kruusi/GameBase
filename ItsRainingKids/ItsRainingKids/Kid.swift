//
//  Kid.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 3/14/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit

enum KidType {
    case Kid1
    case Kid2
    case Kid3
    case NOTAKid
    
    init?(value: Int) {
        switch value {
        case 0:
            self = KidType.Kid1
        case 1:
            self = KidType.Kid2
        case 2:
            self = KidType.Kid3
        default:
            return nil
        }
    }
}

class Kid: SKSpriteNode
{
    var type: KidType
    let unitVector = CGPoint(x: 0, y:-1)
    
    init(KidType: KidType) {
        type = KidType
        
        let texture = SKTexture.init(imageNamed: "Kid1")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateKids(){
        position = CGPoint (x: position.x + unitVector.x, y: position.y + unitVector.y)
    }
    
}
