//
//  Level.swift
//  ConnectGame
//
//  Created by Romeo Vincenzo G. on 3/8/18.
//  Copyright © 2018 Romeo Vincenzo G. All rights reserved.
//

import Foundation

let NumColumns = 9
let NumRows = 9

class Level {
    fileprivate var cookies = Array2D<Cookie>(columns: NumColumns, rows: NumRows)
    func cookieAt(column: Int, row: Int) -> Cookie? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return cookies[column, row]
    }
    func shuffle() -> Set<Cookie>{
        return createInitialCookies()
    }
    
    private func createInitialCookies() -> Set<Cookie> {
        var set = Set<Cookie>()
        
        //FOR ROW 1
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                
                // FOR ROW 2
                var cookieType = CookieType.random()
                
                // FOR ROW 3
                let cookie = Cookie(column: column, row: row, cookieType: cookieType)
                cookies[column, row] = cookie
                
                // FOR ROW 4
                set.insert(cookie)
            }
        }
        return set
    }
        
        
        
        
        
        
        
    }



