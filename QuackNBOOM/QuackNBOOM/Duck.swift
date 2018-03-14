//
//  Duck.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. and Benoit Neriah R. on 3/4/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// Duck inherits from GameObject with added functionality specific to the falling duck.
// There is an array of ducks and each individual duck will be placed above the top of the screen.
// When the duck is destroyed, the duck will be moved back to the initial placement rather than create and destroy all the time
// once the duck reaches the bottom of the screen, the player will lose

import Foundation
import SpriteKit

class Duck: GameObject {
    //boolean if duck is dead or not
    var isDead = false; //ducks start as 'not dead'
    var startPos = CGPoint(x: 0, y: 0)
    //speed of the duck
    let vel = CGFloat(450) //250
    
    // Sets the sprite's image
    required init(imagePath: String){
        super.init(imagePath: imagePath)
        // Proper scale for the ducks
        xScale = 0.75
        yScale = 0.75
        //randomize the start position of each duck
        self.startPos = CGPoint(x: CGFloat(arc4random_uniform(550) + 750), y: CGFloat(arc4random_uniform(200) + 1750))
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been found")
    }
    
    // Update is called every frame and holds the main functionality of the duck
    override func update(_ deltaTime: TimeInterval) {
        super.update(deltaTime)
        //check if the duck is killed
        checkDead(deltaTime)
    }
    fileprivate func checkDead(_ deltaTime: TimeInterval){
        if isDead {
            //if the duck is dead, then 'disppear', just reset the position to the top again
            position = CGPoint(x: CGFloat(arc4random_uniform(550) + 750), y: CGFloat(arc4random_uniform(800) + 1750))
            //once the duck has been reset, then the boolean will go back to being false
            isDead = false
            return
        }
        //if the duck is not dead, then the duck will continue to fall
        if(position.y < size.height / 2){
            //if the position is less than the bottom of the screen, then the player loses
            ///;w; set game over
            position = CGPoint(x: CGFloat(arc4random_uniform(550) + 750), y: CGFloat(arc4random_uniform(800) + 1750)) //temp placement, delete later
        }
        else{
            //the duck continues falling
            position.y -= vel * CGFloat(deltaTime)
        }
    }
    public func killDuck(){
        //just sets the status of the duck to true, meaning DEAD
        isDead = true
    }
}
