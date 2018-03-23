//
//  BaseTower.swift
//  XPaceInvaders
//
//  Created by Mazza Matthew J. on 3/8/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import Foundation
import SpriteKit

class Tower : BaseGameObject{
    
    var rateOfFire : Float
    var fireSpeed : Float
    var bIsFiring : Bool
    var currentTarget : BaseGameObject?
    
    override init(imagedName name: String) {
        rateOfFire = 1.0
        bIsFiring = false
        fireSpeed = 0.5
        
        super.init(imagedName: name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: TimeInterval){
        print(position.x)
    }
    
    func Fire(background: SKNode){
        
        if(currentTarget == nil){
            return
        }
        
        //print("firing")
        let projectile = Projectile(imagedName: "laserGreen05")
        let fireAction = SKAction.move(to: currentTarget!.position, duration: TimeInterval(fireSpeed))
        self.scene?.addChild(projectile)
        projectile.position = self.position
        projectile.zPosition = 1

        projectile.run(fireAction)
    }
    
    func GetClosestEnemy(enemyArray : [Enemy]){
        var nearestEnemy : Enemy?
        var distanceA : CGFloat
        var distanceB : CGFloat
        
        for e in enemyArray{
            //print("enemy found!")
            
            //if no enemy, set nearest to first in array
            if(nearestEnemy == nil){
                nearestEnemy = e
            }
            
            //check closest
            distanceA = self.position.distance(point: (nearestEnemy?.position)!)
            distanceB = self.position.distance(point: (e.position))
            
            //set new enemy if new enemy is closer
            if(distanceA >= distanceB){
                nearestEnemy = e
            }
        }
        
        if(nearestEnemy == nil){
            return
        }
        
        currentTarget = nearestEnemy
        
    }
}

extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}
