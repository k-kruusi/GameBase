//
//  Updateable.swift
//  XPaceInvaders
//
//  Created by Matthew Mazza on 2018-03-21.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import Foundation

protocol Updatable: class {
    func update(currentTime: TimeInterval)
}
