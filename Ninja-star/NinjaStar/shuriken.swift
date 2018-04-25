//
//  shuriken.swift
//  NinjaStar
//
//  Created by adid nissan on 2018-04-15.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import Foundation

import UIKit

import SpriteKit

final class Shuriken: SKSpriteNode {
    
    var playersPosition: CGPoint
    var shurikenOrigin: CGPoint
    var shurikenDirection: CGPoint
    var orientation: Double
    
    //the value used to throw the shuriken
    var unitVectorDir: CGPoint
    
    
    init(playerPos: CGPoint){
        playersPosition = playerPos
        shurikenDirection = CGPoint()
        unitVectorDir = CGPoint()
        shurikenOrigin = CGPoint()
        orientation = 0
        //set up the texture
        let texture = SKTexture(imageNamed: "shuriken")
        let boxSize: CGSize = CGSize(width: texture.size().width/20, height: texture.size().height/20)
        super.init(texture: texture, color: .clear, size: boxSize)
        name = "shuriken"
        //speed of the shuriken
        speed = 10
        
        //set up the shuriken position
        position.x = playerPos.x
        position.y = playerPos.y
        
        //put the shuriken closer to the screen
        zPosition = 10
        
        //phyiscs body
        self.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        self.physicsBody?.affectedByGravity = false
        if let physics = physicsBody {
            physics.mass = 0
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = true
            physics.contactTestBitMask = 0b0001
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        playersPosition = CGPoint()
        shurikenDirection = CGPoint()
        unitVectorDir = CGPoint()
        shurikenOrigin = CGPoint()
        orientation = 0
        
        super.init(coder: aDecoder)
    }
    
    func shoot(shurikenOrgn: CGPoint, shurikenDir: CGPoint){
        shurikenOrigin = shurikenOrgn
        shurikenDirection = shurikenDir
        orientation = Orientation()
        
        //create a line from the player's center to the direction of the swipe, then normalize it
        let shurikenLine = CGPoint(x: shurikenDir.x - shurikenOrgn.x, y: shurikenDir.y - shurikenOrgn.y)
        unitVectorDir = Normalize(vector: shurikenLine)
        //if orientation is negative, then multiply the unit vector by -1
        if(orientation < 90 && orientation > 270){
            unitVectorDir.x *= -1
            unitVectorDir.y *= -1
        }
        
        
    }
    
    //calculate orientation
    func Orientation() -> Double{
        let TWOPI = 6.2831853071795865
        let RAD2DEG = 57.2957795130823209
        
        var theta: Double = Double(atan2(shurikenDirection.x - shurikenOrigin.x, shurikenOrigin.y - shurikenDirection.y))
        if (theta < 0){
            theta += TWOPI;
        }
        
        return Double(RAD2DEG * theta);
    }
    
    func Normalize(vector: CGPoint)-> CGPoint{
        //find the magnitude
        let magnitude = sqrt((vector.x * vector.x) + (vector.y * vector.y))
        //find the unit vector
        let unitVector = CGPoint(x: vector.x/magnitude, y:vector.y/magnitude)
        return unitVector
    }
    
    func UpdateShuriken(){
        //update speed
        position.x += unitVectorDir.x * speed
        position.y += unitVectorDir.y * speed
        zRotation += 4
    }
}
