//
//  EnemySpawner.swift
//  Space-X Defense Program
//
//  Created by Favero Miguel Fernando on 3/13/18.
//  Copyright © 2018 Miguel Haifeng. All rights reserved.
//

import Foundation
import SpriteKit


class EnemySpawner
{
    
    func makeEnemyPlane(enemyPlaneType: EnemyPlaneType?) -> EnemyPlane
    {
        guard let enemyPlaneType = enemyPlaneType else
        {
            return randomEnemyPlane()
        }
        
        let plane = EnemyPlane(type: enemyPlaneType, imageName: "enemyPlane-1")
        plane.size = CGSize(width: plane.size.width/8, height: plane.size.width/8)
        return plane
    }
    
    
    private func randomEnemyPlane() -> EnemyPlane
    {
        let rand: UInt32 = arc4random() % 3
        let enemyPlaneType = EnemyPlaneType(rawValue: rand)
        
        let plane = EnemyPlane(type: enemyPlaneType!, imageName: "enemyPlane-1")
        plane.size = CGSize(width: plane.size.width/8, height: plane.size.width/8)
        plane.zRotation = CGFloat(Double.pi / 2)
        return plane
    }
    
}

class EnemySpawnManager
{
    weak var scene: SKScene?
    
    
    let spawnArea: CGRect
    let randMin: Double
    let randMax: Double
    
    private var startTime: TimeInterval?
    private var nextSpawnTime: TimeInterval?
    
    
    private let enemySpawner : EnemySpawner
    
    init(givenSpawnArea: CGRect, min: TimeInterval, max: TimeInterval)
    {
        randMin = min
        randMax = max
        spawnArea = givenSpawnArea
        
        enemySpawner = EnemySpawner()
        
        nextSpawnTime = random(min: randMin, max: randMax)
    }
    
    func update(time: TimeInterval) -> EnemyPlane?
    {
        guard let scene = scene, let startTime = startTime, let nextSpawnTime = nextSpawnTime else
        {
            guard let _ = self.scene else{
                return nil
            }
            self.startTime = time
            return nil
        }
        
        let deltaTime = time - startTime
        
        guard deltaTime > nextSpawnTime else
        {
            return nil
        }
        
        self.nextSpawnTime = nextSpawnTime + random(min: randMin, max: randMax)
        
        //nil type because we want to make it random, integrated into the enum already
        let enemyPlane = enemySpawner.makeEnemyPlane(enemyPlaneType: nil)
        
        enemyPlane.vel = CGPoint(x: 1, y: 0)
        
        scene.addChild(enemyPlane)
        
        enemyPlane.position = generateSpawnPosition()
        
        return enemyPlane
    }
    
    private func generateSpawnPosition() -> CGPoint
    {
        return CGPoint(x: random(min: Double(spawnArea.minX), max: Double(spawnArea.maxX)),
                       y: random(min: Double(spawnArea.minY), max: Double(spawnArea.maxY)))
    }
    
    
    private func random(min: TimeInterval, max: TimeInterval) -> Double
    {
        return Double(CGFloat.random(min: CGFloat(min), max: CGFloat(max)))
    }
}
