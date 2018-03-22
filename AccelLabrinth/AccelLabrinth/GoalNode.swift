//
//  GoalNode.swift
//  AccelLabrinth
//
//  Created by Rasmussen Darren K. on 3/22/18.
//  Copyright © 2018 Darren/Marya. All rights reserved.
// made to handle hit detection between itself and the player

import Foundation
import SpriteKit

class GoalObject: GameObject {
    private static let exitZPosition: CGFloat = 1000
    init() {
        super.init(imageName: "star")
        self.zPosition = self.zPosition + GoalObject.exitZPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func Victory() {
        //reach here by ball meeting endpoint you win
        var transition:SKTransition = SKTransition.fade(withDuration: 1)
        
    }
}
