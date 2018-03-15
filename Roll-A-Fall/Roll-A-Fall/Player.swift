//
//  Player.swift
//  Roll-A-Fall
//
//  Created by Stefen Matias on 2018-03-08.
//  Copyright © 2018 Stefen Matias. All rights reserved.
//

import Foundation
import SpriteKit
class Player: Gameobject {
    
    var grounded: Bool
    var acceleration: CGFloat
    var velocity : CGFloat
    var jumpVelocity: CGFloat
    init (StartingPosition: CGPoint) {
        
        self.grounded = false
        self.acceleration = 0
        self.velocity = 0
        self.jumpVelocity = 25
        //References the super class (Gameobject) and initilizes it  within this class
        super.init(NameId: "Player", zPos: 2, transparency: 1)
        
        self.position = StartingPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePlayer(isJumping: Bool, isGrounded: Bool){
        
        
        //PHYSICS STUFF
        
        grounded = isGrounded;
        //Apply Gravity If Not Grounded
        if(!grounded)
        {
        acceleration = -9.8
        }
        //On The Ground Player Velocity is Zero
        if(grounded && !isJumping){
            velocity = 0
        }
        //When Player taps screen it will turn is jumping true, this will set the velocity to the jump velocity
        if(isJumping && grounded){
            
            velocity = jumpVelocity
        }
        //Adjust Velocity While Player Is Airborn based on gravity
        if(isJumping && !grounded){
            velocity = velocity + acceleration
        }
        
        
        position.y += velocity
    }
    
    
}
