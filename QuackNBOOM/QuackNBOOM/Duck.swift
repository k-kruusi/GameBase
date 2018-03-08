//
//  Duck.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. and Benoit Neriah R. on 3/4/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// Duck inherits from GameObject with added functionality specific to the falling duck.

import Foundation
import SpriteKit

class Duck: GameObject {
    //boolean if duck is dead or not
    let isDead = false; //ducks start as 'not dead'
    let startPos = CGPoint(x: 1000, y: 1750)
    //speed of the duck, make faster
    let vel = CGFloat(200)
    
    // Sets the sprite's image
    required init(imagePath: String){
        super.init(imagePath: imagePath)
        zPos = 1.0
        // Proper scale for the ducks
        scale = CGSize(width: 0.75, height: 0.75)
    }
    
    // Update is called every frame and holds the main functionality of the duck
    override func update(_deltaTime: TimeInterval) {
        super.update(_deltaTime: _deltaTime)
        //check if the duck is killed
        checkDead(_deltaTime: _deltaTime)
    }
    func checkDead(_deltaTime: TimeInterval){
        if(isDead){
            //if the duck is dead, then 'disppear', just reset the position to the top again
            pos = startPos;
        }
        else{
            //if the duck is not dead, then the duck will continue to fall
            if(sprite.position.y < sprite.size.height / 2){
                //if the position is less than the bottom of the screen, then the player loses
                ///;w; set game over
            }
            else{
                //the duck is falling
                pos.y -= vel * CGFloat(_deltaTime)
            }
        }
    }
}
