//
//  CatLady.swift
//  ZombieConga
//
//  Created by Mahboob Khizer on 2/15/18.
//  Copyright © 2018 kevin. All rights reserved.
//

import Foundation
import SpriteKit

class CatLady : GameObject{
    
    init(){
        super.init(imageName: "enemy", pos: CGPoint(x: 1850,y: 450))
        moveSpeed = 30.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
