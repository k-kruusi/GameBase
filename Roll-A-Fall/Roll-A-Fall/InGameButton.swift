//
//  InGameButton.swift
//  Roll-A-Fall
//
//  Created by Stefen Matias on 2018-03-08.
//  Copyright © 2018 Stefen Matias. All rights reserved.
//

import Foundation
import SpriteKit
class InGameButton: Gameobject {
    
    var buttonType : String
    
    init (StartingPosition: CGPoint, ButtonNameId: String, Type: String) {
        self.buttonType = Type

        
        //References the super class (Gameobject) and initilizes it  within this class
        super.init(NameId: ButtonNameId, zPos: 2, transparency: 1)
        
        self.position = StartingPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ifClicked(currentPlayerMovementSpeed: CGFloat){
        //Button Will Animate By scaling larger then going back to its original size
        
        
      /*  switch buttonType {
        case speedUp:
            <#code#>
        case speedDown:
        default:
            <#code#>
        }
 
    }*/
        
        
        
        //Is Player Trying To Jump
        
        
        
    }
    
    
}
