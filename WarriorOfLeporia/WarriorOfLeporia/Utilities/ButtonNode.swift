//
//  ButtonNode.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/19/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import Foundation
import SpriteKit

class ButtonNode : SKSpriteNode {
    
    let onButtonPress: () -> ()
    
    var pressed = false
    var pressOnly = true
    
    init(iconName: String, text: String, onButtonPress: @escaping () -> (), pressOnly: Bool) {
        
        self.onButtonPress = onButtonPress
        self.pressOnly = pressOnly
        let texture = SKTexture(imageNamed: "button")
        super.init(texture: texture, color: SKColor.white, size: texture.size())
        
    //    let icon = SKSpriteNode(imageNamed: iconName)
   //     icon.position = CGPoint(x: -size.width * 0.25, y: 0)
   //     icon.zPosition = 1
   //     self.addChild(icon)
        
        let label = SKLabelNode(fontNamed: "Courier-Bold")
        label.fontSize = 25
        label.fontColor = SKColor.black
        label.position = CGPoint(x: 0, y: 0)
        label.zPosition = 1
        label.verticalAlignmentMode = .center
        label.text = text
        self.addChild(label)
        
        isUserInteractionEnabled = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed = true
        if (pressOnly) {
            onButtonPress()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
