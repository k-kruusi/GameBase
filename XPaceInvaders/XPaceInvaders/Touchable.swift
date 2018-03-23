//
//  Touchable.swift
//  XPaceInvaders
//
//  Created by Matthew Mazza on 2018-03-21.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

protocol Touchable: class {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
}
