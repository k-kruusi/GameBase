//
//  SpawnManager.swift
//  NinjaStar
//
//  Created by adid nissan on 2018-04-23.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import Foundation
import SpriteKit

//borrowed and inspired by the zombieConga gameobject class
class SpawnManager {
    
    weak var scene : SKScene?
    
    let spawnArea : CGRect
    let randMin : Double
    let randMax : Double
    
    // MARK: Private vars since they are never changed outside of this class.
    private var startTime : TimeInterval?
    private var nextSpawnTime : TimeInterval?
    
    private let enemyFactory : EnemyFactory
    
    /// init for the spawn manager
    init(givenSpawnArea : CGRect, min : TimeInterval, max : TimeInterval) {
        randMin = min
        randMax = max
        enemyFactory = EnemyFactory()
        spawnArea = givenSpawnArea
        nextSpawnTime = random(min: CGFloat(randMin), max: CGFloat(randMax))
    }
    
    
    /// update method
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
        
        scene.addChild(myEnemy);
        
        myEnemy.position = generateSpawnPosition()
        
        return myEnemy
        
    }
    
    private func generateSpawnPosition() -> CGPoint {
        return CGPoint(x: random(min: spawnArea.minX, max: spawnArea.maxX),
                       y: random(min: spawnArea.minY, max: spawnArea.maxY))
    }
    
    /// random returns a random Double
    private func random(min: CGFloat, max: CGFloat) -> Double {
        let rand = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return Double(rand * (max - min) + min)
    }
}
