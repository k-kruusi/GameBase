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
    let maxDucks = 5
    var ducks:[Duck] = []
    
    required init(){
        //set the initial positions of the ducks above the screen
        var i = 0
        while (i < maxDucks){
            //appends the ducks created
            let duck = Duck(imagePath: "Duck")
            //duck.position = CGPoint(x: 1025, y: 1750) //temp values, change later
            ducks.append(duck)
            i += 1
        }
    }
    
    //returns all ducks on current controller
    public func getAllDucks()->Array<Duck>{
        return ducks
    }
    
    //update all of the ducks
    func update(_ deltaTime: TimeInterval){
        //update all of the ducks in the array
        for duck in ducks{
            duck.update(deltaTime)
        }
    }
}
