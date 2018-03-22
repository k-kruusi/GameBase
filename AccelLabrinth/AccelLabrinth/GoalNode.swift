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
    //infront of ball
    private static let exitZPosition: CGFloat = 1001
    init() {
        super.init(imageName: "star")
        self.zPosition = self.zPosition + GoalObject.exitZPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //called on goal hitting button
    func Victory() {
        //reach here by ball meeting endpoint you win
        var transition:SKTransition = SKTransition.fade(withDuration: 1)
        
    }
}
