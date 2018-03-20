//
//  AttackButton.swift
//  SwiftDungeon
//
//  Created by Puntillo Andrew J. on 3/19/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class AttackButton {
    
    //Sprite of the button
    let buttonSprite = SKSpriteNode(imageNamed: "attack_button")
    //Weak ref to scene
    weak var scene: GameScene?
    
    func start(size:CGSize) {
        scene?.addChild(buttonSprite)
        buttonSprite.position = CGPoint(x: size.width - 400, y: 400)
        buttonSprite.alpha = 0.5
        buttonSprite.zPosition = CGFloat(10)
    }
    
    func onClick(loc:CGPoint) -> Bool {
        if (buttonSprite.frame.contains(loc)) {
                return true
        }
        return false
    }
}
