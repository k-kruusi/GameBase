//
//  GameManager.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 3/12/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import GameKit

class GameManager {
    
    // Map
    private let map = Map()
    
    // Entities
    let player = Player()
    var enemies:[Enemy] = []
    
    // Loading check
    var loading: Bool = false
    
    // UI
    var joystick: Joystick?
    var attackButton: AttackButton?
    
    // Scene
    weak var scene: GameScene?
    
    init() {
        
    }
    
    func StartGame(size: CGSize) {
        map.zPosition = -1
        map.position = CGPoint(x: size.width / 2, y: size.height / 2 )
        scene?.addChild(map)
        player.zPosition = 1
        player.position = map.playerSpawn
        player.setScale(5)
        scene?.addChild(player)
        
        //Init the Joystick
        joystick = Joystick()
        joystick?.scene = scene
        joystick?.Start(size: size)
        
        //Init the Attack Button
        attackButton = AttackButton()
        attackButton?.scene = scene
        attackButton?.Start(size: size)
        
        let randomIndex = Int(arc4random_uniform(UInt32(map.enemySpawns.count)))
        let pTemp = Enemy()
        pTemp.position = map.enemySpawns[randomIndex]
        pTemp.setScale(5)
        scene?.addChild(pTemp)
        enemies.append(pTemp)
        
        let randomIndex2 = Int(arc4random_uniform(UInt32(map.enemySpawns.count)))
        let pTemp2 = Enemy()
        pTemp2.position = map.enemySpawns[randomIndex2]
        pTemp2.setScale(5)
        scene?.addChild(pTemp2)
        enemies.append(pTemp2)
        
        let randomIndex3 = Int(arc4random_uniform(UInt32(map.enemySpawns.count)))
        let pTemp3 = Enemy()
        pTemp3.position = map.enemySpawns[randomIndex3]
        pTemp3.setScale(5)
        scene?.addChild(pTemp3)
        enemies.append(pTemp3)
    }
    
    func update(_ currentTime: TimeInterval) {
        
        player.update(currentTime)
        
        player.SetDirection(dir: (joystick?.dirVector)!)
        
        for enemy in (enemies) {
            if(!loading) {
                enemy.update(currentTime)
            }
            enemy.SetTarget(player.position)
        }
        
    }
    
    func ReloadLevel() {
        player.position = CGPoint(x: 100, y: 300)
        loading = true
        // Fade out
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.scene?.view?.alpha = 0.0
        }, completion: {
            (finished: Bool) -> Void in
            
            // Fade in
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.scene?.view?.alpha = 1.0
            }, completion: nil)
            self.loading = false
        })
        
        scene?.removeAllChildren()
        enemies.removeAll()
        
        scene?.addChild(map)
        player.position = map.playerSpawn
        scene?.addChild(player)
        
        let randomIndex = Int(arc4random_uniform(UInt32(map.enemySpawns.count)))
        let pTemp = Enemy()
        pTemp.position = map.enemySpawns[randomIndex]
        pTemp.setScale(5)
        scene?.addChild(pTemp)
        enemies.append(pTemp)
        
        let randomIndex2 = Int(arc4random_uniform(UInt32(map.enemySpawns.count)))
        let pTemp2 = Enemy()
        pTemp2.position = map.enemySpawns[randomIndex2]
        pTemp2.setScale(5)
        scene?.addChild(pTemp2)
        enemies.append(pTemp2)
        
        let randomIndex3 = Int(arc4random_uniform(UInt32(map.enemySpawns.count)))
        let pTemp3 = Enemy()
        pTemp3.position = map.enemySpawns[randomIndex3]
        pTemp3.setScale(5)
        scene?.addChild(pTemp3)
        enemies.append(pTemp3)
    }
    
}

