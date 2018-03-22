//
//  BaseGameObject.swift
//  Roll-A-Fall
//
//  Created by Stefen Matias on 2018-03-01.
//  Copyright © 2018 Stefen Matias. All rights reserved.
//

import Foundation
import SpriteKit

class Gameobject : SKSpriteNode{
    
    var vert01 : CGPoint = CGPoint()
    var vert02 : CGPoint = CGPoint()
    var vert03 : CGPoint = CGPoint()
    var vert04 : CGPoint = CGPoint()
    
    //Position So Background can be background and game objects can operate at different layers
    
    // Asset Name, Z-Position, Alpha
    init(NameId: String, zPos : CGFloat, transparency : CGFloat ) {
        
        //Get The Texture out of the assets.zcassets folder that is found through the initilization call
        let tex = SKTexture(imageNamed: NameId)
        // Color
        let col = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: transparency)
        
        //Size of texture inputed
        let s = tex.size()
        
        
        
        //References the super class (SKSpriteNode) and initilizes it  within this class
        super.init(texture: tex, color : col,size: s)
        self.zPosition = zPos
        self.vert01 = CGPoint(x: position.x - (size.width/2), y: position.y - (size.height/2))
        self.vert02 = CGPoint(x: position.x + (size.width/2), y: position.y - (size.height/2))
        self.vert03 = CGPoint(x: position.x + (size.width/2), y: position.y + (size.height/2))
        self.vert04 = CGPoint(x: position.x - (size.width/2), y: position.y + (size.height/2))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Function That Can Be Called When youre checking to see if an object is colliding with this object and you want the object to operate with a box collider and collide with a box collider. The object you input is the one with the box collider
    func isCollidingBox(positions: [CGPoint]) -> Bool {
        for position in positions {
            if(position.x > vert01.x && position.x < vert02.x && position.y > vert01.y && position.y < vert03.y ){
                return true
            }
        }
        return false
    }
    //USE IF POSITION HAS CHANGED SINCE INIT
    func updateCollider() {
        self.vert01 = CGPoint(x: position.x - (size.width/2), y: position.y - (size.height/2))
        self.vert02 = CGPoint(x: position.x + (size.width/2), y: position.y - (size.height/2))
        self.vert03 = CGPoint(x: position.x + (size.width/2), y: position.y + (size.height/2))
        self.vert04 = CGPoint(x: position.x - (size.width/2), y: position.y + (size.height/2))
    }
    
    
        //Function That Can Be Called When youre checking to see if an object is colliding with this object and you want the object to operate with a circle collider and collide with a box collider. The object you input is the one with the box collider
    /*func isCollidingCircle(positions: [CGPoint]) -> Bool {
        if( ) {
            
        }
    }*/
    
    
}

