//
//  Rocket.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/20/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import Foundation
import SpriteKit

fileprivate extension Rocket{
    
    static let rocketZPositionOffset: CGFloat = 500
}


class Rocket: GameObject {
    
    
    /// create the rockets
    init(newPos: CGFloat) {
        super.init(imageName: "Rocket2")
        position = CGPoint(x: newPos , y: 0)
        self.zPosition = Rocket.rocketZPositionOffset
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        super.update(currentTime)
        
        
    }
    
    
}
