//
//  Projectile.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/12/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import Foundation
import SpriteKit

fileprivate extension Projectile{
    
    static let projectileZPositionOffset: CGFloat = 500
}


class Projectile: GameObject {
    
    
    /// create the projectiles
    init() {
        super.init(imageName: "Bullet")
        self.zPosition = Projectile.projectileZPositionOffset
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - Parameter currentTime: the current time
    override func update(_ currentTime: TimeInterval) {
        
        // in order to use the functionality provided in GameObject we need to call super here
        // since we will want to use the calculation of delta time
        super.update(currentTime)
        
        
        
        
    }
    
    
}
