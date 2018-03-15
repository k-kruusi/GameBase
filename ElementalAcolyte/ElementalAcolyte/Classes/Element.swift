//
//  Element.swift
//  ElementalAcolyte
//
//  Created by Asante Kwasi G. on 3/15/18.
//  Copyright © 2018 Asante Kwasi G. All rights reserved.
//

import Foundation
import SpriteKit

enum ElementType: UInt32 {
    case Fire = 0
    case Water = 1
    case Lightning = 2
    
    var image: String{
        switch self {
        case .Fire:
            return "alien"
        case .Water:
            return "alien2"
        case .Lightning:
            return "alien3"
        }
    }
}

class Element: GameObject {
    let type: ElementType
    var vel: CGPoint? /*= CGPoint(x:-1.0, y:0)*/
    var elementSpeed: CGFloat = 30.0
    
    init(type: ElementType){
        self.type = type
        super.init(imageName: type.image)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update (_ currentTime: TimeInterval){
        super.update(currentTime)
        /*guard let direction = vel?.asUnitVector else {
            print("No Direction")
            return
        }*/
        position = position.travel(inDirection: vel!, atVelocity: elementSpeed, for: deltaTime)
    }
}
