//
//  ElementFactory.swift
//  ElementalAcolyte
//
//  Created by Asante Kwasi G. on 3/15/18.
//  Copyright © 2018 Asante Kwasi G. All rights reserved.
//

import Foundation

class ElementFactory {
    
    func makeElement(elementType: ElementType?) -> Element{
        guard let elementType = elementType else{
            return randomElement()
        }
        return Element(type:elementType)
    }
    
    private func randomElement() -> Element{
        let rand: UInt32 = arc4random() % 3
        let elementType = ElementType(rawValue: rand)
        return Element(type: elementType!)
    }
}
