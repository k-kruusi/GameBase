//
//  Zombie.swift
//  ZombieConga
//
//  Created by Mahboob Khizer on 2/15/18.
//  Copyright © 2018 kevin. All rights reserved.
//

import Foundation
import SpriteKit

class Zombie : GameObject{
    enum EType {
        case Big
        case Medium
        case Small
    }
    
    var myType : EType?
    
    init(){
        super.init(imageName: "zombie1", pos: CGPoint(x: 150,y: 450))
        self.SetEType(newType: EType.Small)
    }
    
    func SetEType(newType : EType){
        myType = newType
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
