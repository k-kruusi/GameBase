//
//  SButton.swift
//  Test0
//
//  Created by Predko Brown Marya C. on 3/22/18.
//  Copyright © 2018 Predko Brown Marya C. All rights reserved.
// due to time it wasn't implemted as attended

import Foundation
import SpriteKit

class SButton: SKNode {
    
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: () -> Void
    
    init(defaultButtonImage: String, activeButtonImage: String,buttonAction: @escaping () -> Void){
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.isHidden = true
        action = buttonAction
        
        super.init()
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
        
        
    }
    //when touch begains
    func touchesBegan(_ touches: NSSet, with event: UIEvent) {
        activeButton.isHidden = false
        defaultButton.isHidden = true
    }
    //press and move mouse
    func touchesMoved(_ touches: NSSet, with event: UIEvent) {
        var touch: UITouch = touches.allObjects[0] as! UITouch
        var location: CGPoint = touch.location(in: self)
        
        if defaultButton.contains(location){
            activeButton.isHidden = false
            defaultButton.isHidden = true
        } else{
            activeButton.isHidden = true
            defaultButton.isHidden = false
        }
    }
    //mouse off
    func touchesEnded(_ touches: NSSet, with event: UIEvent) {
        var touch: UITouch = touches.allObjects[0] as! UITouch
        var location: CGPoint = touch.location(in: self)
        
        if defaultButton.contains(location){
            //made to move the ball
           SKAction.applyForce(CGVector(dx: 0, dy: 5),duration:2.0)
        }
        
        activeButton.isHidden = true
        defaultButton.isHidden = false
    }
    //requried
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    
}
