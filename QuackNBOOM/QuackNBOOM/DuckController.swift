//
//  DuckController.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. on 3/8/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//

import Foundation
import SpriteKit

class DuckController{
    //just have one duck for now then have about 3-5 later
    let maxDucks = 5
    var ducks:[Duck] = []
    
    required init(){
        //set the initial positions of the ducks above the screen
        var i = 0
        while (i < maxDucks){
            //appends the ducks created
            let duck = Duck(imagePath: "Duck")
            //duck.position = CGPoint(x: 1025, y: 1750) //temp values, change later
            ducks.append(duck)
            i += 1
        }
    }
    
    //returns all ducks on current controller
    public func getAllDucks()->Array<Duck>{
        return ducks
    }
    
    //update all of the ducks
    func update(_ deltaTime: TimeInterval){
        //update all of the ducks in the array
        for duck in ducks{
            duck.update(deltaTime)
        }
    }
    
    func isGameOver()->Bool{
        //check which duck has reached the bottom of the screen
        for duck in ducks{
            if (duck.gameOver){
                //if any of the ducks reach the bottom of the screen, then it is GAME OVER!!
                for duck in ducks{
                    duck.gameOver = true
                }
                return true
            }
        }
        return false
    }
    
    func resetDucks(){
        //goes through all of the ducks in order to set all of their positions to be at the top of the screen for the new game play
        for duck in ducks{
            duck.position = CGPoint(x: CGFloat(arc4random_uniform(550) + 750), y: CGFloat(arc4random_uniform(800) + 1750))
            duck.isDead = false
            duck.gameOver = false
        }
    }
}
