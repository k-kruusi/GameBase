//
//  SpawnManager.swift
//  NinjaStar
//
//  Created by adid nissan on 2018-04-23.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import Foundation
import SpriteKit


/// SpawnManager created in class superior than the original one.
class SpawnManager {
    
    // we will be giving it our GameScene, but since this class doesn't need the additional
    // functionality provided by GameScene we can reduce this to just SKScene or SKNode
    // limiting the scope
    // weak because we dont need a strong reference
    weak var scene : SKScene?
    
    // as "let" constants these can never be changed after creation but we can still reference them
    let spawnArea : CGRect
    let randMin : Double
    let randMax : Double
    
    // MARK: Private vars since they are never changed outside of this class.
    private var startTime : TimeInterval?
    private var nextSpawnTime : TimeInterval?
    
    private let enemyFactory : EnemyFactory
    
    /// init for the spawn manager
    ///
    /// - Parameters:
    ///   - givenSpawnArea: the area you wish the zombies to spawn in
    ///   - min: the minimum time interval for a zombie to spawn
    ///   - max: the maximum time interval for a zombie to spawn
    init(givenSpawnArea : CGRect, min : TimeInterval, max : TimeInterval) {
        randMin = min
        randMax = max
        enemyFactory = EnemyFactory()
        spawnArea = givenSpawnArea
        // nextSpawnTime is initalized last due to the other values needing to be initialized before calling
        // self even though self is not explicitly used.
        nextSpawnTime = random(min: CGFloat(randMin), max: CGFloat(randMax))
    }
    
    
    /// update time method to be called in the scene
    ///
    /// - Parameter time: current time
    /// - Returns: a zombie or nothing
    func update(time: TimeInterval) -> Enemy? {
        guard let scene = scene, let startTime = startTime, let nextSpawnTime = nextSpawnTime else {
            guard let _ = self.scene else {
                return nil
            }
            // set the start time and exit the loop since we wont be able to calculate the delta this time
            self.startTime = time;
            return nil;
        }
        
        // second time the loop is run we can now
        // calculate the delta
        let deltaTime = time - startTime;
        
        guard deltaTime > nextSpawnTime else {
            // exit early if the delta is less than the next spawn time
            return nil
        }
        
        // update the time for the next zombie spawn
        self.nextSpawnTime = nextSpawnTime + random(min: CGFloat(randMin), max: CGFloat(randMax));
        
        // spawn the enemy
        let myEnemy = enemyFactory.createEnemy();
        
        // crude but effective at moving the enemies in the right direction
        myEnemy.vel = CGPoint(x: 1,y: 0)
        
        // adding the zombie to the game scene
        scene.addChild(myEnemy);
        
        // moving the zombie to the spawn area
        myEnemy.position = generateSpawnPosition()
        
        // returning a strong refernce to the zombie incase more is wished to be done
        return myEnemy
        
    }
    
    // MARK: Private Methods
    
    /// generateSapwnPosition
    ///
    /// - Returns: a position inside the spawn area
    private func generateSpawnPosition() -> CGPoint {
        return CGPoint(x: random(min: spawnArea.minX, max: spawnArea.maxX),
                       y: random(min: spawnArea.minY, max: spawnArea.maxY))
    }
    
    /// random returns a random Double between two time intervals
    ///
    /// - Parameters:
    ///   - min: the minimum time interval
    ///   - max: the maximum time interval
    /// - Returns: the random time
    //random
    private func random(min: CGFloat, max: CGFloat) -> Double {
        let rand = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return Double(rand * (max - min) + min)
    }
}
