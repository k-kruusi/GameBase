//
//  Node.swift
//  NinjaStar
//
//  Created by adid nissan on 2018-04-16.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import Foundation

public class Node<T> {
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}
