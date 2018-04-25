//
//  EnemyFactory.swift
//  NinjaStar
//
//  Created by adid nissan on 2018-04-23.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import Foundation

//Enemy and the enemy factory are inspired by the ZombieConga code 
class EnemyFactory {
    
    /// create a random enemy
    func createEnemy() -> Enemy {
        return randomEnemy()
    }
    
    private func randomEnemy() -> Enemy {
        let rand: UInt32 = arc4random() % 3
        let enemyType = EnemyType(rawValue: rand)
        return Enemy(type: enemyType!)
    }
}
