//
//  MathStuff.swift
//  Frogger
//
//  Created by Irving Waisman on 3/20/18.
//  Copyright © 2018 Irving and Zubair. All rights reserved.
//

import Foundation
import SpriteKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UInt32.max))
        
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
        
    }
    
}
