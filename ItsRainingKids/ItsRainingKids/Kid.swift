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
    case Kid4
    case Kid5
    
    init?(value: Int) {
        switch value {
        case 0:
            self = KidType.Kid1
        case 1:
            self = KidType.Kid2
        case 2:
            self = KidType.Kid3
        case 3:
            self = KidType.Kid4
        case 4:
            self = KidType.Kid5
        default:
            return nil
        }
    }
    
    var speed: CGFloat{
        switch self {
        case .Kid1:
            return 1
        case .Kid2:
            return 2
        case .Kid3:
            return 1
        case .Kid4:
            return 4
        case .Kid5:
            return 3
        default:
            return 1
        }
    }
    
    var imageName: String {
        switch self {
        case .Kid1:
            return "boy1"
        case .Kid2:
            return "boy2"
        case .Kid3:
            return "boy3"
        case .Kid4:
            return "girl1"
        case .Kid5:
            return "girl2"
        default:
            return "boy1"
        }
    }
    
}

class Kid: SKSpriteNode
{
    var type: KidType
    
    let unitVector = CGPoint(x: 0, y:-5)
    
    
    init(KidType: KidType) {
        type = KidType
        
        let texture = SKTexture.init(imageNamed: type.imageName)
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width*3, height: texture.size().height*3))
        speed = type.speed
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateKids(){
        position = CGPoint (x: position.x + (unitVector.x), y: position.y + (unitVector.y))
    }
    
}
