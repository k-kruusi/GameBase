//
//  DuckController.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. on 3/8/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//

import Foundation
import SpriteKit

class DuckController{
    //just have one duck for now then have about 3-5 later
    let duck = Duck(imagePath: "Duck")
    
    required init(){
        //set the initial position of the duck above the screen
        duck.position = CGPoint(x: 1000, y: 1750) //temp values, change later
    }
    
    //returns all ducks on current controller
    public func getAllDucks()->Duck{
        return duck
    }
    
    //update all of the ducks
    func update(_deltaTime: TimeInterval){
        duck.update(_deltaTime: _deltaTime)
    }
}
