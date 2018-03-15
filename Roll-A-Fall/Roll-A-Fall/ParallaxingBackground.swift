//
//  ParallaxingBackground.swift
//  Roll-A-Fall
//
//  Created by Stefen Matias on 2018-03-01.
//  Copyright © 2018 Stefen Matias. All rights reserved.
//

import Foundation
import SpriteKit

class ParallaxingBackground{
    
    let Background1: Gameobject
    let Background2: Gameobject
    
    //Position So Background can be background and game objects can operate at different layers
    // Asset Name, Z-Position, Alpha
    init(BackgroundImage01: Gameobject, BackgroundImage02: Gameobject, ScreenMax: CGPoint ) {
        
        self.Background1 = BackgroundImage01
        self.Background2 = BackgroundImage02
        
        BackgroundImage01.position = CGPoint(x:0,y:0)
        
        
        // Take Background Image and Find the value you need to scale each in order to fill the background.
        
        let xScale = ScreenMax.x / BackgroundImage01.position.x
        let yScale = ScreenMax.y / BackgroundImage01.position.y
        Background1.scale(to: CGSize(width: xScale,height: yScale))
        Background2.scale(to: CGSize(width: xScale,height: yScale))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func parralaxing(PlayerPosition: CGPoint) {
        
        if(PlayerPosition.x > Background1.position.x){
            Background1.position = CGPoint (x: Background1.position.x + Background1.size.width, y: Background1.position.y)
        }
        if(PlayerPosition.x > Background2.position.x){
            Background2.position = CGPoint (x: Background2.position.x + Background2.size.width, y: Background1.position.y)
        }
        
    }
    
    
}
