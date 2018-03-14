//
//  KidFactory.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 3/14/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit

class KidFactory {
    
    private func pickupKid(_ type : KidType) -> Kid {
        
        switch type {
        case .Kid1:
            return Kid(KidType: .Kid1)
        case .Kid2:
            return Kid(KidType: .Kid2)
        case .Kid3:
            return Kid(KidType: .Kid3)
        default:
            fatalError()
        }
    }
    
    func CreateKid(KidType: KidType?) -> Kid {
        
        guard let KidType = KidType else {
            let rand = Int(arc4random_uniform(2))
            let type = KidType(value: rand)!
            return pickupKid(type)
        }
        
        return pickupKid(KidType)
    }
    
}
