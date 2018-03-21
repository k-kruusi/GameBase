//
//  Player.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/12/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import Foundation
import SpriteKit


class Player: GameObject {
    
    
    private static let playerZPositionOffset: CGFloat = 1000
    
    /// the target of the user input the spaceship will move to
    var target: CGPoint?
    
    private let velocity: CGFloat = 150
    
    /// create the player spaceship
    init() {
        super.init(imageName: "spaceship")
        self.zPosition = self.zPosition + Player.playerZPositionOffset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func posY () -> CGFloat
    {
        return position.y
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        super.update(currentTime)
        
        
        
        
        
    }
    
    
}
