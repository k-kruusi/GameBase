//
//  Acolyte.swift
//  ElementalAcolyte
//
//  Created by Asante Kwasi G. on 3/15/18.
//  Copyright © 2018 Asante Kwasi G. All rights reserved.
//

import Foundation
import SpriteKit

enum AcolyteElement: UInt32{
    case Fire = 0
    case Water = 1
    case Lightning = 2
    case Netural = 3
}
class Acolyte: GameObject {
    private static let acolyteZposOffset: CGFloat = 1000
    let element: AcolyteElement
    
    init(element: AcolyteElement){
        self.element = element
        super.init(imageName: "shuttle")
        self.zPosition = self.zPosition + Acolyte.acolyteZposOffset
        self.zRotation = CGFloat(-Double.pi / 2)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval){
        super.update(currentTime)
    }
}
