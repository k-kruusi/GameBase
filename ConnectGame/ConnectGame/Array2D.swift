//
//  Array2D.swift
//  ConnectGame
//
//  Created by Romeo Vincenzo G. on 3/8/18.
//  Copyright © 2018 Romeo Vincenzo G. All rights reserved.
//

struct Array2D<T> {
    let columns: Int
    let rows: Int
    fileprivate var array: Array<T?>
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(repeating: nil, count: rows*columns)
    }
    subscript(column: Int, row: Int) -> T? {
        get {
        return array[row*columns + column]
        }set {
        array[row*columns + column] = newValue
        }
    }
}
