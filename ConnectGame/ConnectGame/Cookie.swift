//
//  Cookie.swift
//  ConnectGame
//
//  Created by Romeo Vincenzo G. on 3/8/18.
//  Copyright © 2018 Romeo Vincenzo G. All rights reserved.
//

import SpriteKit

enum CookieType: Int {
    case unknown = 0, croissant, cupcake, danish, donut, macaroon, sugarCookie
    static func random() -> CookieType {
        return CookieType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }
    var spriteName: String {
        let spriteNames = [
            "Croissant",
            "Cupcake",
            "Danish",
            "Donut",
            "Macaroon",
            "SugarCookie"]
        
        return spriteNames[rawValue - 1]
    }
    
    var highlightedSpriteName: String {
        return spriteName + "-Highlighted"
    
    }
}

class Cookie : CustomStringConvertible, Hashable {
    
    var description: String {
        return "type:\(cookieType) square:(\(column),\(row))"
    }
    var column: Int
    var row: Int
    let cookieType: CookieType
    var sprite: SKSpriteNode?
    
    init(column: Int, row: Int, cookieType: CookieType) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
    }
    var hashValue: Int {
        return row*10 + column
    }
}
func ==(lhs: Cookie, rhs: Cookie) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}
