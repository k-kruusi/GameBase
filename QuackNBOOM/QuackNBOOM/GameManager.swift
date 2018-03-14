//
//  GameManager.swift
//  QuackNBOOM
//
//  Created by Benoit Neriah R. on 3/13/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// Game Manager handles the killing of ducks. When an explosion touches
// a duck within a range, the duck is killed.

import Foundation
import SpriteKit

class GameManager {
    let duckController = DuckController()
    let bombController = BombController()
    
    
    
    // Update - runs once every frame. Runs all of the ducks and bombs' updates.
    //      Also checks if a duck has touched an explosion
    // - Parameter deltaTime: the amount of time between each frame
    func update(_ deltaTime: TimeInterval){
        duckController.update(deltaTime)
        bombController.update(deltaTime)
        
        // Check if a duck touched an explosion
        for duck in duckController.getAllDucks(){
            for bomb in bombController.getAllBombs(){
                
                // Only check bombs which are exploded
                if(bomb.isExploded()){
                    // If the duck is within range of the explosion, kill the duck
                    if(duck.position.x >= bomb.position.x - bomb.explosionRange
                            && duck.position.y >= bomb.position.y - bomb.explosionRange
                            && duck.position.x <= bomb.position.x + bomb.explosionRange
                            && duck.position.y <= bomb.position.y + bomb.explosionRange){
                        duck.killDuck()
                    }
                }
            }
        }
    }
    
    
    // Shoots a bomb at the location
    //
    // - Parameter location: the position of the tap on the screen
    public func shootBomb(location: CGPoint){
        bombController.shootBomb(location: location)
    }
    
    // Returns all of the bombs
    //
    public func getAllBombs()->Array<Bomb>{
        return bombController.getAllBombs()
    }
    
    // Returns all of the ducks
    //
    public func getAllDucks()->Array<Duck>{
        return duckController.getAllDucks()
    }
    
    // Returns if the game is over - calculated by if a duck hits the bottom of the screen
    //
    public func isGameOver()->Bool{
        return duckController.isGameOver()
    }
}
