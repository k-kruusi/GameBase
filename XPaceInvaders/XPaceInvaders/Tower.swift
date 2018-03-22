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
    
    var rateOfFire = Int(1.0)
    var bIsFiring = Bool(false)
    var currentTarget : BaseGameObject?
    
    override func update(currentTime: TimeInterval){
        print(position.x)
    }
    
    func Fire(){
        
        guard let currentTarget = currentTarget else{
            return
        }
        
        print("firing")
        let moveAction = SKAction.move(to: currentTarget.position, duration: 0.2)
        let projectile = Projectile(imagedName: "laserGreen05")
        projectile.position = self.position
        projectile.zPosition = 1

        projectile.run(moveAction)
    }
    
    func FindTarget(){
        //if cant find target, return? else call fire again?

        currentTarget = GetClosestEnemy()
        Fire()

    }
    
    func GetClosestEnemy() -> Enemy{

        var nearestEnemy : Enemy?
        var distanceA : CGFloat
        var distanceB : CGFloat

        for child in (self.scene?.children)!{
            if child is Enemy{
                if(nearestEnemy == nil){
                    nearestEnemy = child as! Enemy
                }

                else{
                    distanceA = self.position.distance(point: (nearestEnemy?.position)!)
                    distanceB = self.position.distance(point: (child.position))

                    if(distanceA >= distanceB){
                        nearestEnemy = child as! Enemy
                    }
                }
            }
        }
        return nearestEnemy!
    }
}

extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}
