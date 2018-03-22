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
        if(currentTarget == nil){
            FindTarget()
        }
        
        let projectile = Projectile(imagedName: "laserGreen05")
        projectile.move(toParent: currentTarget!)
    }
    
    func FindTarget(){
        //if cant find target, return? else call fire again?
        
        var closest = currentTarget
        
        for child in (self.scene?.children)!{
            if child is Enemy{
                currentTarget = child as! Enemy
            }
        }
    }
    
    func GetClosest(){
        
    }
}
