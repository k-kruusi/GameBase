//
//  SpawnManager.swift
//  ElementalAcolyte
//
//  Created by Asante Kwasi G. on 3/15/18.
//  Copyright © 2018 Asante Kwasi G. All rights reserved.
//

import Foundation
import SceneKit

class SpawnManager{
    weak var scene: GameScene?
    
    let spawnArea: CGRect
    let randMin: Double
    let randMax: Double
    
    private var startTime: TimeInterval?
    private var nextSpawn: TimeInterval?
    
    let elementFactory: ElementFactory
    
    init (givenSpawnArea: CGRect, min: TimeInterval, max: TimeInterval){
        randMin = min
        randMax = max
        
        elementFactory = ElementFactory()
        
        spawnArea = givenSpawnArea
        
        nextSpawn = random(min: randMin, max: randMax)
    }
    
    func update(_ currentTime: TimeInterval) -> Element? {
        guard let scene = scene, let startTime = startTime, let nextSpawnTime = nextSpawn else{
            guard let _ = self.scene else{
                return nil
            }
            self.startTime = currentTime
            return nil
        }
        
        let deltaTime = currentTime - startTime
        guard deltaTime > nextSpawnTime else{
            return nil
        }
        
        self.nextSpawn = nextSpawnTime + random(min: randMin, max: randMax)
        
        let element = elementFactory.makeElement(elementType: nil)
        
        element.vel = CGPoint(x:-1.0, y:0)
        
        scene.addChild(element);
        
        element.position = generateSpawnPosition()
        return element
    }
    
    private func random(min: TimeInterval, max: TimeInterval) -> Double {
        return Double(CGFloat.random(min: CGFloat(min), max: CGFloat(max)))
    }
    
    private func generateSpawnPosition() -> CGPoint {
        return CGPoint(x: random(min: Double(spawnArea.minX), max: Double(spawnArea.maxX)),
                       y: random(min: Double(spawnArea.minY), max: Double(spawnArea.maxY)))
    }
}
