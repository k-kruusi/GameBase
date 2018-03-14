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
    
    private let map = Map()
    let player = Player()
    
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
    }
    
    func ReloadLevel() {
         player.position = CGPoint(x: 100, y: 300)
        
        // Fade out
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.scene?.view?.alpha = 0.0
        }, completion: {
            (finished: Bool) -> Void in
            
            // Fade in
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.scene?.view?.alpha = 1.0
            }, completion: nil)
        })
        
        scene?.removeAllChildren()
        
        scene?.addChild(map)
        player.position = map.playerSpawn
        scene?.addChild(player)
        
        let randomIndex = Int(arc4random_uniform(UInt32(map.enemySpawns.count)))
        let pTemp = Player()
        pTemp.position = map.enemySpawns[randomIndex]
        pTemp.setScale(5)
        scene?.addChild(pTemp)
    }
    
}
